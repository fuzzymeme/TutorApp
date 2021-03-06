//
//  Helper.swift
//  Tutor
//
//  Created by Richard Smith on 15/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation
@testable import Tutor

struct Helper {
    
    static func sampleKnowledgeEntries() -> [Int: KnowledgeEntry] {
        let knowledgeEntry0 = KnowledgeEntry(id: 0, english: "autumn", german: "der Herbst", nextQuestionTime: 1358263205338, wrongAnswers: [])
        let knowledgeEntry1 = KnowledgeEntry(id: 1, english: "century", german: "das Jahrhundert", nextQuestionTime: 1358263105338, wrongAnswers: [], history: Helper.sampleHistory())
        let knowledgeEntry2 = KnowledgeEntry(id: 2, english: "day", german: "der Tag", nextQuestionTime: 1358263205338, wrongAnswers: Helper.sampleWrongAnswer())
        let knowledgeEntry3 = KnowledgeEntry(id: 3, english: "east", german: "der Osten, ostlich", nextQuestionTime: 1358263205338, wrongAnswers: [])
        let knowledgeEntry4 = KnowledgeEntry(id: 4, english: "hour", german: "die Stunde", nextQuestionTime: 1358263205338, wrongAnswers: [])
        let knowledgeEntry10 = KnowledgeEntry(id: 10, english: "minute", german: "die Minute", nextQuestionTime: 1358263205338, wrongAnswers: [])
        
        return [0: knowledgeEntry0, 1: knowledgeEntry1, 2: knowledgeEntry2, 3: knowledgeEntry3, 4: knowledgeEntry4, 10: knowledgeEntry10]
    }
    
    static private func sampleWrongAnswer() -> [WrongAnswer] {
        return [WrongAnswer(id: 194, when: 1326716015112, count: 1)]
    }
    
    static private func sampleHistory() -> [HistoryItem] {
        
        let historyItem1 = HistoryItem(correctness: .Wrong, time: 1358261105338)
        let historyItem2 = HistoryItem(correctness: .Correct, time: 1358262105338)
        let historyItem3 = HistoryItem(correctness: .Wrong, time: 1358263105338)
        
        return [historyItem1, historyItem2, historyItem3]
    }
}

