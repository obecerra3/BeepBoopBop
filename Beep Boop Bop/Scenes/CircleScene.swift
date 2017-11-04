//
//  CircleScene.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit
import SceneKit


class CircleScene: SKScene, SKPhysicsContactDelegate {
    
    let player = CirclePlayer()
    var platformAr = [Platform]()
    let mover = MoveJoystick()
    let bottom = Bottom()
    let jumpButton = SKSpriteNode(texture: SKTexture(imageNamed: "jStick.png"))
    
    override func didMove(to view: SKView) {
        playerInit()
        data.defaults.set(size.width, forKey: "width")
        data.defaults.set(size.height, forKey: "height")
        addChild(mover)
        jumperInit();
        platformInit();
        bottomInit();
        moveHandlers()
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if ((contact.bodyA.node?.name == "platform" && contact.bodyB.node?.name == "player") || (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "platform")) {
            self.player.inAir = false;
        } else if ((contact.bodyA.node?.name == "bottom" && contact.bodyB.node?.name == "player") || (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "bottom")) {
            player.removeFromParent()
            playerInit()
        }
    }
    
    func playerInit(){
        player.position = CGPoint(x: 0.05 * size.width, y: size.height * 0.5)
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
    
    func platformInit(){
        platformAr.append(Platform())
        platformAr.append(Platform())
        platformAr.append(Platform())
        platformAr[0].position = CGPoint(x: platformAr[0].size.width/2, y: size.height * 0.4)
        platformAr[0].size.width = 0.3 * size.width
        platformAr[1].position = CGPoint(x: 0.6 * size.width, y: size.height * 0.4)
        platformAr[1].size.width = 0.3 * size.width
        platformAr[2].position = CGPoint(x: 1.2 * size.width, y: size.height * 0.4)
        platformAr[2].size.width = 0.3 * size.width
        addChild(platformAr[0])
        addChild(platformAr[1])
        addChild(platformAr[2])
    }
    
    func bottomInit(){
        bottom.size.width = size.width
        bottom.position = CGPoint(x:size.width * 0.5, y: 0)
        addChild(bottom)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if jumpButton.contains(touches.first!.location(in: self)) {
            jumpButton.size.width = (0.075) * size.width
            jumpButton.size.height = (0.075) * size.width
            jump()
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        jumpButton.size.width = (0.1) * size.width
        jumpButton.size.height = (0.1) * size.width
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //camera?.position = player.position
    }
    
    func moveHandlers() {
        mover.trackingHandler = { jData in
            self.player.physicsBody?.velocity = CGVector(dx: jData.velocity.x * 8.0, dy: (self.player.physicsBody?.velocity.dy)!)
        }
        
        mover.stopHandler = {
            self.player.physicsBody?.velocity = CGVector(dx: 0.0, dy: (self.player.physicsBody?.velocity.dy)!)
        }
    }
    
    func jump() {
        if self.player.inAir == false {
            self.player.physicsBody?.velocity = CGVector(dx: (self.player.physicsBody?.velocity.dx)!, dy: (self.player.physicsBody?.velocity.dy)!+400.0)
            self.player.inAir = true
        }
    }
    
    
    
}
