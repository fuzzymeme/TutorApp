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
        let knowledgeEntry0 = KnowledgeEntry(id: 0, english: "autumn", german: "der Herbst", nextQuestionTime: 1358263205338, gapHistory: [797679086,
                                                                                                                                           2437408407,
                                                                                                                                           7148207265,
                                                                                                                                           31536000000], wrongAnswers: [])
        let knowledgeEntry1 = KnowledgeEntry(id: 1, english: "century", german: "das Jahrhundert", nextQuestionTime: 1358263105338, gapHistory: [799955507,
                                                                                                                                                 2433796674,
                                                                                                                                                 7395328413,
                                                                                                                                                 31536000000], wrongAnswers: [])
        let knowledgeEntry2 = KnowledgeEntry(id: 2, english: "day", german: "der Tag", nextQuestionTime: 1358263205338, gapHistory: [799953164,
                                                                                                                                     2433796797,
                                                                                                                                     7395332397,
                                                                                                                                     31536000000],
                                             wrongAnswers: Helper.sampleWrongAnswer())
        let knowledgeEntry3 = KnowledgeEntry(id: 3, english: "east", german: "der Osten, ostlich", nextQuestionTime: 1358263205338, gapHistory: [799965224,
                                                                                                                                                 2433782877,
                                                                                                                                                 7395298851,
                                                                                                                                                 31536000000], wrongAnswers: [])
        let knowledgeEntry4 = KnowledgeEntry(id: 4, english: "hour", german: "die Stunde", nextQuestionTime: 1358263205338, gapHistory: [799965347,
                                                                                                                                         2433787224,
                                                                                                                                         7395303315,
                                                                                                                                         31536000000], wrongAnswers: [])
        let knowledgeEntry10 = KnowledgeEntry(id: 10, english: "minute", german: "die Minute", nextQuestionTime: 1358263205338, gapHistory: [800133856,
                                                                                                                                             2433469269,
                                                                                                                                             7394493282,
                                                                                                                                             31536000000], wrongAnswers: [])
        
        return [0: knowledgeEntry0, 1: knowledgeEntry1, 2: knowledgeEntry2, 3: knowledgeEntry3, 4: knowledgeEntry4, 10: knowledgeEntry10]
    }
    
    static private func sampleWrongAnswer() -> [WrongAnswer] {
        return [WrongAnswer(id: 194, when: 1326716015112, count: 1)]
    }
}

