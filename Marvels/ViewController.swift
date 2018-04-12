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
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
}



