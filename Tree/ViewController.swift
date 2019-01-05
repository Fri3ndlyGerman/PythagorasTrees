//
//  ViewController.swift
//  Tree
//
//  Created by Henrik Panhans on 05.01.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import UIKit

var tree: Tree?
var targetBranchDepth = 0

class ViewController: UIViewController {
    private var desiredBranchDepth: Int = 5
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var branchDepthLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var drawingView: UIView!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        let availableWidth = sender.frame.width
        let sliderProgress = CGFloat((sender.value) / (sender.maximumValue))
        let valueToAdd = (availableWidth * sliderProgress) - (sliderProgress * self.branchDepthLabel.frame.width)
        leftConstraint.constant = -valueToAdd
        
        desiredBranchDepth = Int(sender.value) + 1
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
            self.branchDepthLabel.text = "\(self.desiredBranchDepth)"
        }
    }
    
    @IBAction func generateTree(_ sender: UIButton) {
        targetBranchDepth = self.desiredBranchDepth
        tree = Tree(targetBranchDepth: targetBranchDepth, parentView: self.drawingView)
        tree?.parentWidth = self.drawingView.frame.width
        tree?.parentHeight = self.drawingView.frame.height
        
        DispatchQueue.global(qos: .utility).async {
            tree?.firstSquare()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateButton.roundCorners(.all, radius: 10)
    }
}

