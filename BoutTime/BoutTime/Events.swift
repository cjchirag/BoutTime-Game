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

var event1: Event = Event(first: "This is the first event occured #1", second: "This is the second event occured", third: "This is the third event occured #3", fourth: "This is the fourth event occured #4")
var event2: Event = Event(first: "This is the first event occured #1", second: "This is the second event occured", third: "This is the third event occured #3", fourth: "This is the fourth event occured #4")
var event3: Event = Event(first: "This is the first event occured #1", second: "This is the second event occured", third: "This is the third event occured #3", fourth: "This is the fourth event occured #4")
var event4: Event = Event(first: "This is the first event occured #1", second: "This is the second event occured", third: "This is the third event occured #3", fourth: "This is the fourth event occured #4")
var event5: Event = Event(first: "This is the first event occured #1", second: "This is the second event occured", third: "This is the third event occured #3", fourth: "This is the fourth event occured #4")
var event6: Event = Event(first: "This is the first event occured #1", second: "This is the second event occured", third: "This is the third event occured #3", fourth: "This is the fourth event occured #4")



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
    
    func checkFor(theEvent: Event, first: String, second: String, third: String, fourth: String) throws -> Bool {
        if first == theEvent.first {
            if second == theEvent.second {
                if third == theEvent.third {
                    if fourth == theEvent.fourth {
                        self.score += 1
                        return true
                    } else {
                        throw ErrorsInAnswers.IncorrectOrderOfEvents
                    }
                } else {
                    throw ErrorsInAnswers.IncorrectOrderOfEvents
                }
            } else {
                throw ErrorsInAnswers.IncorrectOrderOfEvents
            }
        } else {
            throw ErrorsInAnswers.IncorrectOrderOfEvents
        }
    }
}



















