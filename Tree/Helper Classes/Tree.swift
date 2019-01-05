//
//  Tree.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation
import UIKit

class Tree: Drawable, TreeDelegate {
    var squares = [Square]()
    var branchesFinished: Int = 0
    var targetBranchDepth: Int = 0
    
    init(targetBranchDepth: Int, parentView: UIView) {
        super.init(parentView: parentView)
        self.targetBranchDepth = targetBranchDepth
    }
    
    func firstSquare() {
        _ = Square()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func calculated(square: Square) {
        self.squares.append(square)
    }
    
    func incrementFinishCounter() {
        self.branchesFinished += 1
        
        if self.branchesFinished == Int(truncating: NSDecimalNumber(decimal: pow(2, targetBranchDepth))) {
            print("finished, we can do super intense hacking now")
            findOuterPoints()
        }
    }
    
    func formPath() {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        squares.forEach { (square) in
            path.move(to: square.points[0])
            square.points.forEach({ (point) in
                path.addLine(to: point)
            })
            path.close()
        }
        
        layer.path = path.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1
        layer.fillColor = UIColor.clear.cgColor
        
        if let sublayers = self.parentView.layer.sublayers {
            sublayers.forEach { (layer) in
                layer.removeFromSuperlayer()
            }
        }
        
        self.parentView.layer.addSublayer(layer)
    }
    
    func findOuterPoints() {
        var xUpperBound: CGFloat = 0.00
        var yUpperBound: CGFloat = 0.00
        var xLowerBound: CGFloat = 0.00
        var yLowerBound: CGFloat = 0.00
        squares.forEach { (square) in
            square.points.forEach({ (point) in
                if point.x > xUpperBound { xUpperBound = point.x }
                if point.x < xLowerBound { xLowerBound = point.x }
                if point.y > yUpperBound { yUpperBound = point.y }
                if point.y < yLowerBound { yLowerBound = point.y }
            })
        }
        
        let deltaX = xUpperBound - xLowerBound
        let deltaY = yUpperBound - yLowerBound
        let aspectRatio = AspectRatio(width: deltaX, height: deltaY)
        let availableWidth = self.parentView.frame.width
        let availableHeight = aspectRatio.height(for: availableWidth)
        
        squares.forEach { (square) in
            var points = [CGPoint]()
            
            square.points.forEach({ (point) in
                let pointDeltaX = point.x - xLowerBound
                let pointDeltaY = point.y - yLowerBound
                
                let normalizedDeltaX = pointDeltaX / deltaX
                let normalizedDeltaY = pointDeltaY / deltaY
                
                let centeringPuffer = ((self.parentView.frame.height - availableHeight) / 2)
                let newX = (availableWidth * normalizedDeltaX)
                let newY = availableHeight - (availableHeight * normalizedDeltaY) + centeringPuffer
                
                points.append(CGPoint(x: newX, y: newY))
                // Normalize point here
            })
            
            square.points = points
        }
        
        formPath()
    }
}

protocol TreeDelegate: class {
    func calculated(square: Square)
    func incrementFinishCounter()
}
