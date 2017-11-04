//
//  CircleScene.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit
import SceneKit


class CircleScene: SKScene {
    
    let player = CirclePlayer()
    
    let mover = MoveJoystick()
    let jumpButton = SKSpriteNode(texture: SKTexture(imageNamed: "jStick.png"))
    
    override func didMove(to view: SKView) {
        playerInit()
        data.defaults.set(size.width, forKey: "width")
        data.defaults.set(size.height, forKey: "height")
        addChild(mover)
        jumperInit();
        
        moveHandlers()
    }
    
    func playerInit(){
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.size.width = size.width * 0.06
        player.size.height = size.width * 0.06
        addChild(player)
    }
    
    func jumperInit(){
        jumpButton.texture!.filteringMode = .nearest
        jumpButton.size.width = (0.1) * size.width
        jumpButton.size.height = (0.1) * size.width
        jumpButton.position = CGPoint(x: size.width*0.9, y: size.height * 0.15)
        addChild(jumpButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if jumpButton.contains(touches.first!.location(in: self)) {
            jumpButton.size.width = (0.05) * size.width
            jumpButton.size.height = (0.05) * size.width
            jump()
            jumpButton.size.width = (0.1) * size.width
            jumpButton.size.height = (0.1) * size.width
            return
        }
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
            self.player.physicsBody?.velocity = CGVector(dx: jData.velocity.x * 2.5, dy: (self.player.physicsBody?.velocity.dy)!)
        }
        
        mover.stopHandler = {
            self.player.physicsBody?.velocity = CGVector(dx: 0.0, dy: (self.player.physicsBody?.velocity.dy)!)
        }
    }
    
    func jump() {
        self.player.physicsBody?.velocity = CGVector(dx: (self.player.physicsBody?.velocity.dx)!, dy: (self.player.physicsBody?.velocity.dy)!+100.0)
    }
    
    
    
}
