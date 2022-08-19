//
//  DrawViewController.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import UIKit

class DrawViewController: UIViewController {
    
    let drawViewForDrawsController = DrawView()
    let tools = Tools()
    var line: [CGPoint] = []
    var currentTool: ToolType = .line
    var color: UIColor = UIColor.red
    
    override func viewDidLoad() {
        view = drawViewForDrawsController
        view.backgroundColor = .white
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = "Gallery"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        line.append(point)
        let newPath = tools.callWantedDrawFunc(tool: currentTool, line: line)
        guard let lastLayer = view.layer.sublayers?.last as? CAShapeLayer else { return }
        lastLayer.path = newPath.cgPath
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        line = [CGPoint]()
        let pathForLayer = tools.callWantedDrawFunc(tool: currentTool, line: line)
        let shapelayer = CAShapeLayer()
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.strokeColor = color.cgColor
        shapelayer.lineWidth = 4
        shapelayer.path = pathForLayer.cgPath
        view.layer.addSublayer(shapelayer)
    }
    
}
