//
//  CharactersCell.swift
//  Marvels
//
//  Created by Vinicius Ricci on 4/12/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import SDWebImage
class CharactersCell : UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func showCharactersMarvelCell(charactersDetails : Characters) {
        
        image.sd_setImage(with: URL(string: (charactersDetails.thumbnail?.path)!+"."+(charactersDetails.thumbnail?.extension)!), placeholderImage: UIImage(named:""), options: .cacheMemoryOnly, completed: nil)
    }
}
