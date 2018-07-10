//
//  Quiz.swift
//  BoutTime
//
//  Created by chirag on 11/07/18.
//  Copyright © 2018 Chirag Jadhwani. All rights reserved.
//

import Foundation
import UIKit
import GameKit

class Quiz {
    
    let allQuestions: [Event] = [event1, event2, event3, event4, event5, event6, event7, event8, event9, event10, event11, event12, event13, event14, event15, event16, event17, event18, event19, event20, event21, event22, event23, event24, event25]
    let firstEvent: String = ""
    let secondEvent: String = ""
    let thirdEvent: String = ""
    let fourthEvent: String = ""
    let correctArrayOfEvents: [String] = []
    var arrayOfEvents: [String] = []
    
    var askedIndices: [Int] = []
    // randomising questions in the allQuestions array
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
