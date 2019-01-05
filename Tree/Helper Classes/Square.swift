//
//  Square.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation
import UIKit

class Square {
    var currentBranchDepth: Int = 0
    var bottomLeft: CGPoint?
    var bottomRight: CGPoint?
    var topLeft: CGPoint?
    var topRight: CGPoint?
    var points = [CGPoint]()
    weak var delegate: TreeDelegate? = tree!
    var parentTree: Tree = tree!
    
    public init() {
        self.bottomLeft = CGPoint(x: -10, y: -60)
        self.bottomRight = CGPoint(x: 10, y: -60)
        self.findTopPoints()
    }
    
    init(bottomLeft: CGPoint, bottomRight: CGPoint, branchDepth: Int) {
        self.currentBranchDepth = branchDepth
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
        self.findTopPoints()
    }
    
    func findTopPoints() {
        let vector: Vector = self.bottomLeft!.vector(to: bottomRight!)
        
        vector.flip()
        topLeft = self.bottomLeft!.newPoint(with: vector)
        topRight = self.bottomRight!.newPoint(with: vector)
        
        self.points = [self.bottomLeft!, self.bottomRight!, self.topRight!, self.topLeft!]
        delegate?.calculated(square: self)
        
        if self.currentBranchDepth < targetBranchDepth {
            _ = Triangle(left: self.topLeft!, right: self.topRight!, branchDepth: self.currentBranchDepth)
            // Create next triangle, maybe use delegate to inform drawing center
        } else {
            delegate?.incrementFinishCounter()
        }
    }
}
