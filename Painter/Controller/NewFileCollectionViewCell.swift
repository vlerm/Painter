//
//  NewFileCollectionViewCell.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import UIKit

class NewFileCollectionViewCell: UICollectionViewCell {
    
    let createLabel: UILabel = {
        let label = UILabel()
        label.text = "Create"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImage(named: "NewFile")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(createLabel)
        NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            createLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            createLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
