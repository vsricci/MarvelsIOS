//
//  MarvelsCharactersAPIManager.swift
//  Marvels
//
//  Created by Vinicius Ricci on 10/04/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import Alamofire

class MarvelsCharactersAPIManager {
    
     let manager = Alamofire.SessionManager.default
     static let sharedInstance = MarvelsCharactersAPIManager()
     func getCharacters(url: String, hash: String, date: String, apiKey: String, completion: @escaping(Any?, Any?) -> Void) {
        
        let urlRequest = "\(url)\(date)&apikey=\(apiKey)&hash=\(hash)"
        let headers : HTTPHeaders = ["Content-Type": "application/json"]
        print(urlRequest)
        manager.request(urlRequest, method: .get).responseJSON { (response) in
            let statusCode = response.response?.statusCode
            
            switch response.result {
                
            case .success:
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    completion(nil, statusCode)
                    return
                }
                print(responseJSON)
                guard let dados = responseJSON["data"] as? [String:Any] else {
                    completion(nil, statusCode)
                    return
                }
                print(dados)
                guard let results = dados["results"] as? [[String: Any]] else {
                    completion(nil, statusCode)
                    return
                }
                for heroes in results {
                    let jsonData = try? JSONSerialization.data(withJSONObject: heroes, options: .prettyPrinted)
                    let reqJSONStr = String(data: jsonData!, encoding: .utf8)
                    let data = reqJSONStr?.data(using: .utf8)
                    let decode = try? JSONDecoder().decode(Characters.self, from: data!)
                    
                    completion(decode, nil)
                }
                

                
            case .failure(let error):
                completion(error.localizedDescription, statusCode)
            }
        }
        
    }
}
