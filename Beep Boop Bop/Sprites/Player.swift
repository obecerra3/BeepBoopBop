//
//  Player.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class Player : SKSpriteNode {
    
    let mainTexture = SKTexture(imageNamed: "Square.png")
    
    init () {
        
        super.init(texture: mainTexture,
                   color: UIColor.clear,
                   size: mainTexture.size() )
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mainTexture.size().width,
                                                             height: mainTexture.size().height))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
    
    
    
    
    
    
    

