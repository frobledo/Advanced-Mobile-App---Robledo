//
//  Questions.swift
//  D&P Milestone 2
//
//  Created by Fuji Robledo on 3/9/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import Foundation

class Questions {
    
    var questionText : String
    var correct: String
    var incorrect : String
    var win : String
    var lost : String
    
    init(questionText qtext: String, correct ctext : String, incorrect itext :String) {
        
        qtext = questionText
        ctext = correct
        itext = incorrect
    }
    
    func correct() {
        
        correct = "Drats...you are smarter than I thought! That is correct!"
    }
    
    func incorrect() {
        
        incorrect = "Haha! That is incorrect!"
    }
    
    func won() {
        
        win = "You defeated me this time...keep up the hard work!"
    }
    
    func lost() {
        
        lost = "Hahaha! I win! Better luck next time!"
    }
}
