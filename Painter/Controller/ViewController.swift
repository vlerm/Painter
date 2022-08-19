//
//  ViewController.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import UIKit

protocol SaveImageProtocol: AnyObject {
    func save(image: Picture)
}

class ViewController: UIViewController {
    
    var rightBarButtonItem = UIBarButtonItem()
    
    let collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 2
        collectionViewFlowLayout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "Picture")
        collectionView.register(NewFileCollectionViewCell.self, forCellWithReuseIdentifier: "New")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        updateNavigationTitle()
        navigationItem.rightBarButtonItem = rightBarButtonItem
        configurateCollectionView()
        view.backgroundColor = UIColor.systemPink
    }
    
    func updateNavigationTitle() {
        navigationItem.title = "You have \(Pictures.pictures.count) pictures"
    }
    
    func pushDrawViewController() {
        let toolViewController = ToolsViewController()
        toolViewController.delegate = self
        navigationController?.pushViewController(toolViewController, animated: true)
    }
    
    func configurateCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func addAction() {
        pushDrawViewController()
    }
    
}
