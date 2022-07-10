//
//  ViewController.swift
//  EggTimer
//
//  Created by Nick Konstantinou on 4/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    var passedSeconds: Int?
    var timer: Timer?
    var startingTimeValue: Int?
    var player: AudioPlayer?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleProgressBar(show: false)
        player = AudioPlayer()
    }
    
    func toggleProgressBar(show: Bool) {
        progressBar.alpha = show ? 1 : 0
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer?.invalidate()
        titleLabel.text = Constants.originalTitleLabel

        guard let buttonChoice = sender.currentTitle else {return }
        
        guard let hardnessTime = Constants.eggTimes[buttonChoice] else {
            print("Didn't find time for specific hardness")
            return
        }
        
        passedSeconds = 0
        startingTimeValue = hardnessTime
        progressBar.progress = 0.0
        toggleProgressBar(show: true)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if passedSeconds != nil  && startingTimeValue != nil {
            if passedSeconds! < startingTimeValue! {
                passedSeconds! += 1
                updateProgressBar()
            } else {
                timer?.invalidate()
                titleLabel.text = Constants.DoneTitleLabel
                toggleProgressBar(show: false)
                player?.playSound()
                
            }
        }
    }
    
    func updateProgressBar() {
        guard let initialFullTime = startingTimeValue else { return }
        guard let currentSecondsRemaining = passedSeconds else { return }
        
        let currentProgress: Float = Float(currentSecondsRemaining) / Float(initialFullTime)
        
        progressBar.setProgress(currentProgress, animated: true)
    }
    
}

