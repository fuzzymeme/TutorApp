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
    
    var optionOne: String {
        get { return optionOneButton.currentTitle ?? ""}
        set { optionOneButton.setTitle(newValue, for: .normal)}
    }

    var optionTwo: String {
        get { return optionTwoButton.currentTitle ?? ""}
        set { optionTwoButton.setTitle(newValue, for: .normal)}
    }

    var optionThree: String {
        get { return optionOneButton.currentTitle ?? ""}
        set { optionThreeButton.setTitle(newValue, for: .normal)}
    }

    var optionFour: String {
        get { return optionFourButton.currentTitle ?? ""}
        set { optionFourButton.setTitle(newValue, for: .normal)}
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    

}
