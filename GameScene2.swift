//
//  GameScene2.swift
//  T2R
//
//  Created by raman maharjan on 2/19/17.
//  Copyright © 2017 raman maharjan. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene2: SKScene {
    var tapleft = UILabel()
    var seaImage = SKSpriteNode()
    var paddleImage1 = SKSpriteNode()
    var boat1Image = SKSpriteNode()

    override func didMove(to view: SKView) {

        //red background
        backgroundColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 1.0)
        //add sea image
        seaImage = SKSpriteNode(imageNamed: "water")
        let seaImageSz = CGSize(width: self.size.width, height: self.size.height)
        seaImage.scale(to: seaImageSz)
        seaImage.zPosition = 1
        seaImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(seaImage)
        //add boat1
        boat1Image = SKSpriteNode(imageNamed: "boatSteady")
        let boat1ImageSz = CGSize(width: boat1Image.size.width/2, height: boat1Image.size.height/2)
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
        //left paddle
        paddleImage1 = SKSpriteNode(imageNamed: "paddle")
        let paddleImage1Sz = CGSize(width: paddleImage1.size.width, height: paddleImage1.size.height)
        paddleImage1.scale(to: paddleImage1Sz)
        paddleImage1.zPosition = 1
        paddleImage1.position = CGPoint(x: self.size.width/20, y: self.size.height/2 + self.size.height/5)
        self.addChild(paddleImage1)



    }

}
