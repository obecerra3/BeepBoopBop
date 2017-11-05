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
    var gunName = "starter"
    var laserColor = UIColor.blue
    var damage = 1
    var health = 3
    var fireRate = 0.4
    
    let sceneWidth = data.defaults.float(forKey: "width")
    let sceneHeight = data.defaults.float(forKey: "height")
    
    init () {
        super.init(texture: mainTexture, color: UIColor.red, size: CGSize(width: CGFloat(sceneWidth * 0.03), height: CGFloat(sceneWidth * 0.03)))
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: CGFloat(sceneWidth * 0.03), height: CGFloat(sceneWidth * 0.03)))
        name = "player"
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 2
        self.physicsBody?.categoryBitMask = 1 //player bit mask
        self.physicsBody?.collisionBitMask = 2 | 8 //collision with enemies and the environment
        self.physicsBody?.contactTestBitMask = 4 //contact test with lasers
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func loseHealth() {
        self.health -= 1
        if self.health < 1 {
            let death = SKAction.scale(to: 0.0, duration: 0.75)
            let remover = SKAction.run { self.removeFromParent() }
            self.run(SKAction.sequence([death,remover]))
        }
    }
    
    func gainHealth() {
        if self.health < 3 {
            self.health += 1
        }
        
    }
    
    
}
    
    
    
    
    
    
    

