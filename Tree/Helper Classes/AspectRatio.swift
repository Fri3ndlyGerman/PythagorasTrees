//
//  AspectRatio.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation
import UIKit

class AspectRatio {
    var width: CGFloat
    var height: CGFloat
    var constant: CGFloat
    
    static let standart = AspectRatio(width: 16, height: 9)
    static let wideScreenMonitor = AspectRatio(width: 21, height: 9)
    static let oldTV = AspectRatio(width: 4, height: 3)
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        self.constant = width / height
    }
    
    func width(for height: CGFloat) -> CGFloat {
        return height * (self.width / self.height)
    }
    
    func height(for width: CGFloat) -> CGFloat {
        return width * (self.height / self.width)
    }
}
