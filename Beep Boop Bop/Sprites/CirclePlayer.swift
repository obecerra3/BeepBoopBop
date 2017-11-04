//
//  CirclePlayer.swift
//  Beep Boop Bop
//
//  Created by Thomas Seaver on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class CirclePlayer : SKSpriteNode {
    
    var inAir = false
    
    let mainTexture = SKTexture(imageNamed: "circleImage.png")
    
    init () {
        
        super.init(texture: mainTexture,
                   color: UIColor.white,
                   size: mainTexture.size() )
        self.physicsBody = SKPhysicsBody(circleOfRadius: (mainTexture.size().width/2))
        self.name = "player"
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 1
        self.physicsBody?.categoryBitMask = 0b1 //player bit mask
        self.physicsBody?.contactTestBitMask = 0b111 //collision the environment
        self.physicsBody?.collisionBitMask = 0b111 //collision the environment
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
}









