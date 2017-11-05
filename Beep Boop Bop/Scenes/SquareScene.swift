//
//  SquareScene.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class SquareScene: SKScene {
    
    let player = SquarePlayer()
    
    let mover = MoveJoystick()
    let aimer = AimJoystick()
    
    override func didMove(to view: SKView) {

        border()
        
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(player)

        addChild(mover)
        addChild(aimer)
        
        moveHandlers()
        aimHandlers()
        
    }
    
    
    func border() {
        let wall = SKShapeNode(rect: CGRect(origin: player.position, size: CGSize(width: size.width * 0.61, height: size.height * 0.92)))
        wall.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: player.position, size: CGSize(width: size.width * 0.61, height: size.height * 0.92)))
        wall.physicsBody?.categoryBitMask = 0b11
        wall.physicsBody?.collisionBitMask = 0b1 & 0b10
        wall.strokeColor = .white
        wall.physicsBody?.isDynamic = false
        wall.lineWidth *= 2
        wall.position = CGPoint(x: size.width * 0.195, y: size.height * 0.05)
        addChild(wall)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func moveHandlers() {
        mover.trackingHandler = { jData in
            self.player.physicsBody?.velocity = CGVector(dx: jData.velocity.x * 3.5, dy: jData.velocity.y * 3.5)
        }
        
        mover.stopHandler = {
            self.player.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        }
    }
    
    func aimHandlers() {
        aimer.beginHandler = {
            let waiter = SKAction.wait(forDuration: 0.3)
            self.run(waiter, withKey: "waiter")
        }
        
        aimer.trackingHandler = { jData in
            if let _ = self.action(forKey: "shoot") {
            } else if let _ = self.action(forKey: "waiter") {
            } else if jData.velocity.x != 0 && jData.velocity.y != 0{
                let shoot = SKAction.run { self.shootLaser(self.player, jData.velocity, jData.angular) }
                let wait = SKAction.wait(forDuration: self.player.fireRate)
                self.run(SKAction.sequence([shoot,wait]), withKey: "shoot")
            }
        }
    }
    
    func shootLaser (_ shooter: SquarePlayer, _ trajectory: CGPoint, _ angle: CGFloat) {
        let laser = SKSpriteNode(color: shooter.laserColor, size: CGSize(width: shooter.size.width * 0.3, height: shooter.size.width * 0.7))
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shooter.size.width*0.5,
                                                             height: shooter.size.width*0.5))
        laser.zPosition = 1
        laser.zRotation = angle
        laser.physicsBody?.allowsRotation = false
        laser.physicsBody?.affectedByGravity = false
        laser.physicsBody?.categoryBitMask = 0b100
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.contactTestBitMask = 0b1 & 0b10 & 0b11
        laser.physicsBody?.usesPreciseCollisionDetection = true
        laser.position = shooter.position
        addChild(laser)
        let t = trajectory.normalized()
        laser.physicsBody?.velocity = CGVector(dx: t.x * 350, dy: t.y * 350)
        
        let remove = SKAction.run { laser.removeFromParent() }
        let wait = SKAction.wait(forDuration: 1.0)
        self.run(SKAction.sequence([wait,remove]))
    }
    
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}
