//
//  flower.swift
//  Beetle
//
//  Created by Tomas on 23/11/2018.
//  Copyright © 2018 Tomas. All rights reserved.
//

import SpriteKit

struct flower {
    let node: SKSpriteNode
    
    init(x: CGFloat, y: CGFloat) {
    node = SKSpriteNode(imageNamed: "flower.png")
    node.size = CGSize(width: 40, height: 40)
    node.position = CGPoint(x: x, y: y)
    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
    node.physicsBody?.affectedByGravity = false
    node.physicsBody?.isDynamic = false
    node.physicsBody?.categoryBitMask = CollisionBitMask.flowerCategory
    node.physicsBody?.collisionBitMask = 0
    node.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
    node.color = SKColor.blue
    }
    
    
    
}
