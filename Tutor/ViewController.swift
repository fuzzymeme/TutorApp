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
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func nextButton(_ sender: UIButton) {
        print("Next Button pressed")
        moveToNextQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        questionLabel.text = model.question()
        
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
    
    private func moveToNextQuestion() {
        
    }


}

