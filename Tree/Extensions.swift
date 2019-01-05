//
//  Extensions.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: Corners, radius: CGFloat) {
        var cornerMasks = [CACornerMask]()
        
        // Top left corner
        switch corners {
        case .all, .top, .topLeft, .allButTopRight, .allButBottomLeft, .allButBottomRight, .topLeftBottomRight:
            cornerMasks.append(CACornerMask(rawValue: UIRectCorner.topLeft.rawValue))
        default:
            break
        }
        
        // Top right corner
        switch corners {
        case .all, .top, .topRight, .allButTopLeft, .allButBottomLeft, .allButBottomRight, .topRightBottomLeft:
            cornerMasks.append(CACornerMask(rawValue: UIRectCorner.topRight.rawValue))
        default:
            break
        }
        
        // Bottom left corner
        switch corners {
        case .all, .bottom, .bottomLeft, .allButTopRight, .allButTopLeft, .allButBottomRight, .topRightBottomLeft:
            cornerMasks.append(CACornerMask(rawValue: UIRectCorner.bottomLeft.rawValue))
        default:
            break
        }
        
        // Bottom right corner
        switch corners {
        case .all, .bottom, .bottomRight, .allButTopRight, .allButTopLeft, .allButBottomLeft, .topLeftBottomRight:
            cornerMasks.append(CACornerMask(rawValue: UIRectCorner.bottomRight.rawValue))
        default:
            break
        }
        
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(cornerMasks)
    }
    
    enum Corners {
        case all
        case top
        case bottom
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case allButTopLeft
        case allButTopRight
        case allButBottomLeft
        case allButBottomRight
        case left
        case right
        case topLeftBottomRight
        case topRightBottomLeft
    }
}

extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension CGPoint {
    func vector(to point: CGPoint) -> Vector {
        let deltaX = point.x - self.x
        let deltaY = point.y - self.y
        
        return Vector(x: Double(deltaX), y: Double(deltaY))
    }
    
    func newPoint(with vector: Vector) -> CGPoint {
        return CGPoint(x: self.x + CGFloat(vector.x), y: self.y + CGFloat(vector.y))
    }
}
