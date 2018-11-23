//
//  button.swift
//  Beetle
//
//  Created by Tomas on 22/11/2018.
//  Copyright © 2018 Tomas. All rights reserved.
//
import SpriteKit
struct factory {
    
    static func createSKSpriteNode(imageName: String, width: Int, height: Int,xPosition: CGFloat, yPosition: CGFloat, zPosition: CGFloat, scale: CGFloat? = nil) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: imageName)
        node.size = CGSize(width: width, height: height)
        node.position = CGPoint(x: xPosition, y: yPosition)
        node.zPosition = zPosition
        if let scaleRequired = scale {
            node.setScale(scaleRequired)
        }
        return node
    }
    
    static func createSKLabelNode(xPosition: CGFloat, yPosition: CGFloat, zPosition: CGFloat, text: String,                                  font: String, fontSize: CGFloat, fontColor: UIColor? = nil) -> SKLabelNode{
        let label = SKLabelNode()
        label.position = CGPoint(x: xPosition, y: yPosition)
        label.text = text
        label.zPosition = zPosition
        label.fontSize = fontSize
        label.fontName = font
        if let fontColorRequired = fontColor {
            label.fontColor = fontColorRequired
        }
        return label
    }
    
    static func createSKShapeNode(xPosition: CGFloat, yPosition: CGFloat, zPosition: CGFloat, path:CGPath, color:UIColor) -> SKShapeNode {
        let shape = SKShapeNode()
        shape.position = CGPoint(x: xPosition, y: yPosition)
        shape.path = path
        shape.strokeColor = UIColor.clear
        shape.fillColor = color
        shape.zPosition = zPosition
        return shape
    }
    
    
}

