//
//  Platform.swift
//  Beep Boop Bop
//
//  Created by Thomas Seaver on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class Platform : SKSpriteNode {
    
    let mainTexture = SKTexture(imageNamed: "platform.png")
    
    init () {
        
        super.init(texture: mainTexture,
                   color: UIColor.gray,
                   size: mainTexture.size() )
        self.name = "platform"
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (mainTexture.size().width), height: mainTexture.size().height))
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 1
        self.physicsBody?.categoryBitMask = 0b10 //environment bit mask
        self.physicsBody?.collisionBitMask = 0b111 //collision the player
        self.physicsBody?.contactTestBitMask = 0b111 //collision the player
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
}

