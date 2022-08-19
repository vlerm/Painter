//
//  ToolsViewController.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import UIKit

class ToolsViewController: UIViewController {
    
    weak var delegate: SaveImageProtocol?
    
    let drawViewController = DrawViewController()
    var selectedIndexPath: IndexPath?
    
    var buttonForPalette: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paintpalette"), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(tapOnPaletteAction), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionFromTools: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(ToolsCollectionViewCell.self, forCellWithReuseIdentifier: "tools")
        return collection
    }()
    
    lazy var leftGradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()
    
    lazy var rightGradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        return gradientLayer
    }()
    
    lazy var tableViewForColors: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: "color")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapOnPaletteAction()
        self.addChild(drawViewController)
        view.addSubview(drawViewController.view)
        buttonForPalette.isHidden = false
        tableViewForColors.isHidden = true
        setupConstraints()
        setupCollectonViewSideGradient()
        let rightBarButtonSave = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveImage))
        let rightBarButtonCancel = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(tapOnBar))
        navigationItem.rightBarButtonItems = [rightBarButtonCancel, rightBarButtonSave]
    }
    
    @objc func saveImage() {
        let imageRenderer = UIGraphicsImageRenderer(bounds: drawViewController.view.bounds)
        let image = imageRenderer.image { rendererContext in
            drawViewController.view.layer.render(in: rendererContext.cgContext)
        }
        let alertController = UIAlertController(title: "Name", message: nil, preferredStyle: .alert)
        var namedTextField: UITextField?
        var imageName = String()
        alertController.addTextField { text in
            namedTextField = text
            text.placeholder = "Enter picture name"
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            imageName = namedTextField?.text ?? "Unnamed image"
            let renderedImage = Picture.init(name: imageName, image: image)
            self.delegate?.save(image: renderedImage)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tapOnBar(){
        drawViewController.view.layer.sublayers?.removeLast()
        drawViewController.line = .init()
    }
    
    @objc func tapOnPaletteAction(){
        tableViewForColors.isHidden = false
        buttonForPalette.isHidden  = true
    }
    
    func setupCollectonViewSideGradient() {
        view.addSubview(rightGradientView)
        view.addSubview(leftGradientView)
        NSLayoutConstraint.activate([
            leftGradientView.topAnchor.constraint(equalTo: collectionFromTools.topAnchor, constant: 10),
            leftGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftGradientView.widthAnchor.constraint(equalToConstant: 15)
        ])
        NSLayoutConstraint.activate([
            rightGradientView.topAnchor.constraint(equalTo: collectionFromTools.topAnchor, constant: 10),
            rightGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rightGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightGradientView.widthAnchor.constraint(equalToConstant: 15)
        ])
        rightGradientLayer.removeFromSuperlayer()
        leftGradientLayer.removeFromSuperlayer()
        leftGradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 8, height: 80)
        leftGradientLayer.cornerRadius = 25
        leftGradientLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        rightGradientLayer.frame = CGRect(x: -32, y: 0, width: view.bounds.width / 8, height: 80)
        rightGradientLayer.cornerRadius = 25
        rightGradientLayer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        rightGradientView.layer.addSublayer(rightGradientLayer)
        leftGradientView.layer.addSublayer(leftGradientLayer)
    }
    
    func setupConstraints(){
        view.addSubview(collectionFromTools)
        view.addSubview(tableViewForColors)
        view.addSubview(buttonForPalette)
        drawViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonForPalette.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            buttonForPalette.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            buttonForPalette.widthAnchor.constraint(equalToConstant: 60),
            buttonForPalette.heightAnchor.constraint(equalTo: buttonForPalette.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            drawViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            drawViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            drawViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            drawViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            collectionFromTools.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionFromTools.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionFromTools.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            collectionFromTools.heightAnchor.constraint(equalToConstant: 120)
        ])
        NSLayoutConstraint.activate([
            tableViewForColors.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            tableViewForColors.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:34),
            tableViewForColors.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            tableViewForColors.widthAnchor.constraint(equalToConstant: 60)
        ])
        collectionFromTools.setNeedsLayout()
        collectionFromTools.layoutIfNeeded()
    }
    
}
