//
//  PlayViewController.swift
//  BoutTime
//
//  Created by chirag on 05/07/18.
//  Copyright © 2018 Chirag Jadhwani. All rights reserved.
//

import Foundation
import UIKit
import GameKit

class PlayViewController: UIViewController {
    var currentEvent: Event?
    let gameManager = GameManager()
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var firstEvent: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var secondEvent: UILabel!
    @IBOutlet weak var thirdEvent: UILabel!
    @IBOutlet weak var fourthEvent: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    override func viewDidLoad() {
        self.becomeFirstResponder()
        loadQuestion()
        firstEvent.backgroundColor = UIColor(named: "white")
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 200, alpha: 1)
    }
    
    func loadQuestion() {
        
        infoImage.isHidden = true
        infoLabel.isHidden = false
        infoLabel.text = "Shake to complete"
        timerLabel.isHidden = false
        let theEvent = gameManager.quiz.eventsGenerator()
        currentEvent = theEvent
        
         var temp = ""
         var theEvents: [String] = [theEvent.first, theEvent.second, theEvent.third, theEvent.fourth]
         let index =  GKRandomSource.sharedRandom().nextInt(upperBound: 3)
         for I in 0...index {
         temp = theEvents[I]
         theEvents[I] = theEvents[I+1]
         theEvents[I+1] = temp
         }
        
        firstEvent.text = theEvents[0]
        secondEvent.text = theEvents[1]
        thirdEvent.text = theEvents[2]
        fourthEvent.text = theEvents[3]
        runTimer()
    }
    
    @IBAction func oneToTwo(_ sender: Any) {
        guard let temp = firstEvent.text else { return }
        firstEvent.text = secondEvent.text
        secondEvent.text = temp
    }
    
    @IBAction func twoToOne(_ sender: Any) {
        guard let temp = secondEvent.text else { return }
        secondEvent.text = firstEvent.text
        firstEvent.text = temp
    }
    
    @IBAction func twoToThree(_ sender: Any) {
        guard let temp = secondEvent.text else { return }
        secondEvent.text = thirdEvent.text
        thirdEvent.text = temp
    }
    
    @IBAction func threeToTwo(_ sender: Any) {
        guard let temp = thirdEvent.text else { return }
        thirdEvent.text = secondEvent.text
        secondEvent.text = temp
    }
    
    @IBAction func threeToFour(_ sender: Any) {
        guard let temp = fourthEvent.text else { return }
        fourthEvent.text = thirdEvent.text
        thirdEvent.text = temp
    }
    
    @IBAction func fourToThree(_ sender: Any) {
        guard let temp = thirdEvent.text else { return }
        thirdEvent.text = fourthEvent.text
        fourthEvent.text = temp
    }
    
    
    
    
    func loadScore() {
        firstEvent.isHidden = true
        secondEvent.isHidden = true
        thirdEvent.isHidden = true
        fourthEvent.isHidden = true
        
        if gameManager.score < gameManager.quizRound {
            // FIXME: display for score load.
        } else {
            
        }
    }
    func nextRound() {
        if gameManager.questionsAnswered == gameManager.quizRound {
            loadScore()
        } else {
            loadQuestion()
        }
    }
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(PlayViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        
        timerLabel.text = "\(seconds)" //This will update the label.
            if seconds == 0 {
                gameManager.questionsAnswered += 1
                guard let currentQs = currentEvent else {return}
                guard let firstEvent = firstEvent.text else {return}
                guard let secondEvent = secondEvent.text else {return}
                guard let thirdEvent = thirdEvent.text else {return}
                guard let fourthEvent = fourthEvent.text else {return}
                
                    let checkAnswer =  gameManager.checkFor(theEvent: currentQs, first: firstEvent, second: secondEvent, third: thirdEvent, fourth: fourthEvent)
                    if checkAnswer {
                        infoImage.isHidden = false
                        infoImage.image = UIImage(named: "next_round_success")
                        timerLabel.isHidden = true
                        timer.invalidate()
                        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
                        infoLabel.text = "Tap events to learn more"
                        loadNextRound(delay: 1)
                    } else {
                        infoImage.isHidden = false
                        infoImage.image = UIImage(named: "next_round_fail")
                        timerLabel.isHidden = true
                        timer.invalidate()
                        infoLabel.text = "Tap events to learn more"
                        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
                        timerLabel.text = "\(seconds)"
                        loadNextRound(delay: 1)
                    }
                
            }
        seconds -= 1     //This will decrement(count down)the seconds.
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        gameManager.questionsAnswered += 1
        print("Device was shaken!")
        guard let currentQs = currentEvent else {return}
        guard let firstEvent = firstEvent.text else {return}
        guard let secondEvent = secondEvent.text else {return}
        guard let thirdEvent = thirdEvent.text else {return}
        guard let fourthEvent = fourthEvent.text else {return}
       
        let checkAnswer = gameManager.checkFor(theEvent: currentQs, first: firstEvent, second: secondEvent, third: thirdEvent, fourth: fourthEvent)
            if checkAnswer {
                // FIXME: check answer labels
                infoImage.isHidden = false
                infoImage.image = UIImage(named: "next_round_success")
                timerLabel.isHidden = true
                infoLabel.text = "Tap events to know more"
            } else {
                infoImage.isHidden = false
                infoImage.image = UIImage(named: "next_round_fail")
                timerLabel.isHidden = true
                infoLabel.text = "Tap events to know more"
            }
        
        timer.invalidate()
        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.text = "\(seconds)"
        loadNextRound(delay: 1)
    }
}








