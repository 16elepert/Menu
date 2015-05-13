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
    @IBOutlet weak var entreeName: UILabel!
    @IBOutlet weak var grillLabel: UILabel!
    @IBOutlet weak var segGrill: UISegmentedControl!
    @IBOutlet weak var grillName: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var segSoup: UISegmentedControl!
    @IBOutlet weak var soupName: UILabel!
    @IBOutlet weak var segDessert: UISegmentedControl!
    @IBOutlet weak var dessertLabel: UILabel!
    @IBOutlet weak var dessertName: UILabel!
    @IBOutlet weak var done: UIBarButtonItem!
    
    var frequency = PFObject(className: "Frequency")
    var time = "0"
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    let menu = Singleton.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var date = NSDate()
        var outputFormat = NSDateFormatter()
        outputFormat.locale = NSLocale(localeIdentifier:"en_US")
        outputFormat.dateFormat = "yyyy-MM-dd"
        let today = outputFormat.stringFromDate(date)
        
        if let timer = prefs.stringForKey("Time"){
            if  timer != today {
                done.enabled = true
                println("ok")
            } else if timer == today {
                done.enabled = false
                println("bad")
            }
        } else {
            //Nothing stored in NSUserDefaults yet. Set a value.
            prefs.setValue("\(time)", forKey: "Time")
            println("nothing")
        }
        initial()
    }
    
    func initial() -> (String, String, String, String) {
        let entree = menu.entreeString
        let grill = menu.grillString
        let soup = menu.soupString
        let dessert = menu.dessertString
        
        
        entreeName.text = entree
        grillName.text = grill
        soupName.text = soup
        dessertName.text = dessert
    
        frequency["\(grill)"] = "N/A"
        frequency["\(entree)"] = "N/A"
        frequency["\(soup)"] = "N/A"
        frequency["\(dessert)"] = "N/A"

        return (entree, grill, soup, dessert)
    }
    
    @IBAction func indexGrill(sender: AnyObject) {
        var (entree, grill, soup, dessert) = initial()
        
        if sender as! NSObject == segGrill {
            switch segGrill.selectedSegmentIndex {
                case 0:
                    grillLabel.text = "N/A";
                    frequency["\(grill)"] = "N/A"
                case 1:
                    grillLabel.text = "Less";
                    frequency["\(grill)"] = "Less"
                case 2:
                    grillLabel.text = "Same";
                    frequency["\(grill)"] = "Same"
                case 3:
                    grillLabel.text = "More";
                    frequency["\(grill)"] = "More"
                default:
                    break;
            }
        } else if sender as! NSObject == segEntree {
            switch segEntree.selectedSegmentIndex {
            case 0:
                entreeLabel.text = "N/A";
                frequency["\(entree)"] = "N/A"
            case 1:
                entreeLabel.text = "Less";
                frequency["\(entree)"] = "Less"
            case 2:
                entreeLabel.text = "Same";
                frequency["\(entree)"] = "Same"
            case 3:
                entreeLabel.text = "More";
                frequency["\(entree)"] = "More"
            default:
                break;
            }
        } else if sender as! NSObject == segSoup {
            switch segSoup.selectedSegmentIndex {
            case 0:
                soupLabel.text = "N/A";
                frequency["\(soup)"] = "N/A"
            case 1:
                soupLabel.text = "Less";
                frequency["\(soup)"] = "Less"
            case 2:
                soupLabel.text = "Same";
                frequency["\(soup)"] = "Same"
            case 3:
                soupLabel.text = "More";
                frequency["\(soup)"] = "More"
            default:
                break;
            }
        } else if sender as! NSObject == segDessert {
            switch segDessert.selectedSegmentIndex {
            case 0:
                dessertLabel.text = "N/A";
                frequency["\(dessert)"] = "N/A"
            case 1:
                dessertLabel.text = "Less";
                frequency["\(dessert)"] = "Less"
            case 2:
                dessertLabel.text = "Same";
                frequency["\(dessert)"] = "Same"
            case 3:
                dessertLabel.text = "More";
                frequency["\(dessert)"] = "More"
            default:
                break;
            }
        }

    }
   
    @IBAction func done(sender: AnyObject) {
        frequency.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved.")
        }
        var date = NSDate()
        var outputFormat = NSDateFormatter()
        outputFormat.locale = NSLocale(localeIdentifier:"en_US")
        outputFormat.dateFormat = "yyyy-MM-dd"
        time = outputFormat.stringFromDate(date)
        //time = "1"
        prefs.setValue("\(time)", forKey: "Time")
        //This code saves the value "Berlin" to a key named "userCity".
        done.enabled = false
    }
    
    @IBAction func try(sender: AnyObject) {
        time = "1"
        prefs.setValue("\(time)", forKey: "Time")
        if let timer = prefs.stringForKey("Time"){
            println("\(time)")
        }else {
            println("nothing")
        }
    }
}