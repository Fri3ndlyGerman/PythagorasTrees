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
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var drawingView: UIView!
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        desiredBranchDepth = Int(sender.value)
    }
    
    @IBAction func generateTree(_ sender: UIButton) {
        targetBranchDepth = self.desiredBranchDepth
        tree = Tree(targetBranchDepth: targetBranchDepth, parentView: drawingView)
        tree?.firstSquare()
    }
    
    @IBAction func saveTree(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateButton.roundCorners(.all, radius: 10)
        saveButton.roundCorners(.all, radius: 10)
    }
}

