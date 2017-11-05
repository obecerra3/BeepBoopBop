//
//  SquareScene.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class SquareScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SquarePlayer()
    
    let mover = MoveJoystick()
    let aimer = AimJoystick()
    
    let score = SKLabelNode(fontNamed: "pixelFont.ttf")
    let health = SKLabelNode(fontNamed: "pixelFont.ttf")
    let f = SKLabelNode(fontNamed: "pixelFont.ttf")
    
    var enemyArray = [Enemy()]
    
    var upgradeCount = 0
    
    
    override func didMove(to view: SKView) {
        border()
        enemyArray = []
        addChild(f)
        
        score.text = "Score: \(data.currentScore)"
        score.fontSize = size.width * 0.02
        score.fontColor = .white
        score.position = CGPoint(x: size.width * 0.93, y: size.height * 0.93)
        addChild(score)
        
        health.text = "Health: \(player.health)"
        health.fontSize = size.width * 0.02
        health.fontColor = .white
        health.position = CGPoint(x: size.width * 0.07, y: size.height * 0.93)
        addChild(health)
        
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(player)

        addChild(mover)
        addChild(aimer)
        
        moveHandlers()
        aimHandlers()
        
        self.physicsWorld.contactDelegate = self
        
        enemyTime(0)
    }
    
    func border() {
        let wall = SKShapeNode(rect: CGRect(origin: player.position, size: CGSize(width: size.width * 0.61, height: size.height * 0.92)))
        wall.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: player.position, size: CGSize(width: size.width * 0.61, height: size.height * 0.92)))
        wall.physicsBody?.categoryBitMask = 8
        wall.physicsBody?.collisionBitMask = 1 | 2
        wall.physicsBody?.contactTestBitMask = 4
        wall.strokeColor = .white
        wall.physicsBody?.isDynamic = false
        wall.lineWidth *= 3
        wall.position = CGPoint(x: size.width * 0.195, y: size.height * 0.05)
        wall.name = "wall"
        addChild(wall)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "wall" && nodeB.name == "laser" {
            nodeB.removeFromParent()
        } else if nodeB.name == "laser" && nodeA.name == "enemy" {
            if nodeB.alpha == 1.00 {
                let target = nodes(at: nodeA.position)[0]
                (target as? Enemy)!.loseHealth()
                if (target as? Enemy)!.health < 1 && enemyArray.index(of: (target as? Enemy)!) != nil {
                    enemyArray.remove(at: enemyArray.index(of: (target as? Enemy)!)! )
                    data.currentScore += 5
                    score.text = "Score: \(data.currentScore)"
                }
                nodeB.removeFromParent()
            }
        } else if nodeB.name == "laser" && nodeA.name == "player" {
            if nodeB.alpha == 0.99 {
                if nodes(at: nodeA.position) != [] {
                    let target = nodes(at: nodeA.position)[0]
                    (target as? SquarePlayer)!.loseHealth()
                    if (target as? SquarePlayer)!.health < 1 {
                        gameOver()
                    }
                }
                nodeB.removeFromParent()
            }
        } else if nodeB.name == "enemy" && nodeA.name == "laser" {
            if nodeA.alpha == 1.00 {
                let target = nodes(at: nodeB.position)[0]
                (target as? Enemy)!.loseHealth()
                if (target as? Enemy)!.health < 1 && enemyArray.index(of: (target as? Enemy)!) != nil{
                    enemyArray.remove(at: enemyArray.index(of: (target as? Enemy)!)! )
                    data.currentScore += 5
                    score.text = "Score: \(data.currentScore)"
                }
                nodeA.removeFromParent()
            }
        } else if nodeB.name == "laser" && nodeA.name == "spinnyEnemy" {
            if nodeB.alpha == 1.00 {
                let target = nodes(at: nodeA.position)[0]
                (target as? SpinnyEnemy)!.loseHealth()
                if (target as? SpinnyEnemy)!.health < 1  {
                    data.currentScore += 10
                    score.text = "Score: \(data.currentScore)"
                }
                nodeB.removeFromParent()
            }
        } else if nodeB.name == "spinnyEnemy" && nodeA.name == "laser" {
            if nodeA.alpha == 1.00 {
                let target = nodes(at: nodeB.position)[0]
                (target as? SpinnyEnemy)!.loseHealth()
                if (target as? SpinnyEnemy)!.health < 1  {
                    data.currentScore += 10
                    score.text = "Score: \(data.currentScore)"
                }
                nodeA.removeFromParent()
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        health.text = "Health: \(player.health)"
        
        if enemyArray.count == 0 {
            data.currentScore += 10
            score.text = "Score: \(data.currentScore)"
            self.removeAction(forKey: "enemy1")
            enemyTime(data.currentScore)
            
            if arc4random_uniform(3) == 1 && self.upgradeCount < 3  {
                self.upgradeCount += 1
                f.text = "Gun Upgrade: \(self.upgradeCount)"
                f.fontSize = size.width * 0.02
                f.fontColor = .white
                f.position = CGPoint(x: size.width * 0.07, y: size.height * 0.8)
                player.fireRate *= 0.5
            }
        }
        
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
            let waiter = SKAction.wait(forDuration: 0.2)
            self.run(waiter, withKey: "waiter")
        }
        
        aimer.trackingHandler = { jData in
            if let _ = self.action(forKey: "shoot") {
            } else if let _ = self.action(forKey: "waiter") {
            } else if jData.velocity.x != 0 && jData.velocity.y != 0{
                let shoot = SKAction.run { self.shootLaser1(self.player, jData.velocity, jData.angular) }
                let wait = SKAction.wait(forDuration: self.player.fireRate)
                self.run(SKAction.sequence([shoot,wait]), withKey: "shoot")
            }
        }
    }
    
    func shootLaser1 (_ shooter: SquarePlayer, _ trajectory: CGPoint, _ angle: CGFloat) {
        let laser = SKSpriteNode(color: shooter.laserColor, size: CGSize(width: shooter.size.width * 0.45, height: shooter.size.width * 0.75))
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shooter.size.width*0.5,
                                                             height: shooter.size.width*0.5))
        laser.zPosition = 1
        laser.zRotation = angle
        laser.physicsBody?.allowsRotation = false
        laser.physicsBody?.affectedByGravity = false
        laser.physicsBody?.categoryBitMask = 4
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.contactTestBitMask = 8 | 1 | 2
        laser.physicsBody?.usesPreciseCollisionDetection = true
        laser.position = shooter.position
        laser.alpha = 1.0
        
        laser.name = "laser"
        addChild(laser)
        let t = trajectory.normalized()
        laser.physicsBody?.velocity = CGVector(dx: t.x * 325, dy: t.y * 325)
        
        let remove = SKAction.run { laser.removeFromParent() }
        let wait = SKAction.wait(forDuration: 1.0)
        self.run(SKAction.sequence([wait,remove]))
    }
    
    func shootLaser2 (_ shooter: Enemy, _ trajectory: CGPoint, _ angle: CGFloat) {
        let laser = SKSpriteNode(color: shooter.laserColor, size: CGSize(width: shooter.size.width * 0.4, height: shooter.size.width * 0.7))
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shooter.size.width*0.5,
                                                              height: shooter.size.width*0.5))
        laser.zPosition = 1
        laser.zRotation = angle
        laser.physicsBody?.allowsRotation = false
        laser.physicsBody?.affectedByGravity = false
        laser.physicsBody?.categoryBitMask = 4
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.contactTestBitMask = 8 | 1 | 2
        laser.physicsBody?.usesPreciseCollisionDetection = true
        laser.position = shooter.position
        laser.alpha = 0.99
        
        laser.name = "laser"
        addChild(laser)
        let t = trajectory.normalized()
        laser.physicsBody?.velocity = CGVector(dx: t.x * 200, dy: t.y * 200)
        
        let remove = SKAction.run { laser.removeFromParent() }
        let wait = SKAction.wait(forDuration: 1.0)
        self.run(SKAction.sequence([wait,remove]))
    }
    
    func shootLaser3 (_ shooter: SpinnyEnemy, _ trajectory: CGPoint, _ angle: CGFloat) {
        let laser = SKSpriteNode(color: shooter.laserColor, size: CGSize(width: shooter.size.width * 0.5, height: shooter.size.width * 0.5))
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shooter.size.width*0.5,
                                                              height: shooter.size.width*0.5))
        laser.zPosition = 1
        laser.zRotation = angle
        laser.physicsBody?.allowsRotation = false
        laser.physicsBody?.affectedByGravity = false
        laser.physicsBody?.categoryBitMask = 4
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.contactTestBitMask = 8 | 1 | 2
        laser.physicsBody?.usesPreciseCollisionDetection = true
        laser.position = shooter.position
        laser.alpha = 0.99
        
        laser.name = "laser"
        addChild(laser)
        let t = trajectory.normalized()
        laser.physicsBody?.velocity = CGVector(dx: t.x * 75, dy: t.y * 75)
        
        let remove = SKAction.run { laser.removeFromParent() }
        let wait = SKAction.wait(forDuration: 2.0)
        self.run(SKAction.sequence([wait,remove]))
    }
    
    func gameOver() {
        if data.currentScore > data.defaults.integer(forKey: "highscore") {
            data.defaults.set(data.currentScore, forKey: "highscore")
        }
        
        self.removeAllActions()
        self.removeAllChildren()
        let view = self.view as SKView!
        let scene = StartScene(size: (view?.bounds.size)!)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .black
        view?.presentScene(scene)
    }
    
    func enemyTime(_ s : Int) {
        
        if s == 0 {
            let enemy1 = Enemy()
            enemy1.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
            enemyArray.append(enemy1)
            addChild(enemy1)
            
            
        } else if s < 40 {
            let enemy2 = Enemy()
            enemy2.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
            enemyArray.append(enemy2)
            addChild(enemy2)
            
            let enemy1 = Enemy()
            enemy1.position = CGPoint(x: size.width * 0.3, y: size.height * 0.2)
            enemyArray.append(enemy1)
            addChild(enemy1)
            
            let enemy3 = Enemy()
            enemy3.position = CGPoint(x: size.width * 0.7, y: size.height * 0.2)
            enemyArray.append(enemy3)
            addChild(enemy3)
            
            if arc4random_uniform(2) == 0{ spinnyAdd(CGPoint(x: size.width * 0.5, y: size.height * 0.5)) }

        } else if s < 80 {
            player.gainHealth()
            
            let enemy1 = Enemy()
            enemy1.position = CGPoint(x: size.width * 0.5, y: size.height * 0.85)
            enemyArray.append(enemy1)
            addChild(enemy1)
            
            let enemy2 = Enemy()
            enemy2.position = CGPoint(x: size.width * 0.3, y: size.height * 0.85)
            enemyArray.append(enemy2)
            addChild(enemy2)
            
            let enemy3 = Enemy()
            enemy3.position = CGPoint(x: size.width * 0.7, y: size.height * 0.85)
            enemyArray.append(enemy3)
            addChild(enemy3)
            
            let enemy4 = Enemy()
            enemy4.position = CGPoint(x: size.width * 0.5, y: size.height * 0.15)
            enemyArray.append(enemy4)
            addChild(enemy4)
            
            let enemy5 = Enemy()
            enemy5.position = CGPoint(x: size.width * 0.3, y: size.height * 0.15)
            enemyArray.append(enemy5)
            addChild(enemy5)
            
            let enemy6 = Enemy()
            enemy6.position = CGPoint(x: size.width * 0.7, y: size.height * 0.15)
            enemyArray.append(enemy6)
            addChild(enemy6)
        } else {
            player.gainHealth()
            
            if arc4random_uniform(4) == 0 {
                topAndBottom()
                if arc4random_uniform(2) == 0{ spinnyAdd(CGPoint(x: size.width * 0.5, y: size.height * 0.5)) }
            } else if arc4random_uniform(4) == 0 {
                squareFormation()
            } else if arc4random_uniform(4) == 0 {
                rightAndLeft()
                if arc4random_uniform(2) == 0{
                    spinnyAdd(CGPoint(x: size.width * 0.3, y: size.height * 0.5))
                    spinnyAdd(CGPoint(x: size.width * 0.6, y: size.height * 0.5))
                }
            } else {
                boxed()
                if arc4random_uniform(2) == 0{ spinnyAdd(CGPoint(x: size.width * 0.5, y: size.height * 0.5)) }
            }
        }
        
        
        let triggering = SKAction.run {
            for e in self.enemyArray {
                e.trigger(self.player.position)
            }
        }
        
        let firing = SKAction.run {
            for e in self.enemyArray {
                if arc4random_uniform(2) == 1 {
                    self.shootLaser2(e,  CGPoint(x: self.player.position.x - e.position.x , y: self.player.position.y - e.position.y) ,
                                     atan( self.player.position.x / self.player.position.y ))
                }
            }
        }
        let waiting = SKAction.wait(forDuration: 1.75)
        run(SKAction.repeatForever(SKAction.sequence([waiting,triggering,firing])), withKey: "enemy1")
        
    }
    
    func rightAndLeft() {
        let enemy9 = Enemy()
        enemy9.position = CGPoint(x: size.width * 0.25, y: size.height * 0.74)
        enemyArray.append(enemy9)
        addChild(enemy9)
        
        let enemy10 = Enemy()
        enemy10.position = CGPoint(x: size.width * 0.25, y: size.height * 0.52)
        enemyArray.append(enemy10)
        addChild(enemy10)
        
        let enemy11 = Enemy()
        enemy11.position = CGPoint(x: size.width * 0.25, y: size.height * 0.26)
        enemyArray.append(enemy11)
        addChild(enemy11)
        
        let enemy12 = Enemy()
        enemy12.position = CGPoint(x: size.width * 0.7, y: size.height * 0.74)
        enemyArray.append(enemy12)
        addChild(enemy12)
        
        let enemy13 = Enemy()
        enemy13.position = CGPoint(x: size.width * 0.7, y: size.height * 0.52)
        enemyArray.append(enemy13)
        addChild(enemy13)
        
        let enemy14 = Enemy()
        enemy14.position = CGPoint(x: size.width * 0.7, y: size.height * 0.26)
        enemyArray.append(enemy14)
        addChild(enemy14)
    }
    
    func boxed() {
        topAndBottom()
        rightAndLeft()
    }
    
    func squareFormation() {
        
        let enemy1 = Enemy()
        enemy1.position = CGPoint(x: size.width * 0.5, y: size.height * 0.85)
        enemyArray.append(enemy1)
        addChild(enemy1)
        
        let enemy2 = Enemy()
        enemy2.position = CGPoint(x: size.width * 0.3, y: size.height * 0.85)
        enemyArray.append(enemy2)
        addChild(enemy2)
        
        let enemy3 = Enemy()
        enemy3.position = CGPoint(x: size.width * 0.7, y: size.height * 0.85)
        enemyArray.append(enemy3)
        addChild(enemy3)
        
        let enemy4 = Enemy()
        enemy4.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        enemyArray.append(enemy4)
        addChild(enemy4)
        
        let enemy5 = Enemy()
        enemy5.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
        enemyArray.append(enemy5)
        addChild(enemy5)
        
        let enemy6 = Enemy()
        enemy6.position = CGPoint(x: size.width * 0.7, y: size.height * 0.5)
        enemyArray.append(enemy6)
        addChild(enemy6)
        
        let enemy7 = Enemy()
        enemy7.position = CGPoint(x: size.width * 0.5, y: size.height * 0.15)
        enemyArray.append(enemy7)
        addChild(enemy7)
        
        let enemy8 = Enemy()
        enemy8.position = CGPoint(x: size.width * 0.3, y: size.height * 0.15)
        enemyArray.append(enemy8)
        addChild(enemy8)
        
        let enemy9 = Enemy()
        enemy9.position = CGPoint(x: size.width * 0.7, y: size.height * 0.15)
        enemyArray.append(enemy9)
        addChild(enemy9)
        
    }
    
    func topAndBottom() {
        let enemy1 = Enemy()
        enemy1.position = CGPoint(x: size.width * 0.25, y: size.height * 0.9)
        enemyArray.append(enemy1)
        addChild(enemy1)
        
        let enemy2 = Enemy()
        enemy2.position = CGPoint(x: size.width * 0.4, y: size.height * 0.9)
        enemyArray.append(enemy2)
        addChild(enemy2)
        
        let enemy3 = Enemy()
        enemy3.position = CGPoint(x: size.width * 0.55, y: size.height * 0.9)
        enemyArray.append(enemy3)
        addChild(enemy3)
        
        let enemy4 = Enemy()
        enemy4.position = CGPoint(x: size.width * 0.7, y: size.height * 0.9)
        enemyArray.append(enemy4)
        addChild(enemy4)
        
        let enemy5 = Enemy()
        enemy5.position = CGPoint(x: size.width * 0.25, y: size.height * 0.1)
        enemyArray.append(enemy5)
        addChild(enemy5)
        
        let enemy6 = Enemy()
        enemy6.position = CGPoint(x: size.width * 0.4, y: size.height * 0.1)
        enemyArray.append(enemy6)
        addChild(enemy6)
        
        let enemy7 = Enemy()
        enemy7.position = CGPoint(x: size.width * 0.55, y: size.height * 0.1)
        enemyArray.append(enemy7)
        addChild(enemy7)
        
        let enemy8 = Enemy()
        enemy8.position = CGPoint(x: size.width * 0.7, y: size.height * 0.1)
        enemyArray.append(enemy8)
        addChild(enemy8)
    }
    
    func spinnyAdd(_ c: CGPoint) {
        let enemy13 = SpinnyEnemy()
        enemy13.position = c
        addChild(enemy13)
        
        let shooter = SKAction.run {
            self.shootLaser3(enemy13, CGPoint(x: 1,y: 0), -1.57)
            self.shootLaser3(enemy13, CGPoint(x: 0,y: 1), 0.0)
            self.shootLaser3(enemy13, CGPoint(x: -1,y: 0), 1.57)
            self.shootLaser3(enemy13, CGPoint(x: 0,y: -1), 0.0)

        }
        let waiter = SKAction.wait(forDuration: 1.5)
        
        self.run(SKAction.repeatForever(SKAction.sequence([waiter,shooter])), withKey: "spinnyShot")
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
