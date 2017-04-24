//
/*
 Resources:
 
 Creation of start button: http://stackoverflow.com/questions/31890128/how-to-create-a-button-in-storyboard-to-start-a-game-created-with-spritekit-in-x
 
 To add physics logic and create end scene:
 https://www.raywenderlich.com/145318/spritekit-swift-3-tutorial-beginners
 
 To add timer: http://tutorials.tinyappco.com/SwiftGames/Timer
 
 Images: https://icons8.com/web-app/for/all/danger
 
 Music: from DigitalJuice
 
 To make app icon: https://makeappicon.com
 
 General reference documents: 
 * Beginning iPhone Development text Ch 17
 * https://developer.apple.com/reference/spritekit/
 
 
 */
//  GameScene.swift
//  PenguinHealth
//
//  Created by Fuji Robledo on 4/22/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Defining main character
    let penguin = SKSpriteNode(imageNamed: "penguinChef")
    let background = SKSpriteNode(imageNamed:"PenguinHealthBackground")
    
    //Variables to keep score
    var score = 0
    var oilScore = 0
    
    //Initializing score and timer label
    let timer = CountdownLabel()
    let scoreLabel = SKLabelNode(fontNamed: "American Typewriter Bold")
    
    override func didMove(to view: SKView) {
        
        //Set up background image
        background.size = self.frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        //Set up timer label
        timer.position = CGPoint(x: frame.midX + 100, y: frame.midY + 50)
        timer.fontSize = 30
        timer.zPosition = 2
        timer.fontSize = 30
        timer.fontName = "American Typewriter Bold"
        timer.fontColor = SKColor.blue
        addChild(timer)
        timer.startWithDuration(duration: 30)
        
        //Set up score label
        scoreLabel.position = CGPoint(x: frame.midX - 150, y: frame.midY + 50)
        scoreLabel.fontColor = SKColor.black
        scoreLabel.zPosition = 3
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        
        //Set up penguin sprite
        penguin.position = CGPoint(x: frame.midX, y: frame.midY - 65)
        penguin.zPosition = 4
        addChild(penguin)
        
        //Set up physics
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        
        //To add background music
        let backgroundMusic = SKAudioNode(fileNamed: "Skeleton_fiesta_mixed.wav")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        //Run food falling from above 
        run(SKAction.repeatForever (SKAction.sequence([SKAction.run(addFruit), SKAction.wait(forDuration:0.75)
            ])
        ))
        
        run(SKAction.repeatForever (SKAction.sequence([SKAction.run(addVegetable), SKAction.wait(forDuration:0.75)
            ])
        ))
        
        run(SKAction.repeatForever (SKAction.sequence([SKAction.run(addPoison), SKAction.wait(forDuration:0.5)
            ])
        ))
        
    }
    
    //Method to update score and timer label
    override func update(_ currentTime: CFTimeInterval){
        
        timer.update()
        updateScoreLabel()
        
    }
    
    //Function to update score label
    func updateScoreLabel(){
        
        scoreLabel.text = "Score: " + String(score)
    }
    
    //Method detects when food and penguin sprite come in contact with one another and calls the necessary method to deal with collision (also determines if the penguin caught food or poison)
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if(firstBody.categoryBitMask & PhysicsCategory.Food != 0){
            if let food = firstBody.node as? SKSpriteNode, let penguin = secondBody.node as? SKSpriteNode {
                penguinDidCollideWithFood(penguin: penguin, food: food, type: 0)
            }
        }
        
        if(firstBody.categoryBitMask & PhysicsCategory.Poison != 0) {
            if let rottenFood = firstBody.node as? SKSpriteNode, let penguin = secondBody.node as? SKSpriteNode {
                penguinDidCollideWithFood(penguin: penguin, food: rottenFood, type: 1)
            }
        }

    }

   
    //The functions below add random movement to the fruit
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    //Method adds the fruit sprite to the screen and also applies physics to it
    func addFruit(){
        
        let fruit = SKSpriteNode(imageNamed: "fruit")
        
        fruit.physicsBody = SKPhysicsBody(rectangleOf: fruit.size)
        fruit.physicsBody?.isDynamic = true
        fruit.physicsBody?.categoryBitMask = PhysicsCategory.Food
        fruit.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        fruit.physicsBody?.collisionBitMask = PhysicsCategory.None

        let actualX = random(min: 0 - (size.width - fruit.size.width/2), max: size.width - fruit.size.width/2)
        fruit.position = CGPoint(x: actualX, y: size.height + fruit.size.height/2)
        addChild(fruit)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -fruit.size.height-140), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        fruit.run(SKAction.sequence([actionMove, actionMoveDone]))

    }
    
    //Method adds the vegetable sprite to the screen and also applies physics to it
    func addVegetable(){
        
        let vegetable = SKSpriteNode(imageNamed: "vegetable")
        
        vegetable.physicsBody = SKPhysicsBody(rectangleOf: vegetable.size)
        vegetable.physicsBody?.isDynamic = true
        vegetable.physicsBody?.categoryBitMask = PhysicsCategory.Food
        vegetable.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        vegetable.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let actualX = random(min: 0 - (size.width - vegetable.size.width/2), max: size.width - vegetable.size.width/2)
        vegetable.position = CGPoint(x: actualX, y: size.height + vegetable.size.height/2)
        addChild(vegetable)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -vegetable.size.height-140), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        vegetable.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    //Method adds the poison sprite to the screen and also applies physics to it
    func addPoison(){
        
        let rottenFruit = SKSpriteNode(imageNamed: "poison")
        
        rottenFruit.physicsBody = SKPhysicsBody(rectangleOf: rottenFruit.size)
        rottenFruit.physicsBody?.isDynamic = true
        rottenFruit.physicsBody?.categoryBitMask = PhysicsCategory.Poison
        rottenFruit.physicsBody?.contactTestBitMask = PhysicsCategory.Penguin
        rottenFruit.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let actualX = random(min: 0 - (size.width - rottenFruit.size.width/2), max: size.width - rottenFruit.size.width/2)
        rottenFruit.position = CGPoint(x: actualX, y: size.height + rottenFruit.size.height/2)
        addChild(rottenFruit)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -rottenFruit.size.height-140), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        rottenFruit.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    

    //To move penguin avatar based on user selection
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let touchLocation = touch.location(in: self)
            penguin.position.x = touchLocation.x
        }
        
        penguin.physicsBody = SKPhysicsBody(rectangleOf: penguin.size)
        penguin.physicsBody?.isDynamic = true
        penguin.physicsBody?.categoryBitMask = PhysicsCategory.Penguin
        penguin.physicsBody?.collisionBitMask = PhysicsCategory.None
        penguin.physicsBody?.usesPreciseCollisionDetection = true
        
 
    }
    
    
    //This method will be called when the food collides with the sprite, evaluate the state of the timer, calculate score, and implement game over scene
    func penguinDidCollideWithFood(penguin: SKSpriteNode, food: SKSpriteNode, type: Int){
        
        food.removeFromParent()
        
        switch(type){
            
        case 0:
            run(SKAction.playSoundFileNamed("124539_hit_SFX.wav", waitForCompletion: false))
            score += 2
            
        case 1:
            run(SKAction.playSoundFileNamed("124511_hit_SFX", waitForCompletion: false))
            score -= 4
            oilScore += 1
            print(oilScore)
            
        default: return
            
        }
        
        if timer.hasFinished() == true{
            
            removeAllActions()
            
            if oilScore > 5{
                
                let reveal = SKTransition.fade(withDuration: 4.0)
                let gameOverScene = GameOverScene(size: self.size, won: false, score: score)
                self.view?.presentScene(gameOverScene, transition: reveal)
                
            }
            else{
                
                let reveal = SKTransition.fade(withDuration: 4.0)
                let gameOverScene = GameOverScene(size: self.size, won: true, score: score)
                self.view?.presentScene(gameOverScene, transition: reveal)
                
            }
        }
        
   }

}
