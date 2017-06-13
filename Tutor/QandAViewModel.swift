//
//  QandAViewModel.swift
//  Tutor
//
//  Created by Fuzzymeme on 23/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class QandAViewModel {
    
    private var strategy = AugmentedSpacedRepetitionStrategy()
    private var entries = [Int: KnowledgeEntry]()
    private var currentQAndA: QandAGroup?
    private let filename = "test.json"
//    private let filename = "basic_vocabulary_en2de.json"
    
    func loadModel() {        
        let modelReader = JsonModelReader()
        entries = modelReader.retrieveFromJsonFile(filename: filename)
    }
    
    func qAndASet() -> QandAGroup? {
        currentQAndA = strategy.qAndASet(from: self)
        return currentQAndA
    }
        
    func randomEntry(notIn alreadyChosenIds: [Int]) -> KnowledgeEntry {
        var randomEntry = entryAt(index: Utils.randomInt(limit: count()))
        while(alreadyChosenIds.contains(randomEntry.id)) {
            randomEntry = entryAt(index: Utils.randomInt(limit:count()))
        }
        return randomEntry
    }
    
    func randomEntry() -> KnowledgeEntry {
        return entryAt(index: Utils.randomInt(limit: count()))
    }
    
    func addEntry(_ newEntry: KnowledgeEntry) {
        entries[newEntry.id] = newEntry
    }
    
    func entryAt(index: Int) -> KnowledgeEntry {
        return entries[Array(entries.keys)[index]]!
    }
    
    func count() -> Int {
        return entries.count
    }
    
    func isCorrect(_ givenIndex : Int) -> Bool  {
        return currentQAndA?.indexOfCorrectAnswer == givenIndex
    }
    
    func recordAnswerGiven(answerIndex: Int) {
        strategy.recordAnswerGiven(answerIndex)
    }
}
