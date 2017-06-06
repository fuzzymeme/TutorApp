//
//  AugmentedSpacedRepetitionStrategy.swift
//  Tutor
//
//  Created by Fuzzymeme on 04/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class AugmentedSpacedRepetitionStrategy {
    
    private var currentQuestionEntry: KnowledgeEntry?
    private var indexToEntryDict = [Int: KnowledgeEntry]()
    private var indexOfCorrectAnswer: Int?
    
    func qAndASet(from model: QandAViewModel) -> QandAGroup {
        
        var answers = [String]()
        var question = ""
        indexOfCorrectAnswer = Utils.randomInt(limit: 4)
        if var currentQuestionEntry = currentQuestionEntry, let indexOfCorrectAnswer = indexOfCorrectAnswer {
            currentQuestionEntry = model.randomEntry()
            question = Utils.completeTemplate(ResourceStrings.questionTemplate, replace: "$german", with: currentQuestionEntry.german)
            var alreadyChosenIds = [currentQuestionEntry.id]
            
            for i in 0...3 {
                if i != indexOfCorrectAnswer {
                    let otherEntry = model.randomEntry(notIn: alreadyChosenIds)
                    answers.append(otherEntry.english)
                    alreadyChosenIds.append(otherEntry.id)
                    indexToEntryDict[i] = otherEntry
                } else {
                    answers.append(currentQuestionEntry.english)
                    indexToEntryDict[i] = currentQuestionEntry
                }
            }
        }
            
            
        return QandAGroup(question: question, answers: answers,  indexOfCorrectAnswer: indexOfCorrectAnswer!)
    }
    
    func recordAnswerGiven(_ answerIndex: Int) {
        if answerIndex == indexOfCorrectAnswer! {
            currentQuestionEntry.
        }
    }
}
