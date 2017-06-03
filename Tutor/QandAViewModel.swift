//
//  QandAViewModel.swift
//  Tutor
//
//  Created by Fuzzymeme on 23/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class QandAViewModel {
    
    private var entries = [Int: KnowledgeEntry]()
    private var indexOfCorrectAnswer: Int? 
    
    func loadModel() {        
        let modelReader = JsonModelReader()
        entries = modelReader.retrieveFromJsonFile(filename: "test.json")
    }
    
    func addEntry(_ newEntry: KnowledgeEntry) {
        entries[newEntry.id] = newEntry
    }
    
    func entry(_ index: Int) -> KnowledgeEntry {
        return entries[Array(entries.keys)[index]]!
    }
    
    func count() -> Int {
        return entries.count
    }
    
    func setIndexOfCorrectAnswer(newValue: Int) {
        indexOfCorrectAnswer = newValue
    }
    
    func isCorrect(_ givenIndex : Int) -> Bool  {
        return indexOfCorrectAnswer == givenIndex
    }
}
