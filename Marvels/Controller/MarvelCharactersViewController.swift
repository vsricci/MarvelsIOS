//
//  MarvelCharactersViewController.swift
//  Marvels
//
//  Created by Vinicius Ricci on 12/04/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import CryptoSwift
class MarvelCharactersViewController: UIViewController {

    var dataMarvelsCharacters : Characters!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    }
    
    func getComicsCharactersID(characterID: Int, date: String, apikey: String, hash: String) {
        
        MarvelsCharactersAPIManager.sharedInstance.getComicsCharactersID(url: Urls.urlMarvelComicsCharactersID.rawValue, characterID: characterID, hash: hash, date: date) { (result, statusCode) in
            
            if let description = result as? String {
                
                print(description)
                print(statusCode)
            }
           
        }
    }

   

}
