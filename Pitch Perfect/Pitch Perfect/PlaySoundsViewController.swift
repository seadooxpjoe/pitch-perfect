//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by user on 3/7/15.
//  Copyright (c) 2015 V1 Online. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var myPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        myPlayer = setupAudio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAudio() -> AVAudioPlayer {
        var error: NSError?
        
        var player:AVAudioPlayer
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: &error)
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        return player
    }
    
    @IBAction func playSlowly(sender: UIButton) {

        myPlayer.stop()
        myPlayer.enableRate = true
        myPlayer.rate = 0.5
        myPlayer.play()
    }

    @IBAction func playQuickly(sender: UIButton) {
      
        myPlayer.stop()
        myPlayer.enableRate = true
        myPlayer.rate = 1.5
        myPlayer.play()
    }
    
    @IBAction func playChipmonk(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playVader(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        myPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopplay(sender: UIButton) {
        myPlayer.stop()
    }
   
}
