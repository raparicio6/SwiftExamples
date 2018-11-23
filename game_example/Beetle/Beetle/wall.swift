//
//  wall.swift
//  Beetle
//
//  Created by Tomas on 23/11/2018.
//  Copyright © 2018 Tomas. All rights reserved.
//

import SpriteKit

struct wall {
    let node: SKSpriteNode
    
    init(x: CGFloat, y: CGFloat, zRotation: CGFloat? = nil) {
        node = SKSpriteNode(imageNamed: "pillar.png")
        node.setScale(0.5)
        node.position = CGPoint(x: x, y: y)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        node.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        node.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        if let rotation = zRotation{
            node.zRotation = rotation
        }
    }
}
