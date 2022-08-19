//
//  ToolsCollectionViewCell.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//


import UIKit

class ToolsCollectionViewCell: UICollectionViewCell {
    
    var imageViewForTools: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.layer.cornerRadius = frame.width/2.0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = frame.width/2.0
        layer.masksToBounds = false
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
        backgroundColor = .systemBlue
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage){
        imageViewForTools.image = image
    }
    
    func setupConstraint(){
        self.addSubview(imageViewForTools)
        NSLayoutConstraint.activate([
            imageViewForTools.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 6),
            imageViewForTools.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -6),
            imageViewForTools.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageViewForTools.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8)
        ])
    }
    
}
