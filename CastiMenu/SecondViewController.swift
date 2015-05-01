//
//  SecondViewController.swift
//  CastiMenu
//
//  Created by Emily2 on 4/3/15.
//  Copyright (c) 2015 Emily L. All rights reserved.
//

import UIKit
import Parse

class SecondViewController: UIViewController {

    @IBOutlet weak var entreeLabel: UILabel!
    @IBOutlet weak var segEntree: UISegmentedControl!
    @IBOutlet weak var grillLabel: UILabel!
    @IBOutlet weak var segGrill: UISegmentedControl!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var segSoup: UISegmentedControl!
    @IBOutlet weak var saladLabel1: UILabel!
    @IBOutlet weak var segSalad1: UISegmentedControl!
    @IBOutlet weak var saladLabel2: UILabel!
    @IBOutlet weak var segSalad2: UISegmentedControl!
    
    let frequency = PFObject(className: "Frequency")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func indexGrill(sender: AnyObject) {
        if sender as! NSObject == segGrill {
            switch segGrill.selectedSegmentIndex {
                case 0:
                    grillLabel.text = "N/A";
                    frequency["GrillFrequency"] = "N/A"
                case 1:
                    grillLabel.text = "Less";
                    frequency["GrillFrequency"] = "Less"
                case 2:
                    grillLabel.text = "Same";
                    frequency["GrillFrequency"] = "Same"
                case 3:
                    grillLabel.text = "More";
                    frequency["GrillFrequency"] = "More"
                default:
                    break;
            }
        } else if sender as! NSObject == segEntree {
            switch segEntree.selectedSegmentIndex {
            case 0:
                entreeLabel.text = "N/A";
                frequency["EntreeFrequency"] = "N/A"
            case 1:
                entreeLabel.text = "Less";
                frequency["EntreeFrequency"] = "Less"
            case 2:
                entreeLabel.text = "Same";
                frequency["EntreeFrequency"] = "Same"
            case 3:
                entreeLabel.text = "More";
                frequency["EntreeFrequency"] = "More"
            default:
                break;
            }
        } else if sender as! NSObject == segSoup {
            switch segSoup.selectedSegmentIndex {
            case 0:
                soupLabel.text = "N/A";
                frequency["SoupFrequency"] = "N/A"
            case 1:
                soupLabel.text = "Less";
                frequency["SoupFrequency"] = "Less"
            case 2:
                soupLabel.text = "Same";
                frequency["SoupFrequency"] = "Same"
            case 3:
                soupLabel.text = "More";
                frequency["SoupFrequency"] = "More"
            default:
                break;
            }
        } else if sender as! NSObject == segSalad1 {
            switch segSalad1.selectedSegmentIndex {
            case 0:
                saladLabel1.text = "N/A";
                frequency["Salad1Frequency"] = "N/A"
            case 1:
                saladLabel1.text = "Less";
                frequency["Salad1Frequency"] = "Less"
            case 2:
                saladLabel1.text = "Same";
                frequency["Salad1Frequency"] = "Same"
            case 3:
                saladLabel1.text = "More";
                frequency["Salad1Frequency"] = "More"
            default:
                break;
            }
        } else if sender as! NSObject == segSalad2 {
            switch segSalad2.selectedSegmentIndex {
            case 0:
                saladLabel2.text = "N/A";
                frequency["Salad2Frequency"] = "N/A"
            case 1:
                saladLabel2.text = "Less";
                frequency["Salad2Frequency"] = "Less"
            case 2:
                saladLabel2.text = "Same";
                frequency["Salad2Frequency"] = "Same"
            case 3:
                saladLabel2.text = "More";
                frequency["Salad2Frequency"] = "More"
            default:
                break;
            }
        }
    }
   
    @IBAction func done(sender: AnyObject) {
        frequency.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved.")
        }
    }
}