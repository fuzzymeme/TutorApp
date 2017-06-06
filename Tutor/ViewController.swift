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
        model.recordAnswerGiven(answerIndex: buttonIndex)
    }
    
    func handleSkipButtonTouchedEvent() {
        setAnswers()
    }
    
    // MARK: - Logic
    private func setAnswers() {
        
        if let qAndASet = model.qAndASet() {        
            qandAView.question = qAndASet.question
            qandAView.setAnswers(qAndASet.answers)
        } else {
            /// TODO Clear question and answers and display an error message. 
        }
            
        qandAView.setSkipNextButtonText(newText: "Skip")
        qandAView.successLabel.isHidden = true
    }
}

