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
    var parentHeight: CGFloat = 0
    var parentWidth: CGFloat = 0
    
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
        let availableHeight = aspectRatio.height(for: parentWidth)
        
        squares.forEach { (square) in
            var points = [CGPoint]()
            
            square.points.forEach({ (point) in
                let pointDeltaX = point.x - xLowerBound
                let pointDeltaY = point.y - yLowerBound
                
                let normalizedDeltaX = pointDeltaX / deltaX
                let normalizedDeltaY = pointDeltaY / deltaY
                
                let centeringPuffer = ((parentHeight - availableHeight) / 2)
                let newX = (parentWidth * normalizedDeltaX)
                let newY = availableHeight - (availableHeight * normalizedDeltaY) + centeringPuffer
                
                points.append(CGPoint(x: newX, y: newY))
            })
            
            square.points = points
            self.addToPath(points: points)
        }
        
        self.draw()
    }
}

protocol TreeDelegate: class {
    func calculated(square: Square)
    func incrementFinishCounter()
}
