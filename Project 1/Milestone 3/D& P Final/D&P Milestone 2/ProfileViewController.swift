//
//  ProfileViewController.swift
//  D&P Milestone 2
//
//  Created by Fuji Robledo on 2/27/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    var myProfile = DungeonsClass()
    
    var myUserName : String?
    var penguinAvatarString : String?
    var myPenguinAvatar : String?
    var myDifficultyModeString : String?
    var myDifficultyMode : String?
    
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var penguinAvatarImage: UIImageView!
    @IBOutlet weak var modeLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userValues = UserDefaults.standard
        
        if let getUserName = userValues.string(forKey: defaultKeys.selectedUserName) {
            userNameLabel.text = getUserName
        }
        
        if let getPenguinAvatar = userValues.string(forKey: defaultKeys.selectedPenguinAvatar) {
            
            if getPenguinAvatar == myProfile.originalPenguin {
                penguinAvatarImage.image = UIImage(named: "originalPenguin.png")
            }
            
            if getPenguinAvatar == myProfile.magicPenguin {
                penguinAvatarImage.image = UIImage(named: "magicPenguin.png")
            }
            
            if getPenguinAvatar == myProfile.warriorPenguin {
                penguinAvatarImage.image = UIImage(named: "warriorPenguin.png")

            }
            
        }
        
        if let getDifficultyMode = userValues.string(forKey: defaultKeys.selectedDifficultyMode) {
            
            if getDifficultyMode == myProfile.noviceLevel {
                modeLabel.text = myProfile.noviceLevel
            }
            
            if getDifficultyMode == myProfile.expertLevel {
                modeLabel.text = myProfile.expertLevel
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let userValues = UserDefaults.standard
        
        if let getOverallScore = userValues.string(forKey: defaultKeys.overallScore) {
            overallScoreLabel.text = getOverallScore
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    func setUserValues() {
        
        let userValues = UserDefaults.standard
        
        userValues.setValue(myUserName, forKey: defaultKeys.selectedUserName)
        userValues.setValue(myPenguinAvatar, forKey: defaultKeys.selectedPenguinAvatar)
        userValues.setValue(myDifficultyMode, forKey: defaultKeys.selectedDifficultyMode)
        
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "saveSegue" {
            let source = segue.source as! EditProfileViewController
            
            //To display userName
            if((source.userName?.isEmpty) == false){
                userNameLabel.text = source.userName
            }
            
            myUserName = source.userName!
            
            //To display penguin avatar selection
            if ((source.penguinAvatar) != nil){
              
                if source.penguinAvatar == 0 {
                    penguinAvatarImage.image = UIImage(named: "originalPenguin.png")
                    penguinAvatarString = myProfile.originalPenguin
                }
                
                if source.penguinAvatar == 1{
                    penguinAvatarImage.image = UIImage(named: "magicPenguin.png")
                    penguinAvatarString = myProfile.magicPenguin
                }
                
                if source.penguinAvatar == 2 {
                    penguinAvatarImage.image = UIImage(named: "warriorPenguin.png")
                    penguinAvatarString = myProfile.warriorPenguin
                }
            
             myPenguinAvatar = penguinAvatarString!
            }
            
            //To display difficulty level
            if ((source.difficultyMode) != nil){
                
                if source.difficultyMode == 0 {
                    modeLabel.text = myProfile.noviceLevel
                    myDifficultyModeString = myProfile.noviceLevel
                }
                
                if source.difficultyMode == 1 {
                    modeLabel.text = myProfile.expertLevel
                    myDifficultyModeString = myProfile.expertLevel
                }
                
                myDifficultyMode = myDifficultyModeString!
                
                setUserValues()
                
            }

        }
    }
}
