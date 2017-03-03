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
}

class GameScene2: SKScene, SKPhysicsContactDelegate {
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
    var float2 = SKSpriteNode()
    var float3 = SKSpriteNode()
    var started = Bool()
    var gameStarted = Bool()
    var gameOver = Bool()
    var leftButton = UIButton()
    var rightButton = UIButton()
    var width = CGFloat()
    var height = CGFloat()


    override func didMove(to view: SKView) {
      //  view.frame.size = CGSize(width: self.size.width*2, height: self.size.height*2)
       // view.frame.origin = CGPoint(x:  self.size.width/2, y: -100)
        width = self.size.width
        height = self.size.height
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -0.1 )
        //red background
        backgroundColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 1.0)
        //add sea image
        seaImage = SKSpriteNode(imageNamed: "water")
        let seaImageSz = CGSize(width: self.size.width*2, height: self.size.height*2)
        seaImage.scale(to: seaImageSz)
        seaImage.zPosition = 1
        seaImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        let sizeUp = SKAction.scale(by: 1.01 , duration: 0.3)
        let spin = SKAction.rotate(byAngle: 0.005, duration: 0.1)
        let sequence = SKAction.sequence([sizeUp, spin, sizeUp.reversed(), spin.reversed()])
        seaImage.run(SKAction.repeatForever(sequence), withKey: "moving")
        self.addChild(seaImage)
        //add boat
        boatNode = SKNode()
        boat = SKSpriteNode(imageNamed: "boatSteady")
        let boat1ImageSz = CGSize(width: boat.size.width/2, height: boat.size.height/2)
        let boat1PhyBodySz = CGSize(width: boat.size.width/5, height: boat.size.height/2)
        boat.physicsBody = SKPhysicsBody(rectangleOf: boat1PhyBodySz)
        boat.physicsBody?.isDynamic = true
        boat.physicsBody?.affectedByGravity = false
        boat.physicsBody?.categoryBitMask = PhysicsCategory.boatPC
        boat.physicsBody?.collisionBitMask = PhysicsCategory.finishLinePC
        boat.physicsBody?.contactTestBitMask = PhysicsCategory.finishLinePC
        boat.scale(to: boat1ImageSz)
        boat.zPosition = 5
        boat.position = CGPoint(x: self.size.width/2, y: self.size.height/5)
        boatNode.addChild(boat)
        self.addChild(boatNode)

        //left tap to row left
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
    override func update(_ currentTime: CFTimeInterval) {
        if gameStarted == true{
            boat.physicsBody?.affectedByGravity = true
            countNum.removeFromSuperview()
            right.removeFromSuperview()
            tapleft.removeFromSuperview()
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
        countNum.numberOfLines = 0
        countNum.font = UIFont.init(name: "Optima", size: 30)
        countNum.text = "\(countInt)"
        if  countInt == 2{   ///////////*********change count to 4****** //////////
            timer.invalidate()
            countNum.text = "Start"
            gameStarted = true
            popUp()
        //ADD FINISH LINE
            addFinishLine()
        //ADD FLOAT1
            addFloat1()
            addStartLine()
        }
        self.view?.addSubview(countNum)
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
        moveFloat()
        boat.texture = SKTexture(imageNamed:"boatLeft")
        boat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        boat.position = CGPoint(x: boat.position.x - 2 , y: boat.position.y + 1)
    //    boat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1))
        timer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene2.changePic), userInfo: nil, repeats: false)
        boatl = false
    }

    func boatRight()
    {   boatr = true
    }
    func bRight()
    {
        moveFloat()
        boat.texture = SKTexture(imageNamed:"boatRight")
        boat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        boat.position = CGPoint(x: boat.position.x + 2 , y: boat.position.y + 1)
    //    boat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1))
        timer3 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene2.changePic), userInfo: nil, repeats: false)
         boatr = false

    }
    func boatForward()
    {
         print("forward")
        moveFloat()
        boat.texture = SKTexture(imageNamed:"boatForward")
        boat.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
       // boat.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 3))
        boat.position = CGPoint(x: boat.position.x , y: boat.position.y + 3)
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

        finishLine.physicsBody = SKPhysicsBody(rectangleOf: fihishLineSz)
        finishLine.position = CGPoint(x: self.size.width/2, y: self.size.height - 20)
        finishLine.physicsBody?.isDynamic = true
        finishLine.physicsBody?.affectedByGravity = false
        finishLine.physicsBody?.categoryBitMask = PhysicsCategory.finishLinePC
        finishLine.physicsBody?.collisionBitMask = PhysicsCategory.boatPC
        finishLine.physicsBody?.contactTestBitMask = PhysicsCategory.boatPC
        finishLineNode.addChild(finishLine)

//        let lapLine = SKLabelNode(fontNamed: "Optima")
//        lapLine.text = "250 meters"
//        lapLine.fontSize = 10
//        lapLine.fontColor = SKColor.yellow
//        lapLine.position = CGPoint(x:self.size.width/2, y: 5)
//        self.addChild(lapLine)
        label1 = UILabel(frame: CGRect(x: 0, y: 20, width: frame.size.width, height: 10))
        label1.text = "250 meters"
        label1.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.5)
        label1.textAlignment = .center
       // label1.center = CGPoint(x: self.size.width/2, y: self.size.height - 20)
        label1.textColor = UIColor.yellow
        label1.font = UIFont.init(name: "Optima", size: 10)
        self.view?.addSubview(label1)
         self.addChild(finishLineNode)
    }
    var startLineNode = SKNode()
    var startLine = SKSpriteNode()
    func addStartLine(){
        let startLineSz = CGSize(width: Int(self.size.width), height: 20)
        startLine.physicsBody = SKPhysicsBody(rectangleOf: startLineSz)
        startLine.position = CGPoint(x:self.size.width/2, y: 5)
        startLine.physicsBody?.isDynamic = false
        startLine.color = UIColor(displayP3Red: 0, green: 0.5, blue: 0.3, alpha: 0.5)
        startLineNode.addChild(startLine)
        self.addChild(startLineNode)
    }
    var floatArray = [SKSpriteNode]()

    func addFloat1(){
        for ii in 1...20 {
        for i in 1...2 {
        floatNode = SKNode()
        float1 = SKSpriteNode(imageNamed: "float")
        let float1Sz = CGSize(width: float1.size.width/3, height: float1.size.height/3)
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
        }
        }
        implementAddFloat()
    }
    func implementAddFloat(){
        for float in floatArray{
            self.addChild(float)
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
    func gameOverMethod(){
        print("gameOverMethod")
    }

    var customView = UIView()

    func popUp()
    {
        print("popupmethod")

       customView = UIView(frame: CGRect(x: 0, y: 0, width: 200 , height: 200))
        customView.backgroundColor = UIColor.init(red: 196/255, green: 113/255, blue: 245/255, alpha: 1/255)
    //    customView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//        customView.frame.size = CGSize(width: 100, height: 100)
//        customView.frame.origin = CGPoint(x: 100, y: 100)
  //      addFloat1()
        //self.view?.addSubview(customView)
        self.view?.addSubview(customView)

    }

    func moveFloat(){
        for float in floatArray{
            float.position = CGPoint(x: float.position.x, y: float.position.y - 2 )
            float.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            float.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -0.04))
        }
        finishLine.position = CGPoint(x: finishLine.position.x, y: finishLine.position.y - 2 )
        finishLine.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        finishLine.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -0.04))
        label1.center = CGPoint(x: frame.size.width/2, y: label1.frame.origin.y - 2 )

    }



}





