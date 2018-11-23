import SpriteKit

struct CollisionBitMask {
    static let birdCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let flowerCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    
    func createWalls() -> SKNode{
        let wallPair = obstacle(topWallXPosition: self.frame.width + 25,
                                topWallYPosition: self.frame.height / 2 + 420,
                                xFlowerPosition: self.frame.width + 25,
                                yFlowerPosition: self.frame.height / 2)
        wallPair.node.run(moveAndRemove)
        return wallPair.node
        
    }

}

