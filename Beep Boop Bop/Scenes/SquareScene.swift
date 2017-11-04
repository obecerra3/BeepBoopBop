//
//  SquareScene.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit
import SceneKit

let data = DataBank()

class SquareScene: SKScene {
    
    let player = SquarePlayer()
    
    let mover = MoveJoystick()
    let aimer = AimJoystick()
    
    override func didMove(to view: SKView) {
        playerInit()
        data.defaults.set(size.width, forKey: "width")
        data.defaults.set(size.height, forKey: "height")        
        addChild(mover)
        addChild(aimer)
        
        moveHandlers()
        aimHandlers()
    }
    
    func playerInit(){
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.size.width = size.width * 0.06
        player.size.height = size.width * 0.06
        addChild(player.glowInit())
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //camera?.position = player.position
    }
    
    func moveHandlers() {
        mover.trackingHandler = { jData in
            
        }
        
        mover.stopHandler = {
            
        }
    }
    
    func aimHandlers() {
        
    }
    
    
    
}
