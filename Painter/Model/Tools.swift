//
//  Tools.swift
//  Painter
//
//  Created by Вадим Лавор on 1.12.21.
//


import Foundation
import UIKit

class Tools {
    
    func callWantedDrawFunc(tool: ToolType, line: [CGPoint]) -> UIBezierPath{
        switch tool {
        case .circle:
            return drawCircle(line: line)
        case .rectangle:
            return drawRectangle(line: line)
        case .triangle:
            return drawTriangle(line: line)
        case .rectangleWithCornersRadius:
            return drawRectangleWithCornerRadius(line: line)
        case .line:
            return drawLine(line: line)
        case .straight:
            return drawStraight(line: line)
        }
    }
    
    func drawTriangle(line: [CGPoint]) -> UIBezierPath{
        guard let firstLine = line.first, let lastLine = line.last else {
            return UIBezierPath.init()
        }
        let rectangle = CGRect(x: firstLine.x, y: firstLine.y, width: lastLine.x - firstLine.x , height:  lastLine.y - firstLine.y)
        let bezierPath = UIBezierPath()
        let quar = calculateQuarter(firstLine: firstLine, lastLine: lastLine)
        bezierPath.move(to: firstLine)
        bezierPath.addLine(to: CGPoint(x: firstLine.x + quar.widthCoef * rectangle.width, y: firstLine.y))
        bezierPath.addLine(to: CGPoint(x: rectangle.origin.x + quar.widthCoef * rectangle.width/2, y: firstLine.y + quar.heightCoef * rectangle.height))
        bezierPath.close()
        return bezierPath
    }
    
    func drawRectangleWithCornerRadius(line: [CGPoint]) -> UIBezierPath {
        guard let firstLine = line.first, let lastLine = line.last else {
            return UIBezierPath.init()
        }
        let rectangle = CGRect(x: firstLine.x, y: firstLine.y, width: lastLine.x - firstLine.x , height:  lastLine.y - firstLine.y)
        let bezierPath = UIBezierPath.init(roundedRect: CGRect.init(x: firstLine.x, y: firstLine.y,
                                            width: rectangle.width,
                                            height: rectangle.height), cornerRadius: 15)
        return bezierPath
    }
    
    func drawStraight(line :[CGPoint]) -> UIBezierPath {
        guard let firstLine = line.first, let lastLine = line.last else {
            return UIBezierPath.init()
        }
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: firstLine)
        bezierPath.addLine(to: lastLine)
        return bezierPath
    }
    
    func drawLine(line: [CGPoint]) -> UIBezierPath {
        let bezierPath = UIBezierPath.init()
        for (i,point) in line.enumerated(){
            if i == 0{
                bezierPath.move(to: point)
            }else{
                bezierPath.addLine(to: point)
            }
        }
        return bezierPath
    }
    
    func drawRectangle(line: [CGPoint]) -> UIBezierPath {
        guard let firstLine = line.first, let lastLine = line.last else {
            return UIBezierPath.init()
        }
        let rectangle = CGRect(x: firstLine.x, y: firstLine.y, width: lastLine.x - firstLine.x , height:  lastLine.y - firstLine.y)
        let quarter = calculateQuarter(firstLine: firstLine, lastLine: lastLine)
        let bezierPath = UIBezierPath.init(rect: CGRect.init(x: firstLine.x, y: firstLine.y,
                                    width: quarter.widthCoef * rectangle.width,
                                    height: quarter.heightCoef * rectangle.height))
        return bezierPath
    }
    
    func drawCircle(line :[CGPoint]) -> UIBezierPath {
        guard let firstLine = line.first, let lastLine = line.last else {
            return UIBezierPath.init()
        }
        let rectForCircle = CGRect(x: firstLine.x, y: firstLine.y, width: lastLine.x - firstLine.x , height:  lastLine.y - firstLine.y)
        let quarter = calculateQuarter(firstLine: firstLine, lastLine: lastLine)
        let path = UIBezierPath.init(ovalIn: CGRect.init(x: firstLine.x, y: firstLine.y,
                                     width: quarter.widthCoef * rectForCircle.width,
                                     height: quarter.heightCoef * rectForCircle.height))
        return path
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    func calculateQuarter(firstLine: CGPoint, lastLine: CGPoint)->(widthCoef: CGFloat,heightCoef: CGFloat) {
        if lastLine.x > firstLine.x && lastLine.y > firstLine.y{
            return (1,1)
        } else if lastLine.x > firstLine.x && lastLine.y < firstLine.y{
            return (1,-1)
        } else if lastLine.x < firstLine.x && lastLine.y < firstLine.y{
            return (-1,-1)
        } else{
            return (-1,1)
        }
    }
    
}
