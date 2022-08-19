//
//  Picture.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import UIKit

class Picture {

    var imageName: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        imageName = name
        self.image = image
    }
    
}
