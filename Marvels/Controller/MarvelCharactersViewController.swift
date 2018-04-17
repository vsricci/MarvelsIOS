//
//  MarvelCharactersViewController.swift
//  Marvels
//
//  Created by Vinicius Ricci on 12/04/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import CryptoSwift
import SDWebImage
import ParallaxHeader
class MarvelCharactersViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var marvelCharactersPersonImage : UIImageView = UIImageView()

    var dataMarvelsCharacters : Characters!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = dataMarvelsCharacters.name
        print(dataMarvelsCharacters.name)
        let date1 = DateFormatter()
        date1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = date1.string(from: Date())
        
        print(dateString)
        //        var date = Date().timeIntervalSinceReferenceDate.description
        //        print(date)
        let hash = "\(dateString)\(secretKey)\(apiKey)".md5()
        print(hash)
        
        getComicsCharactersID(characterID: dataMarvelsCharacters.id!, date: dateString, apikey: apiKey, hash: hash)
        
        tableView.separatorStyle = .singleLine
        marvelCharactersPersonImage.sd_setImage(with: URL(string: (dataMarvelsCharacters.thumbnail?.path)! + "." + (dataMarvelsCharacters.thumbnail?.extension)!), placeholderImage: UIImage(named: ""), options: .cacheMemoryOnly, completed: nil)
        marvelCharactersPersonImage.contentMode = .scaleToFill
        marvelCharactersPersonImage.blurView.setup(style: .dark, alpha: 1)
        
        tableView.parallaxHeader.view = marvelCharactersPersonImage
        tableView.parallaxHeader.height = 300
        tableView.parallaxHeader.minimumHeight = 0
        tableView.parallaxHeader.mode = .centerFill
        tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            //update alpha of blur view on top of image view
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
        
    }
    
    func getComicsCharactersID(characterID: Int, date: String, apikey: String, hash: String) {
        
        MarvelsCharactersAPIManager.sharedInstance.getComicsCharactersID(url: Urls.urlMarvelComicsCharactersID.rawValue, characterID: characterID, hash: hash, date: date) { (result, statusCode) in
            
            if let description = result as? String {
                
                print(description)
                print(statusCode)
            }
           
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let y = 300 - (scrollView.contentOffset.y + 200)
//
//        let height = min(max(y, 200), 700)
//
//        marvelCharactersPersonImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
//
//    }
}

extension MarvelCharactersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "Em breve mais atualizações"
        return cell
    }
    
}
