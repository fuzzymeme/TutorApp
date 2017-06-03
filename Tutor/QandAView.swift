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
    
    lazy private var buttonToIndexMap: [UIButton: Int] = self.initializeButtonMap()
    private var buttons = [UIButton]()
    private var viewListener: ViewController?
    
    @IBAction func optionButtonTouched(_ sender: UIButton) {
        viewListener?.handleButtonTouchedEvent(buttonIndex: buttonToIndexMap[sender]!)
    }
    
    @IBAction func skipNextButtonTouched(_ sender: UIButton) {
        viewListener?.handleSkipButtonTouchedEvent()
    }
    
    func initializeButtonMap() -> [UIButton: Int] {
        return [optionZeroButton: 0, optionOneButton: 1, optionTwoButton: 2, optionThreeButton: 3]
    }

    func setDelegate(_ viewListener: ViewController) {
        self.viewListener = viewListener
    }
    
    func setBackground(color newBackgroundColor: UIColor) {
        self.backgroundColor = newBackgroundColor
    }
    
    func setButtonsBackground(color newBackgroundColor: UIColor) {
        for button in buttonToIndexMap.keys {
            button.backgroundColor = newBackgroundColor
        }
    }
    
    func setSkipNextButtonBackground(color newBackgroundColor: UIColor) {
        skipNextButton.backgroundColor = newBackgroundColor
    }
    
    func setSkipNextButtonText(newText: String) {
        skipNextButton.setTitle(newText, for: .normal)
    }
    
    func option(atIndex optionNumber: Int, setTo newValue: String) {
        let selectedButton = buttonWithIndex(optionNumber)
        selectedButton?.setTitle(newValue, for: .normal)
    }

    var question: String {
        get { return questionLabel.text ?? ""}
        set { questionLabel.text = newValue}
    }
    
    var displaySuccess: Bool {
        get{ return false}
        set {
            if newValue {
                successLabel!.text = "Correct"
                successLabel!.backgroundColor = UIColor.green
            } else {
                successLabel!.text = "Wrong"
                successLabel!.backgroundColor = UIColor.red
            }
        }
    }
    
    private func buttonWithIndex(_ index: Int) -> UIButton? {
        return buttonToIndexMap.keys.first(where: {[weak self] in self?.buttonToIndexMap[$0] == index})
    }
}

protocol QandAViewListener {
    func handleButtonTouchedEvent(buttonIndex: Int)
}
