//
//  Vector.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation

class Vector {
    var x: Double = 0
    var y: Double = 0
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func flip() {
        let temp = self.x
        self.x = -y
        self.y = temp
    }
    
    func half() {
        self.x = self.x / 2
        self.y = self.y / 2
    }
    
    func angleRadians() -> Double {
        return atan2(self.x, self.y)
    }
    
    func angleDegrees() -> Double {
        return angleRadians().radiansToDegrees
    }
    
    func length() -> Double {
        return sqrt(pow(self.x, 2) + pow(self.y, 2))
    }
    
    func rotate(by degrees: Double) {
        let radians = degrees.degreesToRadians
        
        let cs = cos(radians)
        let sn = sin(radians)
        
        let newX: Double = self.x * cs - self.y * sn
        let newY: Double = self.x * sn + self.y * cs
        
        self.x = newX
        self.y = newY
    }
}
