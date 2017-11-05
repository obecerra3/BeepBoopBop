//
//  StartScene.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

let data = DataBank()

class StartScene: SKScene {
    
    let startLabel = SKLabelNode(fontNamed: "pixelFont.ttf")
    let highLabel = SKLabelNode(fontNamed: "pixelFont.ttf")
    let scoreLabel = SKLabelNode(fontNamed: "pixelFont.ttf")
    
    override func didMove(to view: SKView) {
        
        data.defaults.set(size.width, forKey: "width")
        data.defaults.set(size.height, forKey: "height")
        
        startLabel.text = "BEEP.BOOP.BOP"
        startLabel.fontColor = .white
        startLabel.fontSize = size.width * 0.1
        startLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(startLabel)
        
        scoreLabel.text = "Last Score: \(data.currentScore)!"
        scoreLabel.fontSize = size.width * 0.04
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.18)
        
        let enlarge = SKAction.scale(by: 1.2, duration: 0.8)
        let shrink = SKAction.scale(by: 0.8, duration: 0.8)
        scoreLabel.run(SKAction.repeatForever(SKAction.sequence([enlarge,shrink])))
        
        if (data.currentScore > 0) {
            addChild(scoreLabel)
        }
        
        highLabel.text = "High Score: \(data.defaults.integer(forKey: "highscore"))"
        highLabel.fontColor = .white
        highLabel.fontSize = size.width * 0.03
        highLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
        addChild(highLabel)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        data.currentScore = 0
        self.removeAllActions()
        self.removeAllChildren()
        let view = self.view as SKView!
        let scene = SquareScene(size: (view?.bounds.size)!)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .black
        view?.presentScene(scene)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    

    
    
    override func update(_ currentTime: TimeInterval) {
    }
}

