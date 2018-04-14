//
//  ViewController.swift
//  Marvels
//
//  Created by Vinicius Ricci on 10/04/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import CryptoSwift
import SDWebImage
class ViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var charactersArray = [Characters]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let date1 = DateFormatter()
        date1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = date1.string(from: Date())
        
        print(dateString)
//        var date = Date().timeIntervalSinceReferenceDate.description
//        print(date)
        let hash = "\(dateString)\(secretKey)\(apiKey)".md5()
        print(hash)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        collectionView!.collectionViewLayout = layout
        
        getCharacters(url: Urls.urlMarvelsCharacters.rawValue, hash: hash, date: dateString, apikey: apiKey)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func getCharacters(url: String, hash: String, date: String, apikey: String) {
        
        MarvelsCharactersAPIManager.sharedInstance.getCharacters(url: url, hash: hash, date: date, apiKey: apiKey) { (result, statusCode) in
            
            if let resultModel = result as? Characters {
                
                    self.charactersArray.append(resultModel)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
            }
        }
    }
    
    func showDetailsCharactersMarvelComics(charactersDetails : Characters) {
        
        let marvelsCharactersDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "") as! MarvelCharactersViewController
        marvelsCharactersDetailsVC.dataMarvelsCharacters = charactersDetails
        self.navigationController?.pushViewController(marvelsCharactersDetailsVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "marvelcharactersDetailsStoryboardSegueID" {
            let navigationSegue = segue.destination as! MarvelCharactersViewController
            if let indexPath = self.collectionView.indexPathsForSelectedItems?[0] {
                
                let marvelcharactersDetails = self.charactersArray[indexPath.row]
                navigationSegue.dataMarvelsCharacters = marvelcharactersDetails
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.charactersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharactersCell
        let charactersDetails = self.charactersArray[indexPath.row]
        cell.showCharactersMarvelCell(charactersDetails: charactersDetails)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        return CGSize(width: width*0.49, height: height*0.4)
    }
}



