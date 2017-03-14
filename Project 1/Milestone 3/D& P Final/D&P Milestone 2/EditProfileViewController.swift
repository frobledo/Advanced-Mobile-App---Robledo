//
//  EditProfileViewController.swift
//  D&P Milestone 2
//
//  Created by Fuji Robledo on 3/12/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var editProfile = DungeonsClass()
    
    var userName : String?
    var penguinAvatar : Int?
    var difficultyMode: Int?
    
    @IBOutlet weak var penguinAvatarImage: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var penguinAvatarSelection: UISegmentedControl!
    @IBOutlet weak var difficultyModeSelected: UISegmentedControl!
    
    //Will show image of Penguin Avatar depending on user selection

    @IBAction func showPenguinAvatarSelected(_ sender: Any) {
        
        if penguinAvatarSelection.selectedSegmentIndex == 0 {
            penguinAvatarImage.image = UIImage(named: "originalPenguin.png")
        }
        
        if penguinAvatarSelection.selectedSegmentIndex == 1 {
            penguinAvatarImage.image = UIImage(named: "magicPenguin.png")
        }
        
        if penguinAvatarSelection.selectedSegmentIndex == 2 {
            penguinAvatarImage.image = UIImage(named: "warriorPenguin.png")
            
        }
    }
    //Button to reset score
    @IBAction func resetScore(_ sender: Any) {
        
        let overallScore = 0
        
        let userValues = UserDefaults.standard
        userValues.setValue(overallScore, forKey: defaultKeys.overallScore)
        
    }
    
    //Obtains previous user selection and displays default values
    override func viewDidLoad() {
        super.viewDidLoad()
        
        penguinAvatarImage.image = UIImage(named: "originalPenguin.png")
        

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //Code to dismiss keyboard: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
    func dismissKeyboard() {
        view.endEditing(true)
    }

    //This function sends information to Profile View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "saveSegue" {
            
            //To obtain userName or select default user name
            if userNameTextField.text?.isEmpty != true {
                
                userName = userNameTextField.text!
            }
            else {
                userName = editProfile.defaultUserName
            }
        
            
            //To obtain penguin avatar
            
            if penguinAvatarSelection.selectedSegmentIndex == 0 {
                penguinAvatar = 0
            }
            
            if penguinAvatarSelection.selectedSegmentIndex == 1 {
                penguinAvatar = 1
            }
            
            if penguinAvatarSelection.selectedSegmentIndex == 2 {
                penguinAvatar = 2
            }
            
            //To obtain difficulty level
            
            if difficultyModeSelected.selectedSegmentIndex == 0 {
                
                difficultyMode = 0
            }
            
            if difficultyModeSelected.selectedSegmentIndex == 1 {
                
                difficultyMode = 1
            }
            
        }
        
        
    }
    

}
