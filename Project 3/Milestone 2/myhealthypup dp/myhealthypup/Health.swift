//
//  Health.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/7/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import os.log

class Health: NSObject, NSCoding{
    
    var date : String
    var type : String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("healthInfo")
    
    struct PropertyKey {
        static let date = "date"
        static let type = "type"
    }
    
    
    init?(date: String, type: String){
        
        guard !date.isEmpty else{
            return nil
        }
        
        guard !type.isEmpty else{
            return nil
        }
        
        self.date = date
        self.type = type
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(type, forKey: PropertyKey.type)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the name for date object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let type = aDecoder.decodeObject(forKey: PropertyKey.type) as? String else {
            os_log("Unable to decode the name for type object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        self.init(date: date, type: type)
        
    }
    
}
