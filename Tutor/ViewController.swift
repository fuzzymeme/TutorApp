//
//  ViewController.swift
//  Tutor
//
//  Created by Fuzzymeme on 23/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QandAViewListener {
    
    private let model = QandAViewModel()
    
    @IBOutlet weak var qandAView: QandAView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        model.loadModel()
        qandAView.setDelegate(self)
        
        setAnswers()
    }
    
    func handleButtonTouchedEvent(buttonIndex: Int) {
        print("Controller handles button touched event: \(buttonIndex)")
        if model.isCorrect(buttonIndex) {
            qandAView.displaySuccess = "Correct"
        } else {
            qandAView.displaySuccess = "Wrong"
        }
    }
    
    // MARK: - Logic
    private func setAnswers() {
        let entry = randomEntry()
        let correctAnswerPosition = randomInt(limit: 4)
        model.setIndexOfCorrectAnswer(newValue: correctAnswerPosition)
        qandAView.question = "What is \"\(entry.german)\" in English?"
        qandAView.option(correctAnswerPosition, setTo: entry.english)
        
        var alreadyChosenIds = [entry.id]
        
        for i in 0...3 {
            if i != correctAnswerPosition {
                let otherEntry = randomEntry(notIn: alreadyChosenIds)
                qandAView.option(i, setTo: otherEntry.english)
                alreadyChosenIds.append(otherEntry.id)
            }
        }
    }
    
    private func moveToNextQuestion() {
        
    }

    private func randomEntry(notIn alreadyChosenIds: [Int]) -> KnowledgeEntry {
        var entry = model.entry(randomInt(limit: model.count()))
        while(alreadyChosenIds.contains(entry.id)) {
            entry = model.entry(randomInt(limit: model.count()))
        }
        return entry
    }

    private func randomEntry() -> KnowledgeEntry {
        return model.entry(randomInt(limit: model.count()))
    }

    // MARK: - Helpers
    private func randomInt(limit: Int) -> Int {
        return Int(arc4random_uniform(UInt32(limit)))
    }

}

