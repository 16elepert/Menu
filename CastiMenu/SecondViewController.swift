//
//  SecondViewController.swift
//  CastiMenu
//
//  Created by Emily2 on 4/3/15.
//  Copyright (c) 2015 Emily L. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var entreeLabel: UILabel!
    @IBOutlet weak var entreeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // code below is from: http://makeapppie.com/2014/10/21/swift-swift-formatting-a-uipickerview/
    
    @IBAction func entreeSlider(sender: AnyObject) {
        if 0 <= entreeSlider.value && entreeSlider.value < 0.5 {
            entreeSlider.value = 0
            entreeLabel.text = "N/A"
        } else if 0.5 <= entreeSlider.value && entreeSlider.value < 1.5 {
            entreeSlider.value = 1
            entreeLabel.text = "Less"
        } else if 1.5 <= entreeSlider.value && entreeSlider.value < 2.5 {
            entreeSlider.value = 2
            entreeLabel.text = "Neutral"
        } else if 2.5 <= entreeSlider.value && entreeSlider.value < 3 {
            entreeSlider.value = 3
            entreeLabel.text = "More"
        }
}
}