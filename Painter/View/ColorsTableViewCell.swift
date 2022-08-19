//
//  ColorsTableViewCell.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import Foundation
import UIKit

class ColorsTableViewCell: UITableViewCell{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
}
