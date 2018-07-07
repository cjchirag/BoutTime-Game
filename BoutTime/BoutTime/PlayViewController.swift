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
        
    }
    
    func loadQuestion() {
        let theQuestion = gameManager.quiz.eventsGenerator().randomiseEvents()
        firstEvent.text = theQuestion[0]
        secondEvent.text = theQuestion[1]
        thirdEvent.text = theQuestion[2]
        fourthEvent.text = theQuestion[3]
    }
}
