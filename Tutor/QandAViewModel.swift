//
//  QandAViewModel.swift
//  Tutor
//
//  Created by Fuzzymeme on 23/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class QandAViewModel {
    
    private let qnaGroup = QandAGroup()
    private var givenAnswer : String?
    
    func question() -> String {
            return qnaGroup.question
    }
    
    func answer(index : Int!) -> String {
        return qnaGroup.answers[index]
    }
    
    func answerGiven(answer : String) {
        givenAnswer = answer
    }
    
    func isCorrect(_ givenAnswer : String) -> Bool  {
        return qnaGroup.answers[qnaGroup.indexOfCorrectAnswer] == givenAnswer
    }
}
