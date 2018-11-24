
import SpriteKit
import Darwin

class GameScene: SKScene , SKPhysicsContactDelegate {
    
    var isGameStarted = Bool(false)
    var isDead = Bool(false)
    let coinSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    
    var score = Int(0)
    var scoreLbl = SKLabelNode()
    var highscoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var restartBtn = SKSpriteNode()
    var pauseBtn = SKSpriteNode()
    var logoImg = SKSpriteNode()
    var newHsLogo = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var bird = Bird(x:0, y:0)
    var birdNode = SKSpriteNode()
 
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene(){
        //resetDefaults() reset highscores
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        
        for i in 0..<2
        {
            let background = SKSpriteNode(imageNamed: "bg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
    
        
        bird = Bird(x: self.frame.midX, y: self.frame.midY)
        birdNode = bird.node
        self.addChild(birdNode)
        
        let animateBird = SKAction.animate(with: bird.sprites, timePerFrame: 0.1)
        bird.repeatAction = SKAction.repeatForever(animateBird)
        
        
        logoImg = factory.createSKSpriteNode(imageName: "logo", width: 272, height: 65,xPosition: self.frame.midX, yPosition: self.frame.midY + 100, zPosition: 0, scale: 0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
        
        
        scoreLbl =  factory.createSKLabelNode(xPosition:  self.frame.width / 2, yPosition:  self.frame.height / 2 + self.frame.height / 2.6, zPosition: 5, text: String(score), font: "HelveticaNeue-Bold", fontSize: 50)
        
        let scoreBackground = factory.createSKShapeNode(xPosition: 0, yPosition: 0, zPosition: -1, path: CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100), height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil) , color: UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2)))
        scoreLbl.addChild(scoreBackground)
        
        self.addChild(scoreLbl)
        
        var highScore:String
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highScore = "Highest Score: \(highestScore)"
        }
        else {
            highScore = "Highest Score: 0"
        }
            
        highscoreLbl =  factory.createSKLabelNode(xPosition: self.frame.width - 80,
                                             yPosition: self.frame.height - 22,
                                             zPosition: 5,
                                             text: highScore,
                                             font: "Helvetica-Bold" ,
                                             fontSize: 15)
                
        self.addChild(highscoreLbl)
        
        taptoplayLbl = factory.createSKLabelNode(xPosition: self.frame.midX, yPosition: self.frame.midY - 100, zPosition: 5, text: "Tap anywhere to play", font: "HelveticaNeue", fontSize: 20, fontColor: UIColor(red: 63/255, green: 79/255, blue: 145/255, alpha: 1.0))
        
        self.addChild(taptoplayLbl)
    }
    
    
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if isGameStarted == true && isDead == false{
            enumerateChildNodes(withName: "background", using: ({
                (node, error) in
                let bg = node as! SKSpriteNode
                bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                }
            }))
        }
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameStarted == false{
            isGameStarted =  true
            birdNode.physicsBody?.affectedByGravity = true
            pauseBtn = factory.createSKSpriteNode(imageName: "pause", width: 40, height: 40,xPosition: self.frame.width - 30, yPosition: 30, zPosition: 6)
            self.addChild(pauseBtn)
            logoImg.run(SKAction.scale(to: 0.5, duration: 0.3), completion: {
                self.logoImg.removeFromParent()
            })
            taptoplayLbl.removeFromParent()
            birdNode.run(bird.repeatAction)
            
            //add pillars
            
            let spawn = SKAction.run({
                () in
                self.wallPair = self.createWalls()
                self.addChild(self.wallPair)
            })
            
            let delay = SKAction.wait(forDuration: 1.5)
            
            let SpawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
            
            self.run(spawnDelayForever)
            
            let distance = CGFloat(self.frame.width + wallPair.frame.width)
            let movePillars = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
            let removePillars = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([movePillars, removePillars])
            
            birdNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            birdNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            
            let dispatchQueue:DispatchQueue = DispatchQueue(label: "newHighScoreCheck", qos: .background)
            dispatchQueue.async{
                
                let highestScore:Int = UserDefaults.standard.integer(forKey: "highestScore")
                var newHighScore:Bool = false
                while (!newHighScore && self.isGameStarted){
                        
                    if (self.score > highestScore){
                        newHighScore = true
                        self.newHsLogo = factory.createSKSpriteNode(imageName: "newHighScore", width: 150, height: 130,xPosition: self.frame.midX + 100, yPosition: self.frame.midY + 200, zPosition: 0, scale: 0.5)
                        self.addChild(self.newHsLogo)
            
                        self.newHsLogo.run(SKAction.scale(to: 0.5, duration: 1.3), completion: {
                            self.newHsLogo.removeFromParent()
                        })
                    }
                }
            }
 
                   } else {
            
            if isDead == false {
                birdNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                birdNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
        
        for touch in touches{
            let location = touch.location(in: self)
            
            if isDead == true{
                if restartBtn.contains(location){
                    if UserDefaults.standard.object(forKey: "highestScore") != nil {
                        let hscore = UserDefaults.standard.integer(forKey: "highestScore")
                        if hscore < Int(scoreLbl.text!)!{
                            UserDefaults.standard.set(scoreLbl.text, forKey: "highestScore")
                        }
                    } else {
                        UserDefaults.standard.set(0, forKey: "highestScore")
                    }
                    restartScene()
                }
            }
            
            else if pauseBtn.contains(location){
                if self.isPaused == false{
                    self.isPaused = true
                    pauseBtn.texture = SKTexture(imageNamed: "play")
                } else {
                    self.isPaused = false
                    pauseBtn.texture = SKTexture(imageNamed: "pause")
                }
            }
        }
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory || firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory{
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            if isDead == false{
                isDead = true
                restartBtn = factory.createSKSpriteNode(imageName: "restart", width: 100, height: 100,xPosition:self.frame.width / 2, yPosition: self.frame.height / 2, zPosition: 6, scale: 0)
                self.addChild(restartBtn)
                restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
                pauseBtn.removeFromParent()
                self.birdNode.removeAllActions()
            }
        } else if firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.flowerCategory {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        } else if firstBody.categoryBitMask == CollisionBitMask.flowerCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        isDead = false
        isGameStarted = false
        score = 0
        createScene()
    }
    
    
}
