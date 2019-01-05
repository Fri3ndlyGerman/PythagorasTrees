//
//  Triangle.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation
import UIKit

class Triangle {
    var currentBranchDepth: Int = 0
    var bottomLeft: CGPoint?
    var bottomRight: CGPoint?
    var top: CGPoint?
    weak var delegate: TreeDelegate? = tree!
    var parentTree: Tree = tree!
    
    init(left: CGPoint, right: CGPoint, branchDepth: Int) {
        self.currentBranchDepth = branchDepth
        self.bottomLeft = left
        self.bottomRight = right
        self.generateTopPoint()
    }
    
    func generateTopPoint() {
        let vector: Vector = bottomLeft!.vector(to: bottomRight!)
        vector.half()
        let midPoint = bottomLeft!.newPoint(with: vector)
        vector.rotate(by: randomAngle())
        self.top = midPoint.newPoint(with: vector)
        
        _ = Square(bottomLeft: self.bottomLeft!, bottomRight: self.top!, branchDepth: self.currentBranchDepth + 1)
        _ = Square(bottomLeft: self.top!, bottomRight: self.bottomRight!, branchDepth: self.currentBranchDepth + 1)
    }
    
    func randomAngle() -> Double {
        let alpha = drand48() * 30 + 30
        let beta = 90 - alpha
        return (180 - (beta * 2))
    }
}
