//
//  Drawable.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation
import UIKit

class Drawable: UIBezierPath {
    var parentView: UIView!
    var path = UIBezierPath()
    
    init(parentView: UIView) {
        super.init()
        self.parentView = parentView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addToPath(points: [CGPoint], shouldClose: Bool = true) {
        self.move(to: points[0])
        
        for i in 1..<points.count {
            self.addLine(to: points[i])
        }
        
        if shouldClose {
            self.close()
        }
    }
    
    func draw() {
        if let sublayers = self.parentView.layer.sublayers {
            sublayers.forEach { (layer) in
                layer.removeFromSuperlayer()
            }
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = self.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1.00
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        self.parentView.layer.addSublayer(shapeLayer)
    }
}
