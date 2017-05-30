//
//  QandAView.swift
//  Tutor
//
//  Created by Fuzzymeme on 28/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import UIKit

class QandAView: UIView {
    
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var optionThreeButton: UIButton!
    @IBOutlet weak var optionFourButton: UIButton!
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
        return [optionOneButton: 1, optionTwoButton: 2, optionThreeButton: 3, optionFourButton: 4]
    }

    func setDelegate(_ viewListener: ViewController) {
        self.viewListener = viewListener
    }
    
    func option(_ optionNumber: Int, setTo newValue: String) {
        switch optionNumber {
        case 1: optionOne = newValue; break
        case 2: optionTwo = newValue; break
        case 3: optionThree = newValue; break
        case 4: optionFour = newValue; break
        default:break
        }
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

    private var optionFour: String {
        get { return optionFourButton.currentTitle ?? ""}
        set { optionFourButton.setTitle(newValue, for: .normal)}
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
