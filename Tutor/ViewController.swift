//
//  ViewController.swift
//  Tutor
//
//  Created by Fuzzymeme on 23/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var buttonToValueMap = [String : String]()
    private var buttons = [UIButton]()
    
    private let model = QandAViewModel()
    
    @IBOutlet weak var optionButtonOne: UIButton!
    @IBOutlet weak var optionButtonTwo: UIButton!
    @IBOutlet weak var optionButtonThree: UIButton!
    @IBOutlet weak var optionButtonFour: UIButton!
    @IBOutlet weak var successLabel: UILabel!
    
    @IBAction func nextButton(_ sender: UIButton) {
        print("Next Button pressed")
        moveToNextQuestion()
    }
    
    @IBOutlet weak var qandAView: QandAView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        buttons.append(contentsOf:
            [optionButtonOne, optionButtonTwo, optionButtonThree, optionButtonFour]);

        var i = 0
        for button in buttons {
            buttonToValueMap[button.restorationIdentifier!] = model.answer(index: i)
            i += 1
        }
        
        for button in buttons {
            button.setTitle(buttonToValueMap[button.restorationIdentifier!], for: UIControlState.normal)
        }
        
        model.loadModel()
        
        setAnswers()
    }
    
    var displaySuccess: String {
        get{ return ""}
        set {
            successLabel!.text = newValue
        }
    }

    @IBAction func optionButtonTouched(_ sender: UIButton) {
        if let buttonId = sender.restorationIdentifier, let givenAnswer = buttonToValueMap[buttonId] {
            if model.isCorrect(givenAnswer) {
                displaySuccess = "Correct"
            } else {
                displaySuccess = "Wrong"
            }
        }
    }
    
    // MARK: - Logic
    private func setAnswers() {
        let entry = model.entry(0)
        qandAView.question = "What is \"\(entry.german)\" in English?"
        qandAView.option(1, setTo: entry.english)
        
        for i in 2...4 {
            let otherEntry = model.entry(i)
            qandAView.option(i, setTo: otherEntry.english)
        }
    }
    
    private func moveToNextQuestion() {
        
    }


}

