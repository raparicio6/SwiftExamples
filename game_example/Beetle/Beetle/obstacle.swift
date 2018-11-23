//
//  obstacle.swift
//  Beetle
//
//  Created by Tomas on 23/11/2018.
//  Copyright © 2018 Tomas. All rights reserved.
//
import SpriteKit

struct obstacle {
    let node: SKNode
    init(topWallXPosition: CGFloat, topWallYPosition: CGFloat, xFlowerPosition: CGFloat, yFlowerPosition: CGFloat) {
        node = SKNode()
        node.name = "wallPair"
        let topWall = wall(x: topWallXPosition, y: topWallYPosition, zRotation: CGFloat(M_PI))
        let bottomWall = wall(x: topWallXPosition, y: topWallYPosition - 820)
        let consumable = flower(x: xFlowerPosition, y: yFlowerPosition)
        node.addChild(topWall.node)
        node.addChild(bottomWall.node)
        node.addChild(consumable.node)
        node.zPosition = 1
        let randomPosition = random(min: -200, max: 200)
        node.position.y = node.position.y +  randomPosition
        
        
    }
}
