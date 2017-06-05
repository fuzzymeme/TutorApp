//
//  AugmentedSpacedRepetitionStrategy.swift
//  Tutor
//
//  Created by Fuzzymeme on 04/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class AugmentedSpacedRepetitionStrategy {
    
    
    func qAndASet(from model: QandAViewModel) -> QandAGroup {
        
        let correctEntry = model.randomEntry()
        let indexOfCorrectAnswer = Utils.randomInt(limit: 4)
        let question = Utils.completeTemplate(ResourceStrings.questionTemplate, replace: "$german", with: correctEntry.german)
        var answers = [String]()
        var alreadyChosenIds = [correctEntry.id]
        
        for i in 0...3 {
            if i != indexOfCorrectAnswer {
                let otherEntry = model.randomEntry(notIn: alreadyChosenIds)
                answers.append(otherEntry.english)
                alreadyChosenIds.append(otherEntry.id)
            } else {
                answers.append(correctEntry.english)
            }
        }
        
        return QandAGroup(question: question, answers: answers,  indexOfCorrectAnswer: indexOfCorrectAnswer)
    }
}
