//
//  PlayViewController.swift
//  BoutTime
//
//  Created by chirag on 05/07/18.
//  Copyright © 2018 Chirag Jadhwani. All rights reserved.
//

import Foundation
import UIKit

class PlayViewController: UIViewController {
    var currentEvent: Event?
    let gameManager = GameManager()
    @IBOutlet weak var firstEvent: UILabel!
    @IBOutlet weak var secondEvent: UILabel!
    @IBOutlet weak var thirdEvent: UILabel!
    @IBOutlet weak var fourthEvent: UILabel!
    
    override func viewDidLoad() {
        self.becomeFirstResponder()
    }
    
    func loadQuestion() {
        let theEvent = gameManager.quiz.eventsGenerator()
        currentEvent = theEvent
        let theQuestions = theEvent.randomiseEvents()
        firstEvent.text = theQuestions[0]
        secondEvent.text = theQuestions[1]
        thirdEvent.text = theQuestions[2]
        fourthEvent.text = theQuestions[3]
    }
    func loadScore() {
        firstEvent.isHidden = true
        secondEvent.isHidden = true
        thirdEvent.isHidden = true
        fourthEvent.isHidden = true
        
        if gameManager.score < gameManager.quizRound {
            // FIXME: display for score load.
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
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("Device was shaken!")
        guard let currentQs = currentEvent else {return}
        do {
        let checkAnswer = try gameManager.checkFor(theEvent: currentQs, first: firstEvent.text!, second: secondEvent.text!, third: thirdEvent.text!, fourth: fourthEvent.text!)
            if checkAnswer {
                // FIXME: check answer labels
            } else {
                
            }
        } catch {
            
        }
    }
    
    
    
    
    
    
    
    
    
    
}








