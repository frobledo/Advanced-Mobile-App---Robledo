//
//  StatDungeonViewController.swift
//  D&P Milestone 2
//
//  Created by Fuji Robledo on 2/27/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class StatDungeonViewController: UIViewController {
    
    let statDungeon = DungeonsClass()
    
    var questions = [String]()
    var answers = [Int]()
    var score = 0
    var index = 0
    var incorrect = 0
    var userSelectedDifficulty : Int = 0
    var userName : String = ""
    var overallScore : Int = 0
    
    @IBOutlet weak var attackButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var penguinAvatarImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerSelection: UISegmentedControl!
    @IBOutlet weak var commentsLabel: UILabel!
    
    func getUserValues() {
        
        let userValues = UserDefaults.standard
        
        if let getUserName = userValues.string(forKey: defaultKeys.selectedUserName) {
            userName = getUserName
        }
        
        if let getPenguinAvatar = userValues.string(forKey: defaultKeys.selectedPenguinAvatar) {
            
            if getPenguinAvatar == statDungeon.originalPenguin {
                penguinAvatarImage.image = UIImage(named: "originalPenguin.png")
            }
            
            if getPenguinAvatar == statDungeon.magicPenguin {
                penguinAvatarImage.image = UIImage(named: "magicPenguin.png")
            }
            
            if getPenguinAvatar == statDungeon.warriorPenguin {
                penguinAvatarImage.image = UIImage(named: "warriorPenguin.png")
                
            }
            
        }
        
        if let getDifficultyMode = userValues.string(forKey: defaultKeys.selectedDifficultyMode) {
            
            if getDifficultyMode == statDungeon.noviceLevel {
                userSelectedDifficulty = 0
            }
            
            if getDifficultyMode == statDungeon.expertLevel {
                userSelectedDifficulty = 1
            }
        }
        
        if let getOverallScore = userValues.string(forKey: defaultKeys.overallScore) {
            
            overallScore = Int(getOverallScore)!
        }

    }
   
    //Displays next question when user clicks "Attack" button
    @IBAction func submitAnswer(_ sender: UIButton) {
        nextQuestion()
    }
    
     //If user clicks on start over in the middle of game play, the game will restart and user data will not be save. If the user clicks after the level is over, the data will be saved.
    @IBAction func startOver(_ sender: Any) {
        
        if index == (statDungeon.numberOfQuestions)-1 {
            
            self.score = 0
            self.index = 0
            self.incorrect = 0
            self.scoreLabel.text = "Score: " + String(self.score)
            self.commentsLabel.text = "Hello " + userName + self.statDungeon.statMonsterComment
            self.setUpDungeon()
        }
        
        else {
            let alertController = UIAlertController(title: "Are you sure?", message: "If you continue, you will lose progress up until this point. Proceed at your own risk!", preferredStyle: UIAlertControllerStyle.alert)
            let cancel = UIAlertAction(title: "I changed my mind!", style: UIAlertActionStyle.cancel, handler: nil)
            
            let okAction = UIAlertAction(title: "Proceed", style: UIAlertActionStyle.default ) { (result: UIAlertAction) -> Void in
                
                self.score = 0
                self.index = 0
                self.incorrect = 0
                self.scoreLabel.text = "Score: " + String(self.score)
                self.commentsLabel.text = "Hello " + self.userName + self.statDungeon.statMonsterComment
                self.setUpDungeon()
            }
            
            alertController.addAction(cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserValues()
        scoreLabel.text = "Score: " + String(score)
        commentsLabel.text = "Hello " + userName + statDungeon.statMonsterComment
        setUpDungeon()
        
    }
    
    //This functions sets up the dungeon by loading the plist with the required data based on difficulty level
    func setUpDungeon() {
        
        if userSelectedDifficulty == 1 {
            
            guard let path = statDungeon.loadDungeon(plistName: "StatDungeonDiffQ")
                else {
                    print("Error loading file")
                    return
            }
            
            questions = NSArray(contentsOfFile: path) as! Array
            
            guard let answersPath = statDungeon.loadDungeon(plistName: "StatDungeonDiffA")
                else {
                    print("Error loading file")
                    return
            }
            
            answers = NSArray(contentsOfFile: answersPath) as! Array
        }
            
        else {
            guard let path = statDungeon.loadDungeon(plistName: "StatDungeonEasyQ")
                else {
                    print("Error loading file")
                    return
            }
            
            questions = NSArray(contentsOfFile: path) as! Array
            
            guard let answersPath = statDungeon.loadDungeon(plistName: "StatDungeonEasyA")
                else {
                    print("Error loading file")
                    return
            }
            
            answers = NSArray(contentsOfFile: answersPath) as! Array
            
            }

        questionLabel.text = questions[statDungeon.beginMode]
    }
    
    
    //This function loads the next question and monitors the score and number of incorrect items
    func nextQuestion() {
        
        if index == (statDungeon.numberOfQuestions)-1 {
            
            conclusion(numberIncorrect: incorrect)
        
        }
        
        else{

            if answerSelection.selectedSegmentIndex == Int(answers[index]) {
                
                commentsLabel.text = statDungeon.correctAnswer
                score += statDungeon.scoreReward
                scoreLabel.text = "Score: " + String(score)
                questionLabel.text = ""
                setUpNextQuestion()
                
            }
                
            else {
                
                commentsLabel.text = statDungeon.incorrectAnswer
                questionLabel.text = ""
                incorrect += 1
                setUpNextQuestion()
                
            }

        }
    }
    
    //Code for delay: http://stackoverflow.com/questions/37801436/how-do-i-write-dispatch-after-gcd-in-swift-3
    func setUpNextQuestion() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.questionLabel.text = String(self.questions[self.index+1])
            self.commentsLabel.text = ""
            self.index += 1
        }
    }
    
    //This function is executed after the last question is displayed 
    func conclusion(numberIncorrect incorrect : Int) {
        
        if answerSelection.selectedSegmentIndex == Int(answers[index]) {
            score += statDungeon.scoreReward
            attackButton.isEnabled = false
        }
            
        if incorrect == statDungeon.incorrextMax {
            score -= statDungeon.scorePenalty
            commentsLabel.text = statDungeon.loss
            questionLabel.text = statDungeon.conclusionNoHearts + statDungeon.finalScoreLabel + String(score)
            attackButton.isEnabled = false
            
        }
            
        else {
            commentsLabel.text = statDungeon.win
            questionLabel.text = statDungeon.finalScoreLabel + String(score)
            attackButton.isEnabled = false
            }
        
        scoreLabel.text = String(score)
        
        overallScore += score
        
        let userValues = UserDefaults.standard
        userValues.setValue(overallScore, forKey: defaultKeys.overallScore)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
