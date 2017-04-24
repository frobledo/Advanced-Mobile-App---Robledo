//
//  GameOverScene.swift
//  PenguinHealth
//
//  Created by Fuji Robledo on 4/23/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let background = SKSpriteNode(imageNamed:"PenguinHealthBackground")
    
    init(size: CGSize, won: Bool, score: Int) {
        
        super.init(size:size)
        
        //Add background to scene
        background.size = self.frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 1
        addChild(background)
     
        //Initialize text for labels
        let message = won ? "You did it!" : "Cause of Death:"
        let conditionMessage = won ? "Way to eat healthy!" : "Overexposure to Oil"
        let scoreMessage = "Final score: " + String(score)
        
        let label = SKLabelNode(fontNamed: "American Typewriter Bold")
        let conditionLabel = SKLabelNode(fontNamed: "American Typewriter Bold")
        let labelScore = SKLabelNode(fontNamed: "American Typewriter Bold")
        
        label.text = message
        label.fontSize = 24
        label.zPosition = 2
        label.fontColor = SKColor.red
        label.position = CGPoint(x: frame.midX, y: frame.midY + 20)
        addChild(label)
        
        conditionLabel.text = conditionMessage
        conditionLabel.zPosition = 2
        conditionLabel.fontSize = 18
        conditionLabel.fontColor = SKColor.black
        conditionLabel.position = CGPoint(x: frame.midX, y: frame.midY - 10)
        addChild(conditionLabel)
        
        labelScore.text = scoreMessage
        labelScore.zPosition = 2
        labelScore.fontSize = 18
        labelScore.fontColor = SKColor.black
        labelScore.position = CGPoint(x: frame.midX, y: frame.midY - 40)
        addChild(labelScore)
        
        
        //Transition to GameOver scene
        run(SKAction.sequence ([
            SKAction.wait(forDuration: 20),
            SKAction.run() {
                let reveal = SKTransition.fade(withDuration: 4.0)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition: reveal)
            }
            ]))

    }
    
    required init(code aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
