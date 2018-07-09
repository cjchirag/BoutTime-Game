//
//  Events.swift
//  BoutTime
//
//  Created by chirag on 05/07/18.
//  Copyright © 2018 Chirag Jadhwani. All rights reserved.
//

import Foundation
import UIKit
import GameKit

struct Event {
    var first: String
    var second: String
    var third: String
    var fourth: String
    }

var event1: Event = Event(first: "Video game console invented by  Ralph H. Baer", second: "The moon landing - Neil Armstrong sets foot on the moon", third: "E-mail invented by  Ray Tomlinson", fourth: "Liquid Crystal Display invented by James Fergason")
var event2: Event = Event(first: "H.W Bush", second: "Clinton", third: "Bush", fourth: "Obama")
var event3: Event = Event(first: "Personal computer invented by Xerox PARC", second: "Camcorder invented by  Sony", third: "World Wide Web invented by Tim Berners-Lee", fourth: "Digital satellite radio")
var event4: Event = Event(first: "Lord Mountbatten resigned as the Governor General of India", second: "India becomes a republic", third: "The Battle of Garibpur: Indian troops defeated Pakistan army", fourth: "India became 6th nation to explode an atomic bomb")
var event5: Event = Event(first: "Delhi court decriminalizes gay sex", second: "India wins cricket world cup after 28 years", third: "India becomes a member of Missile Technology Control Regime.", fourth: "The Goods and Services Tax (GST) launched, the biggest tax reform in history of India.")
var event6: Event = Event(first: "Christopher Latham Sholes invents the modern typewriter and QWERTY keyboard", second: "Thomas Edison invents his sound-recording machine or phonograph—a forerunner of the record player and CD player", third: "Thomas Edison patents the modern incandescent electric lamp", fourth: "Thomas Edison opens the world's first power plants")



class Quiz {
    let allQuestions: [Event] = [event1, event2, event3, event4, event5, event6]
    let firstEvent: String = ""
    let secondEvent: String = ""
    let thirdEvent: String = ""
    let fourthEvent: String = ""
    let correctArrayOfEvents: [String] = []
    var arrayOfEvents: [String] = []
    
    var askedIndices: [Int] = []
    
    func eventsGenerator() -> Event {
        let index =  GKRandomSource.sharedRandom().nextInt(upperBound: allQuestions.count)
            if !(self.askedIndices.contains(index)) {
            self.askedIndices.append(index)
            return allQuestions[index]
            } else {
                return self.eventsGenerator()
            }
    }
}

enum ErrorsInAnswers: String, Error {
    case IncorrectOrderOfEvents
}

var selectedQuiz = Quiz()
class GameManager {
    var quiz = selectedQuiz
    var score: Int = 0
    var questionsAnswered: Int = 0
    var quizRound: Int {
        return selectedQuiz.allQuestions.count
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



















