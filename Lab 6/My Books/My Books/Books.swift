//
//  Books.swift
//  My Books
//
//  Created by Fuji Robledo on 3/28/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import Foundation
import Firebase

class Books {
    
    var bookName : String
    var author : String
    
    init(newname : String, newauthor: String){
        bookName = newname
        author = newauthor
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String : String]
        bookName = snapshotValue["name"]!
        author = snapshotValue["author"]!
    }
    
}
