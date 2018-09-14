//
//  GameScene.swift
//  Jumper
//
//  Created by USER on 09/09/2018.
//  Copyright © 2018 LearnAppMaking. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ground = SKSpriteNode() // moving background
    var myBasket = SKSpriteNode()
 
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5) // moving background
        createGrounds()
        
        myBasket = self.childNode(withName: "MyBasket") as! SKSpriteNode
//        myBasket.setValue(0, forKey: "jumps") this was where I was going to store the jump count
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
//        if let tapInfo = self.userData?.value(forKey: "tapCount") {
//            print("Tap Count is :\(tapInfo)")
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            for touch in touches {
    //            let Location = touch.location(in: self)
                let basketY = myBasket.position.y
                let basketJump = myBasket.size.height/2
    //            let basketJumpCount: Int = (myBasket.value(forKey: "jumps") as? Int)! this causes simulator to not work
                
                myBasket.run(SKAction.moveTo(y: basketY + basketJump, duration: 0.1))
    //            myBasket.setValue(basketJumpCount + 1, forKey: "jumps") this is connected to line 40
            }
    }

    override func update(_ currentTime: TimeInterval) {
        //called before each frame is rendered
        moveGrounds()
    }
    
    func createGrounds() {
        // moving background
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "BG 1 Side-scrolling")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: 2500)
            ground.position = CGPoint(x: CGFloat(i)*ground.size.width, y: -(self.frame.size.height / 10))
            ground.zPosition = 0
            
            self.addChild(ground)
        }
    }
    
    func moveGrounds(){
        self.enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            node.position.x -= 2
            if node.position.x < -((self.scene?.size.width)!) {
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
}
