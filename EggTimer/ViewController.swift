//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    var result = 0
    
    var totalTime: Float = 0
    var progressTime: Float = 1
    var percentageBar: Float = 0
    
    @IBOutlet weak var timerCountdown: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    let eggTime = [ "Soft" : 5, "Medium" : 7, "Hard" : 12]
    
    @IBAction func maturitySelected(_ sender: UIButton) {
        let maturity = sender.currentTitle!
        totalTime = Float(eggTime[maturity]!)
        timer()
       
        
        
        
        percentageBar = 0
        progressTime = 1
    }
    
    func playSound() {
                guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                        try AVAudioSession.sharedInstance().setActive(true)

                        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                        /* iOS 10 and earlier require the following line:
                        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                        guard let player = player else { return }

                        player.play()

                    } catch let error {
                        print(error.localizedDescription)
                    }
            }
    
    func timer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.progressTime < self.totalTime {
                self.timerCountdown.text = "\(Int(self.progressTime))"
                    print ("\(self.progressTime) seconds")
                   
                    self.percentageBar = self.progressTime/self.totalTime
                    print((self.percentageBar ), "proses")
                    
                    self.progressBar.progress = Float(self.percentageBar)
                
                    self.progressTime += 1
                } else {
                    self.progressBar.progress = 1
                    Timer.invalidate()
                    self.timerCountdown.text = "Done!"
                    self.playSound()
                }
            }
    }
    
}
