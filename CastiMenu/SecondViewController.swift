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
    @IBOutlet weak var segmEntree: UISegmentedControl!
    @IBOutlet weak var entreeMenu: UILabel!
    @IBOutlet weak var grillLabel: UILabel!
    @IBOutlet weak var segmGrill: UISegmentedControl!
    @IBOutlet weak var grillMenu: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var segmSoup: UISegmentedControl!
    @IBOutlet weak var soupMenu: UILabel!
    @IBOutlet weak var dessertLabel: UILabel!
    @IBOutlet weak var segmDessert: UISegmentedControl!
    @IBOutlet weak var dessertMenu: UILabel!
    @IBOutlet weak var done: UIBarButtonItem!
    
    var frequency = PFObject(className: "Frequency")
    var time = "0"
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    let menu = Singleton.sharedInstance
    var entree = ""
    var soup = ""
    var dessert = ""
    var grill = ""
    
    
    
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
    
    func initial(){
        let entree = menu.entreeString
        let grill = menu.grillString
        let soup = menu.soupString
        let dessert = menu.dessertString
        
        // setting label to the actual name of meal
        entreeMenu.text = entree
        grillMenu.text = grill
        soupMenu.text = soup
        dessertMenu.text = dessert
        
        // taking the meals and stripping spaces out
        self.entree = entree.stringByReplacingOccurrencesOfString(" ", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        self.grill = grill.stringByReplacingOccurrencesOfString(" ", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        self.soup = soup.stringByReplacingOccurrencesOfString(" ", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        self.dessert = dessert.stringByReplacingOccurrencesOfString(" ", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        //dessert1 = dessert1.stringByReplacingOccurrencesOfString("!", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        

        frequency["\(self.grill)"] = "1"
        frequency["\(self.entree)"] = "2"
        frequency["\(self.soup)"] = "3"
        frequency["\(self.dessert)"] = "4"
    }
    
    @IBAction func index(sender: AnyObject) {
        if sender as! NSObject == segmGrill {
            switch segmGrill.selectedSegmentIndex {
            case 0:
                grillLabel.text = "N/A";
                frequency["\(self.grill)"] = "N/A"
                
            case 1:
                grillLabel.text = "Less";
                frequency["\(self.grill)"] = "Less"
            case 2:
                grillLabel.text = "Same";
                frequency["\(self.grill)"] = "Same"
            case 3:
                grillLabel.text = "More";
                frequency["\(self.grill)"] = "More"
            default:
                break;
            }
            println("\(grillLabel.text)")
        } else if sender as! NSObject == segmEntree {
            switch segmEntree.selectedSegmentIndex {
            case 0:
                entreeLabel.text = "N/A";
                frequency["\(self.entree)"] = "N/A"
            case 1:
                entreeLabel.text = "Less";
                frequency["\(self.entree)"] = "Less"
            case 2:
                entreeLabel.text = "Same";
                frequency["\(self.entree)"] = "Same"
            case 3:
                entreeLabel.text = "More";
                frequency["\(self.entree)"] = "More"
            default:
                break;
            }
            println("\(entreeLabel.text)")
        } else if sender as! NSObject == segmSoup {
            switch segmSoup.selectedSegmentIndex {
            case 0:
                soupLabel.text = "N/A";
                frequency["\(self.soup)"] = "N/A"
            case 1:
                soupLabel.text = "Less";
                frequency["\(self.soup)"] = "Less"
            case 2:
                soupLabel.text = "Same";
                frequency["\(self.soup)"] = "Same"
            case 3:
                soupLabel.text = "More";
                frequency["\(self.soup)"] = "More"
            default:
                break;
            }
            println(frequency["\(soupLabel.text)"])
        } else if sender as! NSObject == segmDessert {
            switch segmDessert.selectedSegmentIndex {
            case 0:
                dessertLabel.text = "N/A";
                frequency["\(self.dessert)"] = "N/A"
            case 1:
                dessertLabel.text = "Less";
                frequency["\(self.dessert)"] = "Less"
            case 2:
                dessertLabel.text = "Same";
                frequency["\(self.dessert)"] = "Same"
            case 3:
                dessertLabel.text = "More";
                frequency["\(self.dessert)"] = "More"
            default:
                break;
            }
            println("\(dessertLabel.text)")
        }
    }
   
    @IBAction func done(sender: AnyObject) {
        println(frequency["\(self.dessert)"])
        println(frequency["\(self.soup)"])
        println(frequency["\(self.entree)"])
        println(frequency["\(self.grill)"])
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
        //This code saves the value "\(time)" to a key named "Time".
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