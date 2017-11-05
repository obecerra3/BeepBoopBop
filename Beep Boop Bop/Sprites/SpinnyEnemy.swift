//
//  SpinnyEnemy.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/5/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class SpinnyEnemy : SKSpriteNode {
    
    
    let mainTexture = SKTexture(imageNamed: "spinnyEnemyImage.png")
    var gunName = "starter"
    var laserColor = UIColor.green
    var damage = 1
    var health = 8
    var fireRate = 0.6
    
    let sceneWidth = data.defaults.float(forKey: "width")
    let sceneHeight = data.defaults.float(forKey: "height")
    
    init () {
        
        super.init(texture: mainTexture, color: UIColor.red, size: CGSize(width: CGFloat(sceneWidth * 0.035), height: CGFloat(sceneWidth * 0.035)))
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: CGFloat(sceneWidth * 0.035), height: CGFloat(sceneWidth * 0.035)))
        name = "spinnyEnemy"
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 2
        self.physicsBody?.categoryBitMask = 2//player bit mask
        self.physicsBody?.collisionBitMask = 1 | 8 | 2  //collision with enemies and the environment
        self.physicsBody?.contactTestBitMask = 4//contact test with lasers
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.applyAngularImpulse(10)
    }
    
    func loseHealth() {
        self.health -= 1
        if self.health < 1 {
            self.physicsBody?.contactTestBitMask = 0
            self.physicsBody?.categoryBitMask = 0
            let death = SKAction.scale(to: 0.0, duration: 0.5)
            let remover = SKAction.run { self.removeFromParent() }
            self.run(SKAction.sequence([death,remover]))
        }
    }
    
    
}

