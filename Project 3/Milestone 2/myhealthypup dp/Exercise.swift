//
//  Exercise.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/7/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import os.log

//Class to initialize and store exercise data
class Exercise: NSObject, NSCoding{
    
    var date : String
    var duration : String
    var mood : String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exerciseInfo")
    
    struct PropertyKey {
        static let date = "date"
        static let duration = "duration"
        static let mood = "mood"
    }
    
    
    init?(date: String, duration: String, mood: String){
        
        guard !date.isEmpty else{
            return nil
        }
        
        guard !duration.isEmpty else{
            return nil
        }
        
        guard !mood.isEmpty else{
            return nil
        }
        
        self.date = date
        self.duration = duration
        self.mood = mood
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(duration, forKey: PropertyKey.duration)
        aCoder.encode(mood, forKey: PropertyKey.mood)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the name for date object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let duration = aDecoder.decodeObject(forKey: PropertyKey.duration) as? String else {
            os_log("Unable to decode the name for duration object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let mood = aDecoder.decodeObject(forKey: PropertyKey.mood) as? String else {
            os_log("Unable to decode the name for mood object.", log: OSLog.default, type: .debug)
            return nil
        }
       
        self.init(date: date, duration: duration, mood: mood)
        
    }
    
}
