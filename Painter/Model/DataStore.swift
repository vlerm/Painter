//
//  DataStore.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//

import Foundation
import UIKit

class DataStore {
    
    static var colorsForLines: [UIColor] = [
        UIColor.systemRed, UIColor.systemBlue, UIColor.systemPink, UIColor.systemTeal,
        UIColor.systemGray, UIColor.systemGray3, UIColor.systemGray4, UIColor.systemGray5,
        UIColor.systemGray6, UIColor.systemGreen,UIColor.systemOrange, UIColor.systemYellow,
        UIColor.systemPurple, UIColor.systemIndigo, UIColor.systemFill, UIColor.systemBackground
    ]
    
    static var namesOfImage: [Figure] = [
        Figure(nameForImage: "Circle.png", type: .circle),
        Figure(nameForImage: "Rect.png", type: .rectangle),
        Figure(nameForImage: "Straight.png", type: .straight),
        Figure(nameForImage: "Triangle.png", type: .triangle),
        Figure(nameForImage: "Line.png", type: .line),
        Figure(nameForImage: "RectWithCornRadius.png", type: .rectangleWithCornersRadius)
    ]
    
}
