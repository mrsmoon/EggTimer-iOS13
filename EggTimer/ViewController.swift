//
//  ViewController.swift
//  EggTimer
//
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource:soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 150, "Medium": 300, "Hard": 450]
    var totalTime = 0
    var secondsPast = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
       //when pressed another button during progress, all start again!
        timer.invalidate()
        player = nil
        progressBar.progress = 0.0
        secondsPast = 0
    
        let hardness = sender.currentTitle!
        //print(eggTimes[hardness]!)
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        //example functionality
        if secondsPast < totalTime {
            //print("\(secondsPast) seconds")
            secondsPast += 1
            let percentageProgress = Float (secondsPast) / Float (totalTime)
            progressBar.progress = percentageProgress
            
        }else {
            playSound(soundName: "alarm_sound")
            timer.invalidate()
            titleLabel.text = "DONE!"
            
        }
    }
    
}
