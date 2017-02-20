//
//  GameScene.swift
//  T2R
//
//  Created by raman maharjan on 2/18/17.
//  Copyright © 2017 raman maharjan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var playButton = UIButton()
    var instructionQueButP1 = UIButton()
    var gcButtonP1 = UIButton()


        override func didMove(to view: SKView) {

            //red background
            backgroundColor = UIColor.init(red: 1, green: 0, blue: 0.0, alpha: 1.0)
            //add drum1
            let drum1Image = SKSpriteNode(imageNamed: "drum1")
            let drum1ImageSz = CGSize(width: drum1Image.size.width, height: drum1Image.size.height)
            drum1Image.scale(to: drum1ImageSz)
            drum1Image.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.addChild(drum1Image)
            //add drum1
            let t2rImage = SKSpriteNode(imageNamed: "t2r")
            let t2rImageSz = CGSize(width: t2rImage.size.width, height: t2rImage.size.height)
            t2rImage.scale(to: t2rImageSz)
            t2rImage.position = CGPoint(x: self.size.width/2, y: self.size.height - self.size.height/5)
            self.addChild(t2rImage)

            let playImage = UIImage(named: "play") as UIImage?
            playButton = UIButton(type: UIButtonType.custom) as UIButton
            playButton.frame = (frame: CGRect(x: self.size.width/2 - (playImage?.size.width)!/6 , y: self.size.height/2 + 10 , width:(playImage?.size.width)!/3, height: (playImage?.size.height)!/3))
            playButton.setImage(playImage, for: .normal)
            playButton.addTarget(self, action: #selector(GameScene.page2), for: .touchUpInside)
            self.view?.addSubview(playButton)
            //add instruction and scoreboard
            // add instruction
            let instructionQueImg = UIImage(named: "instructionQue") as UIImage?
            instructionQueButP1.removeFromSuperview()
            instructionQueButP1   = UIButton(type: UIButtonType.custom) as UIButton
            instructionQueButP1.frame = (frame: CGRect(x: 10, y: self.size.height - 10 - (instructionQueImg?.size.height)!/3, width: (instructionQueImg?.size.width)!/3, height: (instructionQueImg?.size.height)!/3))
            instructionQueButP1.setImage(instructionQueImg, for: .normal)
       //     instructionQueButP1.addTarget(self, action: #selector(GameScene0.popUpP1), for: .touchUpInside)
            self.view?.addSubview(instructionQueButP1)
            //add gc
            let gcButtonImage = UIImage(named: "scoreboard") as UIImage?
            gcButtonP1.removeFromSuperview()
            gcButtonP1 = UIButton(type: UIButtonType.custom) as UIButton
            gcButtonP1.frame = (frame: CGRect(x: 20 + (gcButtonImage?.size.width)!/3 , y: self.size.height - 10 - (gcButtonImage?.size.height)!/3, width: (gcButtonImage?.size.width)!/3, height: (gcButtonImage?.size.height)!/3))
            gcButtonP1.setImage(gcButtonImage, for: .normal)
      //      gcButtonP1.addTarget(self, action: #selector(GameScene0.showGCP2), for: .touchUpInside)
            self.view?.addSubview(gcButtonP1)


    }
    func page2(){
        playButton.removeFromSuperview()
        gcButtonP1.removeFromSuperview()
        instructionQueButP1.removeFromSuperview()

        let scene = GameScene2(size: (view?.bounds.size)!)
        let skView = self.view
        skView?.showsFPS = false
        skView?.showsNodeCount = false
        skView?.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView?.presentScene(scene)
    }



}
