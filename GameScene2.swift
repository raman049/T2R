//
//  GameScene2.swift
//  T2R
//
//  Created by raman maharjan on 2/19/17.
//  Copyright © 2017 raman maharjan. All rights reserved.
//
import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let boat1Image : UInt32 = 0x1 << 1
    static let finishLine : UInt32 = 0x1 << 2
    static let float : UInt32 = 0x1 << 3
}

class GameScene2: SKScene {
    var tapleft = UILabel()
    var right = UILabel()
    var seaImage = SKSpriteNode()
    var paddleImage1 = SKSpriteNode()
    var boat1Image = SKSpriteNode()
    var finishLine = SKSpriteNode()
    var float1 = SKSpriteNode()
    var started = Bool()
    var gameStarted = Bool()
    var gameOver = Bool()
    var leftButton = UIButton()
    var rightButton = UIButton()

    override func didMove(to view: SKView) {

        self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -0.02 )
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
        //add boat1
        boat1Image = SKSpriteNode(imageNamed: "boatSteady")
        let boat1ImageSz = CGSize(width: boat1Image.size.width, height: boat1Image.size.height)
        boat1Image.physicsBody = SKPhysicsBody(rectangleOf: boat1ImageSz)
        boat1Image.physicsBody?.isDynamic = true
        boat1Image.physicsBody?.affectedByGravity = false
        boat1Image.scale(to: boat1ImageSz)
        boat1Image.zPosition = 5
        boat1Image.position = CGPoint(x: self.size.width/2, y: self.size.height/5)
        self.addChild(boat1Image)

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
    var countNum = UILabel()
    var countInt = 0
    var timer = Timer()

    func count123(){
        countInt = countInt + 1
        countNum.removeFromSuperview()
        countNum = UILabel(frame: CGRect(x: self.size.width/2 - 75, y: self.size.height/3 , width: 150, height: 40))
        countNum.textAlignment = .center
        countNum.textColor = UIColor.yellow
        countNum.numberOfLines = 0
        countNum.font = UIFont.init(name: "Optima", size: 30)
        countNum.text = "\(countInt)"
        if  countInt == 4
        {        timer.invalidate()
            countNum.text = "Start"
            gameStarted = true
            //ADD FINISH LINE
            addFinishLine()
            //ADD FLOAT1
            addFloat1()
            boat1Image.physicsBody?.affectedByGravity = true
        }
        self.view?.addSubview(countNum)
    }


    override func update(_ currentTime: CFTimeInterval) {
        if gameStarted == true{
            countNum.removeFromSuperview()
            right.removeFromSuperview()
            tapleft.removeFromSuperview()
            //add left button
          //  let replayImage = UIImage(named: "boatLeft") as UIImage?
            leftButton = UIButton(type: UIButtonType.custom) as UIButton
            leftButton.frame = (frame: CGRect(x: 0 , y: 0 , width: self.size.width/2 , height: self.size.height))
           // leftButton.setImage(replayImage, for: .normal)
            leftButton.addTarget(self, action: #selector(GameScene2.bl), for: .touchUpInside)
            self.view?.addSubview(leftButton)
            //add right button
            //let replayImage = UIImage(named: "boatRight") as UIImage?
            rightButton = UIButton(type: UIButtonType.custom) as UIButton
            rightButton.frame = (frame: CGRect(x: self.size.width/2 + 1 , y: 0 , width: self.size.width/2 , height: self.size.height))
           // rightButton.setImage(replayImage, for: .normal)
            rightButton.addTarget(self, action: #selector(GameScene2.br), for: .touchUpInside)
            self.view?.addSubview(rightButton)

           //addtimer
           Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(GameScene2.startClock),userInfo:nil, repeats: true);

        }
    }

    var timer2 = Timer()
    var timer3 = Timer()

     func bl()
     {
       // print("left")
        boat1Image.texture = SKTexture(imageNamed:"boatLeft")
        boat1Image.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        boat1Image.physicsBody?.applyImpulse(CGVector(dx: -25, dy: 15))
       timer2 =  Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene2.changePic), userInfo: nil, repeats: false)
    }
    func br()
    {
       // print("right")
        boat1Image.texture = SKTexture(imageNamed:"boatRight")
        boat1Image.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        boat1Image.physicsBody?.applyImpulse(CGVector(dx: 25, dy: 15))
      timer3 =   Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene2.changePic), userInfo: nil, repeats: false)
    }
    func changePic(){
        boat1Image.texture = SKTexture(imageNamed:"boatSteady")
    }


    func addFinishLine(){
        finishLine.removeFromParent()
        finishLine = SKSpriteNode(imageNamed: "float")
        let finishLineSz = CGSize(width: self.size.width, height: self.size.height/20)
        finishLine.physicsBody = SKPhysicsBody(rectangleOf: finishLineSz)
        finishLine.physicsBody?.isDynamic = true
        finishLine.physicsBody?.affectedByGravity = true
        finishLine.scale(to: finishLineSz)
        finishLine.zPosition = 6
        finishLine.position = CGPoint(x: 100, y: self.size.height - 5 )
        self.addChild(finishLine)
    }

    func addFloat1(){
        float1.removeFromParent()
        float1 = SKSpriteNode(imageNamed: "float")
        let float1Sz = CGSize(width: float1.size.width, height: float1.size.height)
        float1.physicsBody = SKPhysicsBody(rectangleOf: float1Sz)
        float1.physicsBody?.isDynamic = true
        float1.physicsBody?.affectedByGravity = true
        float1.scale(to: float1Sz)
        float1.zPosition = 6
        float1.position = CGPoint(x: 100, y: self.size.height - 100 )
        let action1 = SKAction.rotate(byAngle: 0.005, duration: 0.2)
        let sequence2 = SKAction.sequence([action1, action1.reversed()])
        float1.run(SKAction.repeatForever(sequence2))
        self.addChild(float1)
    }

  var countDownlabel = UILabel()
    var secondsLeft = 1000
    func startClock(){
        var hours = Int()
        var minutes = Int()
        var seconds = Int()
         secondsLeft = secondsLeft - 1
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
        boat1Image.texture = SKTexture(imageNamed:"boatSteady")
    }

}







