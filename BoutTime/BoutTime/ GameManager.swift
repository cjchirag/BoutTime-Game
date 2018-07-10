//
//  GameManager.swift
//  BoutTime
//
//  Created by chirag on 11/07/18.
//  Copyright © 2018 Chirag Jadhwani. All rights reserved.
//

import Foundation
import UIKit
import GameKit

var selectedQuiz = Quiz()
class GameManager {
    var quiz = selectedQuiz
    var score: Int = 0
    var questionsAnswered: Int = 0
    var quizRound: Int {
        return selectedQuiz.allQuestions.count
    }
    
    func randomEventsInRound(for event: Event) -> [String] {
        var temp = ""
        var theEvents: [String] = [event.first, event.second, event.third, event.fourth]
        let index =  GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        for I in 0...index {
            temp = theEvents[I]
            theEvents[I] = theEvents[I+1]
            theEvents[I+1] = temp
        }
        return theEvents
    }
    
    func checkFor(theEvent: Event, first: String, second: String, third: String, fourth: String) -> Bool {
        var check: Bool = false
        if first == theEvent.first {
            if second == theEvent.second {
                if third == theEvent.third {
                    if fourth == theEvent.fourth {
                        self.score += 1
                        check = true
                    }
                }
            }
        }
        return check
    }
}
