//
//  PhysicsCategory.swift
//  PenguinHealth
//
//  Created by Fuji Robledo on 4/23/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import Foundation

//Establishing constants for physics categories 
struct PhysicsCategory {
    
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let Food : UInt32 = 0b1
    static let Poison : UInt32 = 0b10
    static let Penguin : UInt32 = 0b111
    
}
