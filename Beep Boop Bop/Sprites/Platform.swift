//
//  Platform.swift
//  Beep Boop Bop
//
//  Created by Thomas Seaver on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class Platform : SKSpriteNode {
    
    let text0 = SKTexture(imageNamed: "plat0.png")
    let text1 = SKTexture(imageNamed: "plat1.png")
    let text2 = SKTexture(imageNamed: "plat2.png")
    let text3 = SKTexture(imageNamed: "plat3.png")
    var mainTexture = SKTexture(imageNamed: "platform.png")
    
    init (Int selection: Int) {
        
        if (selection == 0) {
            mainTexture = text0
        } else if (selection == 1) {
            mainTexture = text1
        } else if(selection == 2) {
            mainTexture = text2
        } else {
            mainTexture = text3
        }
        
        super.init(texture: mainTexture,
                   color: UIColor.gray,
                   size: mainTexture.size() )
        self.name = "platform"
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (self.size.width), height: self.size.height))
        physicsInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func physicsInit() {
        self.zPosition = 1
        self.physicsBody?.categoryBitMask = 2 //environment bit mask
        self.physicsBody?.collisionBitMask = 7 //collision the player
        self.physicsBody?.contactTestBitMask = 7 //contact the player
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
}

