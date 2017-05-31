//
//  QandAView.swift
//  Tutor
//
//  Created by Fuzzymeme on 28/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import UIKit

class QandAView: UIView {
    
    @IBOutlet weak var optionZeroButton: UIButton!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var optionThreeButton: UIButton!
    @IBOutlet weak var skipNextButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    lazy private var buttonToValueMap: [UIButton: Int] = self.initializeButtonMap()
    private var buttons = [UIButton]()
    private var viewListener: ViewController?
    
    @IBAction func optionButtonTouched(_ sender: UIButton) {
        viewListener?.handleButtonTouchedEvent(buttonIndex: buttonToValueMap[sender]!)
    }
    
    func initializeButtonMap() -> [UIButton: Int] {
        return [optionZeroButton: 0, optionOneButton: 1, optionTwoButton: 2, optionThreeButton: 3, ]
    }

    func setDelegate(_ viewListener: ViewController) {
        self.viewListener = viewListener
    }
    
    func option(_ optionNumber: Int, setTo newValue: String) {
        switch optionNumber {
        case 0: optionZero = newValue; break
        case 1: optionOne = newValue; break
        case 2: optionTwo = newValue; break
        case 3: optionThree = newValue; break
        default:break
        }
    }
    
    private var optionZero: String {
        get { return optionZeroButton.currentTitle ?? ""}
        set { optionZeroButton.setTitle(newValue, for: .normal)}
    }
    
    private var optionOne: String {
        get { return optionOneButton.currentTitle ?? ""}
        set { optionOneButton.setTitle(newValue, for: .normal)}
    }

    private var optionTwo: String {
        get { return optionTwoButton.currentTitle ?? ""}
        set { optionTwoButton.setTitle(newValue, for: .normal)}
    }

    private var optionThree: String {
        get { return optionThreeButton.currentTitle ?? ""}
        set { optionThreeButton.setTitle(newValue, for: .normal)}
    }

    var question: String {
        get { return questionLabel.text ?? ""}
        set { questionLabel.text = newValue}
    }
    
    var displaySuccess: String {
        get{ return ""}
        set {
            successLabel!.text = newValue
        }
    }
}

protocol QandAViewListener {
    func handleButtonTouchedEvent(buttonIndex: Int)
}
