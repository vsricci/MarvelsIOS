//
//  Characters.swift
//  Marvels
//
//  Created by Vinicius Ricci on 4/12/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation

struct Characters: Codable {
    
    var name: String?
    var thumbnail : Thumbnail?
    
    
    init(name: String, thumbnail: Thumbnail) {
        self.name = name
        self.thumbnail?.path = thumbnail.path
        self.thumbnail?.extension = thumbnail.extension
    }
}

struct Thumbnail : Codable {
    var path: String?
    var `extension` :  String?
    init(path: String, `extension`: String) {
        self.path = path
        
    }

}



