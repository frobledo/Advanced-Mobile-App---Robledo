//
//  ExerciseData.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/7/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import os.log

class ExerciseData: NSObject, NSCoding {
    
    let date : String = ""
    let duration: String = ""
    let mood : String = ""

    struct PropertyKey{
        static let date = "exerciseDate"
        static let duration = "exerciseDuration"
        static let mood = "exeriseMood"
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercise")
    
    //MARK: NSCoding
 
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(duration, forKey: PropertyKey.duration)
        aCoder.encode(mood, forKey: PropertyKey.mood)
    }
    
    required convenience init? (coder aDecoder: NSCoder){
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String
            else{
                os_log("Unable to decode the date for Exercise object", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let duration = aDecoder.decodeObject(forKey: PropertyKey.duration) as? String
            else{
                os_log("Unable to decode the date for Exercise object", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let mood = aDecoder.decodeObject(forKey: PropertyKey.mood) as? String
            else{
                os_log("Unable to decode the date for Exercise object", log: OSLog.default, type: .debug)
                return nil
        }
        
        self.init(date: date, duration: duration, mood: mood)
    }
    
}


