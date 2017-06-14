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
        print("indexOfCorrectAnswer \(indexOfCorrectAnswer!)")
        
        if let chosenEntry = getEntryDueToBeAskedNext(from: model) {
            print("Oldest \"Next Time\": \(Utils.dateString(from: chosenEntry.getNextQuestionTime()!))")
        }
        
        currentQuestionEntry = model.randomEntry()
        if let currentQuestionEntry = currentQuestionEntry,
            let correctIndex = indexOfCorrectAnswer {
            question = Utils.completeTemplate(ResourceStrings.questionTemplate, replace: "$german", with: currentQuestionEntry.german)
            var alreadyChosenIds = [currentQuestionEntry.id]
            
            for i in 0...3 {
                if i != correctIndex {
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
        if let indexOfCorrectAnswer = indexOfCorrectAnswer {
            if answerIndex != indexOfCorrectAnswer,
                let currentQuestionEntry = currentQuestionEntry {
                currentQuestionEntry.addWrongAnswer(indexToEntryDict[answerIndex]!)
                if let nextQuestionTime = getNextTime(withScale: 0.1, onEntry: currentQuestionEntry) {
                    print("Wrong - Next Question Time: \(Utils.dateString(from: nextQuestionTime))")
                    currentQuestionEntry.setNextQuestionTime(nextQuestionTime)
                }
            } else {
                if let currentQuestionEntry = currentQuestionEntry {
                    if let nextQuestionTime = getNextTime(withScale: 2.0, onEntry: currentQuestionEntry) {
                        print("Right - Next Question Time: \(Utils.dateString(from: nextQuestionTime))")
                        currentQuestionEntry.setNextQuestionTime(nextQuestionTime)
                    }
                }
            }
        }
    }
    
    private func getNextTime(withScale scale: Double, onEntry entry: KnowledgeEntry) -> Int? {
        if let lastGap = getLastGap(ofEntry: entry) {
            print("last gap: \(lastGap)")
            let nextGap = Double(lastGap) * scale
            let nextQuestionTime = Double(Utils.getCurrentMillis()) + nextGap
            return Int(nextQuestionTime)
        }
        return nil
    }
    
    private func getLastGap(ofEntry entry: KnowledgeEntry) -> Int? {
        let gapHistory = entry.getGapHistory()
        
        guard gapHistory.count >= 2 else {
            return nil
        }
        
        let penultimate = gapHistory[gapHistory.count - 2]
        let ultimate = gapHistory[gapHistory.count - 1]
        return (ultimate - penultimate)
    }
    
    func getEntryDueToBeAskedNext(from model: QandAViewModel) -> KnowledgeEntry? {
        
        var earliestNextTime: Int = Int.max
        var chosenEntry: KnowledgeEntry?
        
        for index in 0..<model.count() {
            let entry = model.entryAt(index: index)
            if let entryNextTime = entry.getNextQuestionTime() {
                if entryNextTime < earliestNextTime {
                    earliestNextTime = entryNextTime
                    chosenEntry = entry
                }
            }
        }
        return chosenEntry
    }
    
}
