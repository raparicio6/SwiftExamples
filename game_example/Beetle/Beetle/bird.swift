//
//  bird.swift
//  Beetle
//
//  Created by Tomas on 22/11/2018.
//  Copyright © 2018 Tomas. All rights reserved.
//

import SpriteKit

struct Bird {
    
    let atlas = SKTextureAtlas(named:"player")
    var sprites: Array<SKTexture>
    var node: SKSpriteNode
    var repeatAction = SKAction()
    
    init(x xPosition:CGFloat,y yPosition:CGFloat) {
         sprites = [atlas.textureNamed("bird1.png"), atlas.textureNamed("bird2.png"),
                    atlas.textureNamed("bird3.png"), atlas.textureNamed("bird4.png")]
         node = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("bird1.png"))
         node.size = CGSize(width: 50, height: 50)
         node.position = CGPoint(x: xPosition, y: yPosition)
      
        /*
         No siempre queremos detectar colisiones
         */
         node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
         node.physicsBody?.linearDamping = 1.1
         node.physicsBody?.restitution = 0
        
         node.physicsBody?.categoryBitMask = CollisionBitMask.birdCategory
         node.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
         node.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.flowerCategory | CollisionBitMask.groundCategory
      
         node.physicsBody?.affectedByGravity = false
         node.physicsBody?.isDynamic = true
    
    }
    

}
