//
//  ViewController.swift
//  StopWatch
//
//  Created by Abdirizak Hassan on 10/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var pauseBtn: UIButton!
    
    @IBOutlet var startBtn: UIButton!
    
    @IBOutlet var timerLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    var time = Timer()
    var seconds = 60
    var isStartTime = false
    var resumedTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for btn in buttons {
            btn.layer.cornerRadius = 8
        }
        
        pauseBtn.isEnabled = false
    }
    
    
    func startTime() {
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isStartTime = true
        pauseBtn.isEnabled = true
    }
    
    @objc func updateTimer() {
        if seconds < 0 {
            time.invalidate()
        } else {
            seconds += 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }

    @IBAction func didTapPause(_ sender: UIButton) {
        if resumedTapped == false {
            time.invalidate()
            resumedTapped = true
            pauseBtn.setTitle("Resume", for: .normal)
        } else {
            startTime()
            resumedTapped = false
            pauseBtn.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func didTapStart(_ sender: UIButton) {
        if isStartTime == false {
            startTime()
            startBtn.isEnabled = false
        }else {
            startTime()
            startBtn.isEnabled = true
        }
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        time.invalidate()
        seconds = 0
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isStartTime = false
        pauseBtn.isEnabled = false
        startBtn.isEnabled = true
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
    }
    

}

