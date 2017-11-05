//
//  CircleScene.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit
import SceneKit
import Foundation

class CircleScene: SKScene, SKPhysicsContactDelegate {
    
    var blackBoxLeft = SKShapeNode()
    var blackBoxRight = SKShapeNode()
    var blackBoxTop = SKShapeNode()
    var initialYPos = CGFloat()
    var border = SKShapeNode()
    var score = CGFloat()
    var distTraveled = CGFloat()
    let player = CirclePlayer()
    var staticPlatformAr = [Platform]()
    var platformAr = [Platform]()
    let cam = SKCameraNode()
    let mover = MoveJoystick()
    let bottom = Bottom()
    let wall = Wall()
    let scoreLabel = SKLabelNode()
    var oldPos = CGPoint()
    let jumpButton = SKSpriteNode(texture: SKTexture(imageNamed: "jStick.png"))
    var bgt1 = SKSpriteNode()
    var bgt2 = SKSpriteNode()
    var bgt3 = SKSpriteNode()
    var bgt4 = SKSpriteNode()
    var BGarray = [SKSpriteNode]()

    override func didMove(to view: SKView) {
        data.defaults.set(size.width, forKey: "width")
        data.defaults.set(size.height, forKey: "height")
        initialYPos = size.height/2
        playerInit()
        bgInit()
        self.camera = cam
        addChild(mover)
        mover.zPosition = 10
        scoreLabel.position = CGPoint(x:size.width/2, y: size.height - 0.1)
        addChild(scoreLabel)
        jumperInit()
        platformInit()
        bottomInit()
        containerInit()
        wallInit()
        moveHandlers()
        physicsWorld.contactDelegate = self
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if ((contact.bodyA.node?.name == "platform" && contact.bodyB.node?.name == "player") || (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "platform")) {
            self.player.inAir = false
            self.player.physicsBody?.velocity.dx = 0
            self.player.physicsBody?.velocity.dy = CGFloat(0)
            if ((player.position.x - (distTraveled - (size.width * 0.2))) > (0.5 * size.width)){
                distTraveled = player.position.x
                score = ((distTraveled) / (0.5 * size.width)).rounded()
            }
        } else if ((contact.bodyA.node?.name == "bottom" && contact.bodyB.node?.name == "player") || (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "bottom")) {
            player.removeFromParent()
            score = CGFloat(0)
            distTraveled = CGFloat(0)
            playerInit()
        }
    }
    
    func containerInit() {
        border = SKShapeNode(rect: CGRect(origin: player.position, size: CGSize(width: size.width * 0.61, height: size.height * 0.92)))
        border.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: player.position, size: CGSize(width: size.width * 0.61, height: size.height * 0.92)))
        border.physicsBody?.categoryBitMask = 8
        border.physicsBody?.collisionBitMask = 1 | 2
        border.physicsBody?.contactTestBitMask = 4
        border.zPosition = 10
        border.strokeColor = .white
        border.physicsBody?.isDynamic = false
        border.lineWidth *= 3
        border.position = CGPoint(x: size.width * 0.195, y: size.height * 0.05)
        border.name = "border"
        addChild(border)
        blackBoxLeft = SKShapeNode(rectOf: CGSize(width: size.width * 0.195, height: size.height))
        blackBoxRight = SKShapeNode(rectOf: CGSize(width: size.width * 0.195, height: size.height))
        blackBoxTop = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height * 0.08))
        blackBoxLeft.fillColor = SKColor.black
        blackBoxLeft.lineWidth = 0
        blackBoxLeft.zPosition = 9
        addChild(blackBoxLeft)
        blackBoxTop.fillColor = SKColor.black
        blackBoxTop.lineWidth = 0
        blackBoxTop.zPosition = 9
        addChild(blackBoxTop)
        blackBoxRight.fillColor = SKColor.black
        blackBoxRight.lineWidth = 0
        blackBoxRight.zPosition = 9
        addChild(blackBoxRight)

    }
    
    func bgInit() {
        bgt1 = SKSpriteNode(imageNamed: "backgroundTile.jpg")
        bgt1.zPosition = -15
        bgt1.color = .red
        bgt1.colorBlendFactor = 0.5
        bgt2 = SKSpriteNode(imageNamed: "backgroundTile.jpg")
        bgt2.zPosition = -15
        bgt2.color = .red
        bgt2.colorBlendFactor = 0.5
        bgt3 = SKSpriteNode(imageNamed: "backgroundTile.jpg")
        bgt3.zPosition = -15
        bgt3.color = .red
        bgt3.colorBlendFactor = 0.5
        bgt4 = SKSpriteNode(imageNamed: "backgroundTile.jpg")
        bgt4.zPosition = -15
        bgt4.color = .red
        bgt4.colorBlendFactor = 0.5
        bgt1.size = CGSize(width: size.width, height: size.height)
        bgt2.size = CGSize(width: size.width, height: size.height)
        bgt3.size = CGSize(width: size.width, height: size.height)
        bgt4.size = CGSize(width: size.width, height: size.height)
        bgt1.position = CGPoint(x: 0, y: size.height);
        bgt2.position = CGPoint(x: size.width, y: size.height)
        bgt3.position = CGPoint(x: 0, y: 0)
        bgt4.position = CGPoint(x: size.width, y:0)
        BGarray.append(bgt1)
        BGarray.append(bgt2)
        BGarray.append(bgt3)
        BGarray.append(bgt4)
        addChild(bgt1)
        addChild(bgt2)
        addChild(bgt3)
        addChild(bgt4)
    }
    func playerInit(){
        player.position = CGPoint(x: 0, y: initialYPos)
        player.zPosition = 5;
        addChild(player)
    }
    
    func wallInit() {
        wall.position = CGPoint(x: -0.5 * size.width, y: size.height * 0.5)
        addChild(wall)
    }
    
    func jumperInit(){
        jumpButton.texture!.filteringMode = .nearest
        jumpButton.size.width = (0.1) * size.width
        jumpButton.size.height = (0.1) * size.width
        jumpButton.position = CGPoint(x: player.position.x + (size.width * 0.3), y: player.position.y - size.height * 0.25)
        jumpButton.zPosition = 10;
        addChild(jumpButton)
    }
    
    func platformInit(){
        platformAr.append(Platform(Int: 0))
        platformAr.append(Platform(Int: 1))
        platformAr.append(Platform(Int: 2))
        platformAr.append(Platform(Int: 3))
        staticPlatformAr.append(Platform(Int: 0))
        platformAr[0].position = CGPoint(x: -0.5 * size.width, y: size.height * 0.4)
        platformAr[1].position = CGPoint(x: 0, y: size.height * 0.4)
        platformAr[2].position = CGPoint(x: 0.5 * size.width, y: size.height * 0.4)
        platformAr[3].position = CGPoint(x: 1.0 * size.width, y: size.height * 0.4)
        staticPlatformAr[0].position = CGPoint(x: 0, y: size.height * 0.4)
        addChild(platformAr[0])
        addChild(platformAr[1])
        addChild(platformAr[2])
        addChild(platformAr[3])
        addChild(staticPlatformAr[0])
    }
    
    func platformCandC(){ //create and clean
        if ((platformAr[0].position.x - player.position.x) > size.width && (platformAr[1].position.x - player.position.x) > size.width && (platformAr[2].position.x - player.position.x) > size.width && (platformAr[3].position.x - player.position.x) > size.width) {
            platformAr[0].position = CGPoint(x: -0.5 * size.width, y: size.height * 0.4)
            platformAr[1].position = CGPoint(x: 0, y: size.height * 0.4)
            platformAr[2].position = CGPoint(x: 0.5 * size.width, y: size.height * 0.4)
            platformAr[3].position = CGPoint(x: 1.0 * size.width, y: size.height * 0.4)

        }

        for i in 0...3 {
            if ((player.position.x - platformAr[i].position.x) > size.width && (player.physicsBody?.velocity.dx)! > CGFloat(0)){
                platformAr[i].position.x = platformAr[i].position.x + size.width + size.width
                platformAr[i].position.y = platformAr[i].position.y + (CGFloat(Float(arc4random()) / Float(UINT32_MAX))) * size.height * 0.3
                platformAr[(i + 3) % 4].position.y = (platformAr[i].position.y + platformAr[(i + 2) % 4].position.y) / 2
            } else if ((platformAr[i].position.x - player.position.x) > size.width && (player.physicsBody?.velocity.dx)! < CGFloat(0)){
                platformAr[i].position.x = platformAr[i].position.x - size.width - size.width
                platformAr[i].position.y = platformAr[i].position.y + (CGFloat(Float(arc4random()) / Float(UINT32_MAX))) * size.height * 0.3
                platformAr[(i + 1) % 4].position.y = (platformAr[i].position.y + platformAr[(i + 2) % 4].position.y) / 2
            }
        }
    }
    
    func bottomInit(){
        bottom.size.width = size.width
        bottom.position = CGPoint(x:player.position.x, y: 0)
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
        if (oldPos != player.position){
            blackBoxLeft.position = CGPoint(x: player.position.x - (size.width * 0.4025), y:player.position.y)
            blackBoxRight.position = CGPoint(x: player.position.x + (size.width * 0.4025), y:player.position.y)
            blackBoxTop.position = CGPoint(x: player.position.x, y:player.position.y + (size.height * 0.46))
            border.position = CGPoint(x: player.position.x - (size.width * 0.61/2), y: player.position.y - size.height)
            jumpButton.position = CGPoint(x: player.position.x + (size.width * 0.4), y: player.position.y - size.height * 0.15)
            bottom.position = CGPoint(x:player.position.x, y: 0)
            mover.position = CGPoint(x: player.position.x - (size.width * 0.4), y: player.position.y - size.height * 0.15)
            scoreLabel.position = CGPoint(x:player.position.x, y: player.position.y + (size.height * 0.3))
            scoreLabel.text = score.description
            platformCandC()
            cam.position = player.position
            for i in 0...3 {
                if((BGarray[i].position.x - player.position.x - size.width) == 0 && (player.physicsBody?.velocity.dx)! < CGFloat(0)) {
                    BGarray[i].position.x = BGarray[i].position.x - size.width - size.width
                } else if((player.position.x - BGarray[i].position.x) == 0 && (player.physicsBody?.velocity.dx)! > CGFloat(0)) {
                    BGarray[i].position.x = BGarray[i].position.x + size.width + size.width
                } else if((BGarray[i].position.y - player.position.y - size.height) == 0 && (player.physicsBody?.velocity.dy)! < CGFloat(0)) {
                    BGarray[i].position.y = BGarray[i].position.y - size.height - size.height
                } else if((player.position.y - BGarray[i].position.y - size.height) == 0 && (player.physicsBody?.velocity.dy)! > CGFloat(0)) {
                    BGarray[i].position.y = BGarray[i].position.y + size.height + size.height
                }
            }
        }
        oldPos = player.position
    }
    
    func moveHandlers() {
        mover.trackingHandler = { jData in
            self.player.physicsBody?.velocity = CGVector(dx: jData.velocity.x * 8.0, dy: (self.player.physicsBody?.velocity.dy)!)
        }
        
        mover.stopHandler = {
            if (self.player.inAir == false){
                self.player.physicsBody?.velocity = CGVector(dx: 0.0, dy: (self.player.physicsBody?.velocity.dy)!)
            }
        }
    }
    
    func jump() {
        if self.player.inAir == false {
            self.player.physicsBody?.velocity = CGVector(dx: (self.player.physicsBody?.velocity.dx)!, dy: (self.player.physicsBody?.velocity.dy)!+500.0)
            self.player.inAir = true
        }
    }
    
    
    
}
