//
//  ViewController.swift
//  Exercise 2
//
//  Created by Mark Rassamni on 7/20/16.
//  Copyright © 2016 markrassamni. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var attackBtnOne: UIButton!
    @IBOutlet weak var attackBtnTwo: UIButton!
    @IBOutlet weak var playerOneOgre: UIImageView!
    @IBOutlet weak var playerOneKnight: UIImageView!
    @IBOutlet weak var playerTwoKnight: UIImageView!
    @IBOutlet weak var playerTwoOgre: UIImageView!
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var restartButton: UIButton!
   
    @IBOutlet weak var playerOneSelectKnight: UIButton!
    @IBOutlet weak var playerOneSelectOgre: UIButton!
    @IBOutlet weak var playerOneBG: UIImageView!
    @IBOutlet weak var playerOneLbl: UILabel!
    @IBOutlet weak var playerTwoSelectOgre: UIButton!
    @IBOutlet weak var playerTwoSelectKnight: UIButton!
    @IBOutlet weak var playerTwoBG: UIImageView!
    @IBOutlet weak var playerTwoLbl: UILabel!
    
    var playerOneReady = false
    var playerTwoReady = false
    
    var playerOne: Character!
    var playerTwo: Character!
    
    var musicBG: AVAudioPlayer!
    var knightAttacked: AVAudioPlayer!
    var ogreAttacked: AVAudioPlayer!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLbl.text = "Select Characters"
        backgroundMusic()
        let knightPath = NSBundle.mainBundle().pathForResource("knightAttacked", ofType: "wav")
        let knightURL = NSURL(fileURLWithPath: knightPath!)
        
        do{
            try knightAttacked = AVAudioPlayer(contentsOfURL: knightURL)
            knightAttacked.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        let ogrePath = NSBundle.mainBundle().pathForResource("ogreAttacked", ofType: "wav")
        let ogreURL = NSURL(fileURLWithPath: ogrePath!)
        
        do{
            try ogreAttacked = AVAudioPlayer(contentsOfURL: ogreURL)
            ogreAttacked.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func playerOneKnightSelected(sender: AnyObject) {
        playerOne = Knight(hp: 100, ap: 15)
        playerOneSelectedChar()
        playerOneKnight.hidden = false
    }
    
    @IBAction func playerOneOgreSelected(sender: AnyObject) {
        playerOne = Ogre(hp: 150, ap: 10)
        playerOneSelectedChar()
        playerOneOgre.hidden = false
    }
    
    @IBAction func playerTwoKnightSelected(sender: AnyObject) {
        playerTwo = Knight(hp: 100, ap: 15)
        playerTwoSelectedChar()
        playerTwoKnight.hidden = false
    }
    
    @IBAction func playerTwoOgreSelected(sender: AnyObject) {
        playerTwo = Ogre(hp: 150, ap: 10)
        playerTwoSelectedChar()
        playerTwoOgre.hidden = false
    }
    
    @IBAction func playerOneAttacked(sender: AnyObject) {
        if attackBtnTwo.hidden == false{
            if playerTwo.type == "Knight"{
                knightAttackedSound()
            } else if playerTwo.type == "Ogre"{
                ogreAttackedSound()
            }
            attackBtnTwo.hidden = true
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.showPlayerTwoAttack), userInfo: nil, repeats: false)
            playerTwo.attacked(playerOne.ap)
            if playerTwo.isAlive(){
                outputLbl.text = "Player 1 attacks for \(playerOne.ap) damage, \(playerTwo.hp) HP remaining."
            } else{
                outputLbl.text = "Player 2 has died. Player 1 Wins!"
                playerTwoOgre.hidden = true
                playerTwoKnight.hidden = true
                attackBtnOne.hidden = true
                attackBtnTwo.hidden = true
                restartButton.hidden = false
            }
        }
    }
    
    @IBAction func playerTwoAttacked(sender: AnyObject) {
        if attackBtnOne.hidden == false{
            if playerOne.type == "Knight"{
                knightAttackedSound()
            } else if playerOne.type == "Ogre"{
                ogreAttackedSound()
            }
            attackBtnOne.hidden = true
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.showPlayerOneAttack), userInfo: nil, repeats: false)
            playerOne.attacked(playerTwo.ap)
            if playerOne.isAlive(){
                outputLbl.text = "Player 2 attacks for \(playerTwo.ap) damage, \(playerOne.hp) HP remaining."
            } else{
                outputLbl.text = "Player 1 has died. Player 2 Wins!"
                playerOneOgre.hidden = true
                playerOneKnight.hidden = true
                attackBtnOne.hidden = true
                attackBtnTwo.hidden = true
                restartButton.hidden = false
            }
        }
    }
    
    func showPlayerOneAttack (){
        if playerOne.isAlive(){
            attackBtnOne.hidden = false
        }
    }
    
    func showPlayerTwoAttack (){
        if playerTwo.isAlive(){
            attackBtnTwo.hidden = false
        }
    }
    
    @IBAction func restartPressed(sender: AnyObject) {
        playerOneReady = false
        playerTwoReady = false
        
        outputLbl.text = "Select Characters"
        playerOneOgre.hidden = true
        playerOneKnight.hidden = true
        playerTwoOgre.hidden = true
        playerTwoKnight.hidden = true
        attackBtnOne.hidden = true
        attackBtnTwo.hidden = true
        restartButton.hidden = true
        
        playerOneSelectOgre.hidden = false
        playerOneSelectKnight.hidden = false
        playerTwoSelectOgre.hidden = false
        playerTwoSelectKnight.hidden = false
        playerOneBG.hidden = false
        playerOneLbl.hidden = false
        playerTwoBG.hidden = false
        playerTwoLbl.hidden = false
    }
    
    func playerOneSelectedChar() {
        playerOneBG.hidden = true
        playerOneSelectOgre.hidden = true
        playerOneSelectKnight.hidden = true
        playerOneLbl.hidden = true
        playerOneReady = true
        startGame()
    }
    
    func playerTwoSelectedChar() {
        playerTwoBG.hidden = true
        playerTwoSelectKnight.hidden = true
        playerTwoSelectOgre.hidden = true
        playerTwoLbl.hidden = true
        playerTwoReady = true
        startGame()
    }
    
    func startGame(){
        if playerOneReady && playerTwoReady {
            outputLbl.text = "Press attack to begin."
            attackBtnOne.hidden = false
            attackBtnTwo.hidden = false
        }
    }
    
    func knightAttackedSound(){
        if knightAttacked.playing{
            knightAttacked.stop()
        }
        knightAttacked.play()
    }
    
    func ogreAttackedSound (){
        if ogreAttacked.playing{
            ogreAttacked.stop()
        }
        ogreAttacked.play()
    }
    
    func backgroundMusic(){
        let soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("musicBG", ofType: "mp3")!)
        
        do{
            try musicBG = AVAudioPlayer(contentsOfURL: soundURL)
            musicBG.numberOfLoops = -1
            musicBG.prepareToPlay()
            musicBG.play()
        } catch let err as NSError {
            print (err.debugDescription)
            
        }
    }
}

