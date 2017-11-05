//
//  Wall.swift
//  Beep Boop Bop
//
//  Created by Thomas Seaver on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class Wall : SKSpriteNode {
    
    let mainTexture = SKTexture(imageNamed: "wall.png")
    
    init () {
        super.init(texture: mainTexture,
                   color: UIColor.gray,
                   size: mainTexture.size() )
        self.size.width = size.width * 0.8
        self.size.height = size.height * 2.0
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (self.size.width), height: self.size.height))
        physicsInit()
        self.name = "wall"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func physicsInit() {
        self.zPosition = 2
        self.physicsBody?.categoryBitMask = 2 //environment bit mask
        self.physicsBody?.collisionBitMask = 7 //collision the player
        self.physicsBody?.contactTestBitMask = 7 //collision the player
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
}


