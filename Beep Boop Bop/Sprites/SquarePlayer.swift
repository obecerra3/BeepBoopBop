//
//  Player.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class SquarePlayer : SKSpriteNode {
    
    let mainTexture = SKTexture(imageNamed: "squareImage.png")
    
    init () {
        
        super.init(texture: mainTexture,
                   color: UIColor.white,
                   size: mainTexture.size() )
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mainTexture.size().width,
                                                             height: mainTexture.size().height))
        
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 1
        self.physicsBody?.categoryBitMask = 0b1 //player bit mask
        self.physicsBody?.collisionBitMask = 0b10 & 0b11 //collision with enemies and the environment
        self.physicsBody?.contactTestBitMask = 0b100 //contact test with lasers
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func glowInit() -> SKEffectNode {
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        effectNode.addChild(self)
        effectNode.filter = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 1])
        return effectNode
    }
    
    
}
    
    
    
    
    
    
    

