//
//  ExtensionForControllers.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Pictures.pictures.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "New", for: indexPath) as! NewFileCollectionViewCell
        return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureCollectionViewCell
        cell.configurateCell(name: Pictures.pictures[indexPath.row - 1].imageName, image: Pictures.pictures[indexPath.row - 1].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pushDrawViewController()
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width/2 - 1, height: view.bounds.width/2 - 1)
    }
    
}

extension ViewController: SaveImageProtocol {
    
    func save(image: Picture) {
        Pictures.pictures.insert(image, at: 0)
        updateNavigationTitle()
        collectionView.reloadData()
    }
    
}

extension ToolsViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tools", for: indexPath) as! ToolsCollectionViewCell
        cell.setImage(image: UIImage(named: DataStore.namesOfImage[indexPath.row].nameForImage) ?? UIImage())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.layer.cornerRadius = (60*1.5)/2.0
        })
        collectionView.performBatchUpdates(nil, completion: nil)
        drawViewController.currentTool = DataStore.namesOfImage[indexPath.row].type
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, animations: {
            cell?.layer.cornerRadius = 60 / 2.0
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 60, height: 60)
        if let selectedIndex = selectedIndexPath, selectedIndex.row == indexPath.row{
            size = CGSize(width: 60*1.5, height: 60*1.5)
            return size
        }
        return size
    }
    
}

extension ToolsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataStore.colorsForLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForColor =  tableView.dequeueReusableCell(withIdentifier: "color", for: indexPath) as! ColorsTableViewCell
        cellForColor.contentView.backgroundColor = DataStore.colorsForLines[indexPath.row]
        return cellForColor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        drawViewController.color = DataStore.colorsForLines[indexPath.row]
        buttonForPalette.backgroundColor = DataStore.colorsForLines[indexPath.row]
        UIView.animate(withDuration: 2.5, animations: {
            [weak self] in
            tableView.isHidden = true
            self?.buttonForPalette.isHidden = false
        })
    }
    
}
