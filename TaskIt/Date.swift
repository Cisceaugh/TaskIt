//
//  Date.swift
//  TaskIt
//
//  Created by Francisco Ragland Jr on 4/8/16.
//  Copyright © 2016 Francisco Ragland. All rights reserved.
//

import Foundation

class Date {
    
    class func from (year year: Int, month: Int, day: Int) -> NSDate {
        
        //capture parameters into component property
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        //make gregorian calendar
        let gregorianCalendar = NSCalendar(identifier:NSCalendarIdentifierGregorian)
        
        //make a date from gregorian calendar and components
        let date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
    
    class func toString(date date: NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "MM-dd-yyyy"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
}