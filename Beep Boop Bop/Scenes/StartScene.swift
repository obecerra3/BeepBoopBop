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
    
    let startLabel = SKLabelNode(fontNamed: "pixelFont")
    
    override func didMove(to view: SKView) {
        
        data.defaults.set(size.width, forKey: "width")
        data.defaults.set(size.height, forKey: "height")
        
        startLabel.text = "BEEP.BOOP.BOP"
        startLabel.fontColor = .white
        startLabel.fontSize = size.width * 0.1
        startLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(startLabel)
        
        data.currentScore = 0
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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

