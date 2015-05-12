//
//  FirstViewController.swift
//  CastiMenu
//
//  Created by Emily2 on 4/3/15.
//  Copyright (c) 2015 Emily L. All rights reserved.
//

import UIKit
import Parse

extension String {
    public func split(separator: String) -> [String] {
        if separator.isEmpty {
            return map(self) { String($0) }
        }
        if var pre = self.rangeOfString(separator) {
            var parts = [self.substringToIndex(pre.startIndex)]
            while let rng = self.rangeOfString(separator, range: pre.endIndex..<endIndex) {
                parts.append(self.substringWithRange(pre.endIndex..<rng.startIndex))
                pre = rng
            }
            parts.append(self.substringWithRange(pre.endIndex..<endIndex))
            return parts
        } else {
            return [self]
        }
    }
    
    func indexOf(target: String) -> Int
    {
        var range = self.rangeOfString(target)
        if let range = range {
            return distance(self.startIndex, range.startIndex)
        } else {
            return -1
        }
    }
    
    subscript(integerIndex: Int) -> Character
        {
            let index = advance(startIndex, integerIndex)
            return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String
        {
            let start = advance(startIndex, integerRange.startIndex)
            let end = advance(startIndex, integerRange.endIndex)
            let range = start..<end
            return self[range]
    }
}

class FirstViewController: UIViewController {

    
    @IBOutlet weak var entreeLabel: UILabel!
    @IBOutlet weak var grillLabel: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var dessertLabel: UILabel!
    
    //var myMenu = OrderModel()
    
    let menu = Singleton.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let theURL = urlWithMovieType()
        let url:String? = performRequestWithURL(theURL)
        
        var date = NSDate()
        var outputFormat = NSDateFormatter()
        outputFormat.locale = NSLocale(localeIdentifier:"en_US")
        outputFormat.dateFormat = "yyyy-MM-dd"
        let today = outputFormat.stringFromDate(date)
        let final:[String] = dayofWeek(getDayOfWeek(today))
        
        monday(url, final: final)
        
        menu.entreeString = entreeLabel.text!
        menu.grillString = grillLabel.text!
        menu.soupString = soupLabel.text!
        menu.dessertString = dessertLabel.text!

    }
    
    func getDayOfWeek(today:String)->Int {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.dateFromString(today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.CalendarUnitWeekday, fromDate: todayDate)
        let weekDay = myComponents.weekday
        return weekDay
    }
    
    func dayofWeek(week: Int) -> [String] {
        var day = "no"
        var day2 = "no"
        if week == 1 || week == 7 || week == 2 {
            day = "Monday"
            day2 = "Tuesday"
        } else if week == 3 {
            day = "Tuesday"
            day2 = "Wednesday"
        } else if week == 4 {
            day = "Wednesday"
            day2 = "Thursday"
        } else if week == 5 {
            day = "Thursday"
            day2 = "Friday"
        } else if week == 6 {
            day = "Friday"
            day2 = "table"
        }
        var final = [day, day2]
        println(final)
        return final
    }

    
    func urlWithMovieType() -> NSURL {
        // Creates a URL from a given string
        // :param: movieType specifies the category of movie to specify in the URL
        // :return: the NSURL
        let urlString = String(format: "http://www.castilleja.org/page.cfm?p=940953")
        let url = NSURL(string: urlString)
        return url!
    }
    
    func performRequestWithURL(url: NSURL) -> String? {
        // Retrieves the requested information from the server
        // :param: url specifies the request
        // :returns: the requested information as a string, or nil if unsuccesful
        var errorCode: NSError?
        var result: String?
        if let resultString = String(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: &errorCode) {
            result = resultString
        } else if let error = errorCode {
            println("Download Error: \(errorCode)")
        } else {
            println("Unknown Download Error")
        }
        //println("\(result)")
        return result
    }
    
    // good website for strings -> http://sketchytech.blogspot.com/2014/08/swift-pure-swift-method-for-returning.html
    // http://www.learnswiftonline.com/reference-guides/string-reference-guide-for-swift/
    
    
    // http://stackoverflow.com/questions/27332992/swift-finding-a-substring-between-two-locations-in-a-string
    // https://gist.github.com/albertbori/0faf7de867d96eb83591
    func monday(url: String!, final:[String]) {
        var url = url.stringByReplacingOccurrencesOfString("&amp;", withString: "&" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        url = url.stringByReplacingOccurrencesOfString("&quot;", withString: "'" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        // find monday to tuesday string
        let firstDate = final[0]
        let secondDate = final[1]
        let monday = url.indexOf("\(firstDate)")
        let tuesday = url.indexOf("\(secondDate)")
        var startIndex = advance(url.startIndex, monday)
        var endIndex = advance(url.startIndex, tuesday)
        var range = startIndex..<url.endIndex
        if final[0] != "Monday" || final[0] != "Tuesday" || final[0] != "Wednesday" || final[0] != "Thursday" {
            range = startIndex..<url.endIndex
        } else {
            range = startIndex..<endIndex   // same as let range = Range(start: startIndex, end: endIndex)
        }
        url = url[range]
        
        // find monday to soup string and delete it
        var soup = url.indexOf("Soup")
        endIndex = advance(url.startIndex, soup)
        range = url.startIndex..<endIndex   // same as let range = Range(start: startIndex, end: endIndex)
        url = url.stringByReplacingOccurrencesOfString("\(url[range])", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        // retrieve the soup to < string and print it and store it, then delete it
        var end = url.indexOf("<")
        var beg = url.indexOf(":")
        startIndex = advance(url.startIndex, beg+2)
        endIndex = advance(url.startIndex, end)
        range = startIndex..<endIndex
        let mSoup = url[range]
        end = url.indexOf("Grill")
        range = url.startIndex..<endIndex
        url = url.stringByReplacingOccurrencesOfString("\(url[range])", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        println(mSoup)
        
        // delete text before the grill
        var grill = url.indexOf("Grill")
        end = url.indexOf("<")
        startIndex = advance(url.startIndex, end)
        endIndex = advance(url.startIndex, grill)
        range = startIndex..<endIndex
        url = url.stringByReplacingOccurrencesOfString("\(url[range])", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        // retrieve the grill text
        end = url.indexOf("Entree")
        beg = url.indexOf(":")
        startIndex = advance(url.startIndex, beg+2)
        endIndex = advance(url.startIndex, end)
        range = startIndex..<endIndex
        let mGrill = url[range]
        url = url.stringByReplacingOccurrencesOfString("\(url[range])", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        println(mGrill)
        
        // delete text before the Entree
        var entree = url.indexOf("Entree")
        endIndex = advance(url.startIndex, entree+8)
        range = url.startIndex..<endIndex
        url = url.stringByReplacingOccurrencesOfString("\(url[range])", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        // retrieve the entree text
        end = url.indexOf("Dessert")
        endIndex = advance(url.startIndex, end)
        range = url.startIndex..<endIndex
        let mEntree = url[range]
        println(mEntree)
        
        
        // delete text before the Entree
        var dessert = url.indexOf("Dessert")
        //startIndex = advance(url.startIndex, entree)
        endIndex = advance(url.startIndex, dessert+9)
        range = url.startIndex..<endIndex
        url = url.stringByReplacingOccurrencesOfString("\(url[range])", withString: "" , options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        // retrieve the entree text
        end = url.indexOf("<")
        endIndex = advance(url.startIndex, end)
        range = url.startIndex..<endIndex
        let mDessert = url[range]
        println(mDessert)
        
        entreeLabel.text = mEntree
        grillLabel.text = mGrill
        soupLabel.text = mSoup
        dessertLabel.text = mDessert
    }

}

