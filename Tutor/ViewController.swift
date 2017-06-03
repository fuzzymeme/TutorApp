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
    private let questionTemplate = "What is $german in English?"
    
    @IBOutlet weak var qandAView: QandAView!
    
    override func viewWillAppear(_ animated: Bool) {        
        model.loadModel()
        qandAView.setDelegate(self)
        setupView()
        setAnswers()
    }
    
    private func setupView() {
        qandAView.setBackground(color: UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0))
        qandAView.setButtonsBackground(color: UIColor.white)
        qandAView.successLabel.isHidden = true
        qandAView.setSkipNextButtonBackground(color: UIColor.gray)
    }
    
    func handleButtonTouchedEvent(buttonIndex: Int) {
        qandAView.setSkipNextButtonText(newText: "Next")
        qandAView.successLabel.isHidden = false

        if model.isCorrect(buttonIndex) {
            qandAView.displaySuccess = true
        } else {
            qandAView.displaySuccess = false
        }
    }
    
    func handleSkipButtonTouchedEvent() {
        setAnswers()
    }
    
    // MARK: - Logic
    private func setAnswers() {
        let entry = randomEntry()
        let correctAnswerPosition = randomInt(limit: 4)
        model.setIndexOfCorrectAnswer(newValue: correctAnswerPosition)        
        qandAView.question = Utils.completeTemplate(questionTemplate, replace: "$german", with: entry.german)
        qandAView.option(atIndex: correctAnswerPosition, setTo: entry.english)
        
        var alreadyChosenIds = [entry.id]
        
        for i in 0...3 {
            if i != correctAnswerPosition {
                let otherEntry = randomEntry(notIn: alreadyChosenIds)
                qandAView.option(atIndex: i, setTo: otherEntry.english)
                alreadyChosenIds.append(otherEntry.id)
            }
        }
        
        qandAView.setSkipNextButtonText(newText: "Skip")
        qandAView.successLabel.isHidden = true
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

