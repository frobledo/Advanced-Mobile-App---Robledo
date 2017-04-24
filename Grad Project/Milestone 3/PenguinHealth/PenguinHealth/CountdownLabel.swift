//
//  CountdownLabel.swift
//  PenguinHealth
//
//  Created by Fuji Robledo on 4/23/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import Foundation
import SpriteKit

class CountdownLabel: SKLabelNode{
    
    //Code modified from: http://tutorials.tinyappco.com/SwiftGames/Timer
    
    var endTime:NSDate!
    
    func update(){
        
        let timeLeftInteger = Int(timeLeft())
        text = "Time Left: " + String(timeLeftInteger)
        
    }
    
    private func timeLeft() -> TimeInterval{
        
        let now = NSDate()
        let remainingSeconds = endTime.timeIntervalSince(now as Date)
        return max(remainingSeconds, 0)
        
    }
    
    func startWithDuration(duration: TimeInterval){
        
        let timeNow = NSDate()
        endTime = timeNow.addingTimeInterval(duration)
        
    }
    
    func hasFinished() -> Bool{
        
        return timeLeft() == 0
    }
    
}
