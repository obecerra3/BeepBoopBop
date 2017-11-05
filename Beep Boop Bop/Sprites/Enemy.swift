//
//  Enemy.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class Enemy : SKSpriteNode {
    
    let mainTexture = SKTexture(imageNamed: "enemyImage.png")
    var gunName = "starter"
    var laserColor = UIColor.red
    var damage = 1
    var health = 3
    var fireRate = 0.6
    
    let sceneWidth = data.defaults.float(forKey: "width")
    let sceneHeight = data.defaults.float(forKey: "height")
    
    init () {
        
        super.init(texture: mainTexture, color: UIColor.red, size: CGSize(width: CGFloat(sceneWidth * 0.03), height: CGFloat(sceneWidth * 0.03)))
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: CGFloat(sceneWidth * 0.03), height: CGFloat(sceneWidth * 0.03)))
        
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 2
        self.physicsBody?.categoryBitMask = 0b10//player bit mask
        self.physicsBody?.collisionBitMask = 0b1 & 0b10 & 0b10 //collision with enemies and the environment
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
