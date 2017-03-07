//
//  GameScene2.swift
//  T2R
//
//  Created by raman maharjan on 2/19/17.
//  Copyright © 2017 raman maharjan. All rights reserved.
//
import SpriteKit
import GameplayKit
import GameKit
import UIKit

struct PhysicsCategory {
    static let boatPC : UInt32 = 0x1 << 1
    static let finishLinePC : UInt32 = 0x1 << 2
    static let floatPC : UInt32 = 0x1 << 3
     static let startLine : UInt32 = 0x1 << 3
}

class GameScene2: SKScene, SKPhysicsContactDelegate, UIScrollViewDelegate {
    var tapleft = UILabel()
    var right = UILabel()
    var seaImage = SKSpriteNode()
    var paddleImage1 = SKSpriteNode()
    var boat = SKSpriteNode()
    var boatNode = SKNode()
    var finishLine = SKSpriteNode()
    var finishLineNode = SKNode()
    var floatNode = SKNode()
    var float1 = SKSpriteNode()
    var started = Bool()
    var gameStarted = Bool()
    var gameOver = Bool()
    var leftButton = UIButton()
    var rightButton = UIButton()
    var width = CGFloat()
    var height = CGFloat()
    var scrollView = UIScrollView()
    var scrollViewCont = UIViewController()
    override func didMove(to view: SKView) {
        getItTogether()
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {

    }
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return scrollView
//    }
    func getItTogether(){
        //timer.fire()
        scrollView = UIScrollView(frame: (view?.bounds)!)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 0.5
       // scrollView.backgroundColor = UIColor.cyan
        //self.view?.addSubview(scrollView
       // scrollViewCont.view?.addSubview(scrollView)
       // let VC = self.view?.window?.rootViewController
        //self.view?.window?.rootViewController = VC
        //VC?.present(view!, animated: true, completion: nil)
       //self.view?.window?.rootViewController = scrollViewCont
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -0.03 )
        //red background
        backgroundColor = UIColor.init(red: 104/255, green: 1, blue: 13/255, alpha: 0.5)

        addBoat()
        addFinishLine()
        addFloat1()
        addWave()
        addStartLine()
        addTextRL()
    }
    override func update(_ currentTime: CFTimeInterval) {
        if gameStarted == true{
            boat.physicsBody?.affectedByGravity = true
            right.removeFromSuperview()
            tapleft.removeFromSuperview()
            countNum.removeFromSuperview()
    //add left button
            leftButton = UIButton(type: UIButtonType.custom) as UIButton
            leftButton.frame = (frame: CGRect(x: 0 , y: 0 , width: self.size.width/2 , height: self.size.height))
            leftButton.addTarget(self, action: #selector(GameScene2.boatLeft), for: .touchUpInside)
            self.view?.addSubview(leftButton)
    //add right button
            rightButton = UIButton(type: UIButtonType.custom) as UIButton
            rightButton.frame = (frame: CGRect(x: self.size.width/2 + 1 , y: 0 , width: self.size.width/2 , height: self.size.height))
            rightButton.addTarget(self, action: #selector(GameScene2.boatRight), for: .touchUpInside)
            self.view?.addSubview(rightButton)

    //GIVE DIRECTION TO BOAT
            if boatr == true && boatl == true {
                boatForward()
            } else if boatr == true && boatl == false{
                bRight()
            }else if boatr == false && boatl == true{
                bLeft()
            }
        }
        if gameStarted == true && gameOver != true{
            //TIMER
            Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(GameScene2.startClock),userInfo:nil, repeats: false);
        }
        if gameOver == true{
            boat.physicsBody?.affectedByGravity = false
        }

    }

     func didBegin(_ contact: SKPhysicsContact) {

        let firstBody = contact.bodyA
        let secondBody = contact.bodyB

        if firstBody.categoryBitMask == PhysicsCategory.boatPC && secondBody.categoryBitMask == PhysicsCategory.finishLinePC || firstBody.categoryBitMask == PhysicsCategory.finishLinePC && secondBody.categoryBitMask == PhysicsCategory.boatPC
        {
            gameOver = true
            gameOverMethod()
        }
    }


    var countNum = UILabel()
    var countInt = 0
    var timer = Timer()
    //123 START
    func count123(){
        countInt = countInt + 1
        countNum.removeFromSuperview()
        countNum = UILabel(frame: CGRect(x: self.size.width/2 - 75, y: self.size.height/3 , width: 150, height: 40))
        countNum.textAlignment = .center
        countNum.textColor = UIColor.yellow
        countNum.font = UIFont.init(name: "Optima", size: 30)
        countNum.text = "\(countInt)"
        if  countInt == 4{   ///////////*********change count to 4****** //////////
            timer.invalidate()
            countNum.text = "Start"
            gameStarted = true
            countInt = 0
        }
        self.view?.addSubview(countNum)
    }
    //add boat
    func addBoat(){
    boatNode = SKNode()
    boat = SKSpriteNode(imageNamed: "boatSteady")
    let boat1ImageSz = CGSize(width: boat.size.width/4, height: boat.size.height/4)
    let boat1PhyBodySz = CGSize(width: boat.size.width/6, height: boat.size.height/3)
    boat.physicsBody = SKPhysicsBody(rectangleOf: boat1PhyBodySz)
    boat.physicsBody?.isDynamic = true
    boat.physicsBody?.affectedByGravity = false
    boat.physicsBody?.allowsRotation = false
    boat.physicsBody?.categoryBitMask = PhysicsCategory.boatPC
    boat.physicsBody?.collisionBitMask = 0
    boat.physicsBody?.collisionBitMask = PhysicsCategory.startLine
    boat.physicsBody?.contactTestBitMask = PhysicsCategory.finishLinePC
    boat.scale(to: boat1ImageSz)
    boat.zPosition = 5
    boat.position = CGPoint(x: self.size.width/2, y: self.size.height/5)
    boatNode.addChild(boat)
    self.addChild(boatNode)
    }
    func addTextRL(){
        tapleft = UILabel(frame: CGRect(x: self.size.width/20, y: self.size.height/2 + self.size.height/5, width: 100, height: 150))
        tapleft.textAlignment = .center
        tapleft.textColor = UIColor.yellow
        tapleft.numberOfLines = 0
        tapleft.font = UIFont.init(name: "Optima", size: 25)
        tapleft.text = "Tap \n here \n 2 \n row \n left"
        self.view?.addSubview(tapleft)
        //left tap to row right
        right = UILabel(frame: CGRect(x: self.size.width - self.size.width/3, y: self.size.height/2 + self.size.height/5, width: 100, height: 150))
        right.textAlignment = .center
        right.textColor = UIColor.yellow
        right.numberOfLines = 0
        right.font = UIFont.init(name: "Optima", size: 25)
        right.text = "Tap \n here \n 2 \n row \n right"
        self.view?.addSubview(right)
    }

    var timer2 = Timer()
    var timer3 = Timer()
    var boatl = Bool()
    var boatr = Bool()

     func boatLeft()
     {
        boatl = true
    }
    func bLeft()
    {
        // print("left")
        moveFloatRight()
        boat.texture = SKTexture(imageNamed:"boatLeft")
        boat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
       // boat.position = CGPoint(x: boat.position.x - 2 , y: boat.position.y + 1)
        let moveLeft = SKAction.moveBy(x: -3 , y: 6, duration: 0.2)
        boat.run(moveLeft)
        boat.physicsBody?.applyImpulse(CGVector(dx: -0.05, dy: 0.08))
        timer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene2.changePic), userInfo: nil, repeats: false)
        boatl = false
    }

    func boatRight()
    {   boatr = true
    }
    func bRight()
    {
        moveFloatLeft()
        boat.texture = SKTexture(imageNamed:"boatRight")
       boat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
       // boat.position = CGPoint(x: boat.position.x + 2 , y: boat.position.y + 1)
        let moveRight = SKAction.moveBy(x: 3 , y: 6, duration: 0.2)
        boat.run(moveRight)
        boat.physicsBody?.applyImpulse(CGVector(dx: 0.05, dy: 0.1))
        timer3 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene2.changePic), userInfo: nil, repeats: false)
         boatr = false

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 20, width: self.size.width, height: 10))
      //  scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 0.5
        scrollView.backgroundColor = UIColor.cyan
        self.view?.addSubview(scrollView)


    }
    func boatForward()
    {
         print("forward")
        moveFloat()
        boat.texture = SKTexture(imageNamed:"boatForward")
        boat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        boat.position = CGPoint(x: boat.position.x , y: boat.position.y + 15)
        let moveRight = SKAction.moveBy(x: 0 , y: 10, duration: 0.2)
        boat.run(moveRight)
        boat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.1))
                timer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene2.changePic), userInfo: nil, repeats: false)
        boatr = false
        boatl = false
    }

    func changePic(){
        boat.texture = SKTexture(imageNamed:"boatSteady")
    }
    var label1 = UILabel()
    func addFinishLine(){
        finishLineNode = SKNode()
        let fihishLineSz = CGSize(width: Int(self.size.width), height: 10)
        finishLine = SKSpriteNode(color: UIColor.init(red: 0.01, green: 0.8, blue: 0.0, alpha: 0.9), size: fihishLineSz)
        finishLine.physicsBody = SKPhysicsBody(rectangleOf: fihishLineSz)
        finishLine.position = CGPoint(x: self.size.width/2, y: self.size.height - 20)
        finishLine.physicsBody?.isDynamic = true
        finishLine.physicsBody?.affectedByGravity = false
        finishLine.physicsBody?.categoryBitMask = PhysicsCategory.finishLinePC
        finishLine.physicsBody?.collisionBitMask = 0
        finishLine.physicsBody?.contactTestBitMask = PhysicsCategory.boatPC
        finishLine.color = .red
        finishLine.alpha = 0.5
        finishLine.zPosition = 4
        finishLineNode.addChild(finishLine)
        self.addChild(finishLineNode)

        label1 = UILabel(frame: CGRect(x: 0, y: 20, width: self.size.width, height: 10))
        label1.text = "250 meters"
        label1.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.5)
        label1.textAlignment = .center
       // label1.center = CGPoint(x: self.size.width/2, y: self.size.height - 20)
        label1.textColor = UIColor.yellow
        label1.font = UIFont.init(name: "Optima", size: 10)
        self.view?.addSubview(label1)

    }
    var startLineNode = SKNode()
    var startLine = SKSpriteNode()
    func addStartLine(){
        let startLineSz = CGSize(width: Int(self.size.width), height: 20)
        startLine = SKSpriteNode(color: UIColor.init(red: 0, green: 0.5, blue: 0.5, alpha: 0.1), size: startLineSz)
        startLine.physicsBody = SKPhysicsBody(rectangleOf: startLineSz)
        startLine.position = CGPoint(x:self.size.width/2, y: 5)
        startLine.physicsBody?.isDynamic = false
        startLine.physicsBody?.categoryBitMask = PhysicsCategory.startLine
        startLine.physicsBody?.collisionBitMask = PhysicsCategory.boatPC
        startLine.zPosition = 4
        startLine.color = .yellow
        startLine.alpha = 0.2
        startLineNode.addChild(startLine)
        self.addChild(startLineNode)

    }
    var floatArray = [SKSpriteNode]()
    var floatArrayNode = [SKNode]()
    func addFloat1(){
        for ii in 1...20 {
        for i in 1...2 {
        floatNode = SKNode()
        float1 = SKSpriteNode(imageNamed: "float")
        let float1Sz = CGSize(width: float1.size.width/5, height: float1.size.height/5)
        float1.physicsBody = SKPhysicsBody(rectangleOf: float1Sz)
        float1.physicsBody?.isDynamic = true
        float1.physicsBody?.collisionBitMask = 0
        float1.physicsBody?.affectedByGravity = false
        float1.scale(to: float1Sz)
        float1.zPosition = 6
        float1.position = CGPoint(x: 120 * i, y: 100 * ii)
        let action1 = SKAction.rotate(byAngle: 0.4, duration: 1)
        let action2 = SKAction.rotate(byAngle: -0.4, duration: 1)
        let sequence2 = SKAction.sequence([action1, action1.reversed(),action2,action2.reversed()])
        float1.run(SKAction.repeatForever(sequence2))
        floatArray.append(float1)
        floatNode.addChild(float1)
        floatArrayNode.append(floatNode)

        }
        }
        implementAddFloat()
    }
    func implementAddFloat(){
        for float in floatArrayNode{
            self.addChild(float)
        }

    }
    var waveArray = [SKSpriteNode]()
    var waveArrayNode = [SKNode]()
    var wave = SKSpriteNode()
    var waveNode = SKNode()

   func addWave(){
        for ii in 0...200 {
            for i in 0...7 {
                waveNode = SKNode()
               //wave = SKSpriteNode( imageNamed: "wavea")
               // let waveHt = wave.size.height
                let wavearray = [SKSpriteNode (imageNamed: "wavec"),SKSpriteNode (imageNamed: "wavea")]
                var j = 0
                for waveA in wavearray{
                    j = j + 1
                     wave = waveA
                    let waveSz = CGSize(width: wave.size.width/3, height: wave.size.height/6)
                    wave.scale(to: waveSz)
                    wave.zPosition = 1
                    wave.alpha = 1
                    let rNum =  Int(arc4random_uniform(UInt32(150)))
                    let rNum2 = Int(arc4random_uniform(UInt32(150)))
                    let rNum3 = CGFloat(arc4random_uniform(UInt32(9)))
                    wave.position = CGPoint(x:(100*i) + rNum , y: 5 * ii + (7*j) + rNum2 - 100)
                    let action1 = SKAction.rotate(byAngle: (CGFloat)(rNum3)/100, duration: 1)
                    let action2 = SKAction.rotate(byAngle: -(CGFloat)(rNum3)/100, duration: 0.8)
                    let sequence2 = SKAction.sequence([action1, action1.reversed(),action2,action2.reversed()])
                    wave.run(SKAction.repeatForever(sequence2))
                    let action3 = SKAction.moveBy(x: 0, y: 5, duration: 1)
                    let sequence3 = SKAction.sequence([action3,action3.reversed()])
                    wave.run(SKAction.repeatForever(sequence3))
                    waveArray.append(wave)
                    waveNode.addChild(wave)
                }
                waveArrayNode.append(waveNode)
            }
        }
        implementAddWave()
    }

    func implementAddWave(){
        for wave in waveArrayNode{
            self.addChild(wave)
        }
    }

    var copyOfView = UIViewController()
    var countDownlabel = UILabel()
    var secondsLeft = 0
 //START CLOCK
    func startClock(){
        var hours = Int()
        var minutes = Int()
        var seconds = Int()
        secondsLeft = secondsLeft + 1
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft % 3600) % 60;
        countDownlabel.removeFromSuperview()
        countDownlabel = UILabel(frame: CGRect(x: 25, y: 25 , width: 150, height: 40))
        countDownlabel.textAlignment = .center
        countDownlabel.font = UIFont.init(name: "Optima", size: 20)
        let stringWithFormat = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        countDownlabel.text = stringWithFormat
        self.view?.addSubview(countDownlabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if started == false {
                started = true
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene2.count123), userInfo: nil, repeats: true)
            }

        }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        boat.texture = SKTexture(imageNamed:"boatSteady")
    }
        var timing = UILabel()
    func gameOverMethod(){
        print("gameOverMethod")
        gameStarted = false
        let completedTime = countDownlabel.text
        timing = UILabel(frame: CGRect(x: self.size.width/2 - 150, y: self.size.height/2, width: 300, height: 100))
        timing.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.5)
        timing.textAlignment = .center
        timing.numberOfLines = 0
        // timing.center = CGPoint(x: self.size.width/2, y: self.size.height - 20)
        timing.textColor = UIColor.white
        timing.font = UIFont.init(name: "Optima", size: 20)
        timing.text = "Your Complete Time \n \(completedTime!)"
        self.view?.addSubview(timing)
        addReplay()
        //secondsLeft = 0
    }

    var customView = UIView()

    func popUp()
    {
        print("popupmethod")

       customView = UIView(frame: CGRect(x: 0, y: 0, width: 200 , height: 200))
        customView.backgroundColor = UIColor.init(red: 196/255, green: 113/255, blue: 245/255, alpha:1)
    //    customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//        customView.frame.size = CGSize(width: 100, height: 100)
//        customView.frame.origin = CGPoint(x: 100, y: 100)
  //      addFloat1()
        //self.view?.addSubview(customView)
      //  self.view?.addSubview(customView)

    }

    func moveFloat(){
        for float in floatArray{
            let move1 = SKAction.move(by: (CGVector(dx: 0, dy:-5)), duration: 0.2)
            float.run(move1)
//            float.position = CGPoint(x: float.position.x, y: float.position.y - 1 )
            float.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            float.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -0.03))
        }
        for wave in waveArray{
            let move1 = SKAction.move(by: (CGVector(dx: 0 , dy:-5)), duration: 0.2)
            wave.run(move1)
            //            float.position = CGPoint(x: float.position.x, y: float.position.y - 1 )
            wave.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            wave.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -0.03))
        }
        finishLine.position = CGPoint(x: finishLine.position.x, y: finishLine.position.y - 2 )
        finishLine.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        finishLine.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -0.04))
        label1.frame = CGRect(x: 0, y: label1.frame.origin.y + 2, width: self.size.width, height: 10)

    }

    func moveFloatRight(){
        for float in floatArray{
            let move1 = SKAction.move(by: (CGVector(dx: +1 , dy:-5)), duration: 0.2)
            float.run(move1)
            //            float.position = CGPoint(x: float.position.x, y: float.position.y - 1 )
            float.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            float.physicsBody?.applyImpulse(CGVector(dx: 0.03, dy: -0.03))
        }
        for wave in waveArray{
            let move1 = SKAction.move(by: (CGVector(dx: 1 , dy:-5)), duration: 0.2)
            wave.run(move1)
            //            float.position = CGPoint(x: float.position.x, y: float.position.y - 1 )
            wave.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            wave.physicsBody?.applyImpulse(CGVector(dx: 0.03, dy: -0.03))
        }
        finishLine.position = CGPoint(x: finishLine.position.x, y: finishLine.position.y - 2 )
        finishLine.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        finishLine.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -0.04))
        label1.frame = CGRect(x: 0, y: label1.frame.origin.y + 2, width: self.size.width, height: 10)
        
    }
    func moveFloatLeft(){
        for float in floatArray{
            let move1 = SKAction.move(by: (CGVector(dx: -1 , dy:-5)), duration: 0.2)
            float.run(move1)
            //            float.position = CGPoint(x: float.position.x, y: float.position.y - 1 )
            float.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            float.physicsBody?.applyImpulse(CGVector(dx: -0.03, dy: -0.03))
        }
        for wave in waveArray{
            let move1 = SKAction.move(by: (CGVector(dx: -1 , dy:-5)), duration: 0.2)
            wave.run(move1)
            //            float.position = CGPoint(x: float.position.x, y: float.position.y - 1 )
            wave.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            wave.physicsBody?.applyImpulse(CGVector(dx: -0.03, dy: -0.03))
        }

        finishLine.position = CGPoint(x: finishLine.position.x, y: finishLine.position.y - 2 )
        finishLine.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        finishLine.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -0.04))
        label1.frame = CGRect(x: 0, y: label1.frame.origin.y + 2, width: self.size.width, height: 10)

    }
    var replay = UIButton()
    func addReplay(){
        //add Replay button
        rightButton.removeFromSuperview()
        let replayImage = UIImage(named: "replay") as UIImage?
        replay = UIButton(type: UIButtonType.custom) as UIButton
        replay.frame = (frame: CGRect(x: self.size.width - 20 - (replayImage?.size.width)!/3 , y: self.size.height - 10 - (replayImage?.size.height)!/3, width: (replayImage?.size.width)!/3, height: (replayImage?.size.height)!/3))
        replay.setImage(replayImage, for: .normal)
        replay.addTarget(self, action: #selector(GameScene2.restartMethod), for: .touchUpInside)
        self.view?.addSubview(replay)
        print("addReplay")
    }

    func restartMethod(){
        print("restartme")
        self.removeAllChildren()
        self.removeAllActions()
        self.removeFromParent()
        floatArrayNode.removeAll()
        waveArrayNode.removeAll()
        floatArray.removeAll()
        waveArray.removeAll()
        rightButton.removeFromSuperview()
        timing.removeFromSuperview()
        label1.removeFromSuperview()
        replay.removeFromSuperview()
        countNum.removeFromSuperview()
        countDownlabel.removeFromSuperview()
        gameOver = false
        started = false
        gameStarted = true
        getItTogether()
    }

}





