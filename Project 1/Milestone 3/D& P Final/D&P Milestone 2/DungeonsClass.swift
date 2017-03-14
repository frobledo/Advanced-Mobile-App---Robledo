//
//  DungeonsClass.swift
//  D&P Milestone 2
//
//  Created by Fuji Robledo on 3/10/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import Foundation

class DungeonsClass {
    
    //Strings for user settings
    let defaultUserName = "Typical Penguin"
    let originalPenguin = "Original Penguin"
    let magicPenguin = "Magic Penguin"
    let warriorPenguin = "Warrior Penguin"
    let noviceLevel = "Novice"
    let expertLevel = "Expert"
    
       
    //Text depending on whether answer is correct or not 
    let correctAnswer = "Drats! That is correct!"
    let incorrectAnswer = "Haha! That is incorrect!"
    
    //Number of maximum incorrect per dungeon
    let incorrextMax = 3
    
    //Indicate which element to begin with in array based on chosen difficulty level
    let beginMode = 0
    
    //Limit number of question
    let numberOfQuestions = 4
    
    //Score penalty based on no more hearts
    let scorePenalty = 40
    
    //Score increased based on answering question correctly
    let scoreReward = 120
    
    //Text that should be displayed at the conclusion of the level
    let loss = "You lose this round! Better luck next time!"
    let win = "You defeated me this time, but you better watch out! Next time, you won't be so lucky!"
    
    let finalScoreLabel = "Your final score for this level is: "
    let conclusionNoHearts = "I see you missed all the questions, which means that I will be taking away 40 points from your score. Hahaha! "
    
   
    //To locate plist file
    func loadDungeon(plistName name : String) -> String? {
        
        guard let pathString = Bundle.main.path(forResource: name, ofType: "plist")
            else {
                
                return nil
        }
        return pathString
    }
    
    
    //Text for each dungeon monster to state at the beginning
    let statMonsterComment = "! I am the Normally Distribute Monster, guardian of the Chi-Square Dungeon, expert in statistical methods!"
    
    let clinicalMonsterComment = "! I am the Ghost of Pavlov's Bell, guardian of the Clinical Dungeon, expert in general psychology!"
    
    let dendriteMonsterComment = "! I am the Pyramidal Neuron Troll, guardian of the Dendritic Dungeon, expert in neuroscience!"
       

}
