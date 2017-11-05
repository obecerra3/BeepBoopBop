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
                   size: CGSize(width: mainTexture.size().width, height: mainTexture.size().height) )
        self.size.height = self.size.height/2
        self.size.width = self.size.width/2
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width * 0.5)
        self.physicsBody?.restitution = 0.0;
        self.physicsBody?.friction = 0.0
        self.name = "player"
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 1
        self.physicsBody?.categoryBitMask = 1 //player bit mask
        self.physicsBody?.contactTestBitMask = 7//collision the environment
        self.physicsBody?.collisionBitMask = 7 //collision the environment
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
}









