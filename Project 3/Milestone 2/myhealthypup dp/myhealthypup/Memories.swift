//
//  Memories.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/7/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import os.log

class Memories: NSObject, NSCoding{
    
    var memory : UIImage
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("memoryInfo")
    
    struct PropertyKey {
        static let memory = "memory"
    }
    
    
    init?(memory : UIImage?){
        
        self.memory = memory!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(memory, forKey: PropertyKey.memory)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let memory = aDecoder.decodeObject(forKey: PropertyKey.memory) as? UIImage
        
        self.init(memory: memory)
        
    }
    
}
