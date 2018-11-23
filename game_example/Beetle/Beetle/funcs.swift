//
//  funcs.swift
//  Beetle
//
//  Created by Tomas on 23/11/2018.
//  Copyright © 2018 Tomas. All rights reserved.
//

import SpriteKit

func random() -> CGFloat{
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}
func random(min : CGFloat, max : CGFloat) -> CGFloat{
    return random() * (max - min) + min
}
