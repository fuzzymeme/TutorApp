//
//  JsonModelReaderTests.swift
//  Tutor
//
//  Created by Fuzzymeme on 31/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import XCTest
@testable import Tutor

class JsonModelReaderTests: XCTestCase {
    
    private var reader = JsonModelReader()
    
    override func setUp() {
        super.setUp()
        reader = JsonModelReader()
    }
    
    func test_retrieveFromJsonFile_withSimpleFormatNoGapHistoryOrWrongsAnswers() {
        let actual = reader.retrieveFromJsonFile(filename: "test.json")
        XCTAssert(sampleKnowledgeEntries() == actual)
    }

    // MARK: - Helpers
    private func sampleKnowledgeEntries() -> [Int: KnowledgeEntry] {
        let knowledgeEntry0 = KnowledgeEntry(id: 0, english: "autumn", german: "der Herbst", nextQuestionTime: 1358263105338, gapHistory: [899955507, 8433796674], wrongAnswers: [])
        let knowledgeEntry1 = KnowledgeEntry(id: 1, english: "century", german: "das Jahrhundert", nextQuestionTime: 1358263108626, gapHistory: [799955507, 2433796674], wrongAnswers: [])
        let knowledgeEntry2 = KnowledgeEntry(id: 59, english: "because", german: "weil", nextQuestionTime: 1326716025112, gapHistory: [800214164, 2433419412], wrongAnswers: JsonModelReaderTests.sampleWrongAnswer())
        let knowledgeEntry3 = KnowledgeEntry(id: 60, english: "besides", german: "außerdem", nextQuestionTime: 1326715979544, gapHistory: [800215993, 2433415671], wrongAnswers: [])
        let knowledgeEntry4 = KnowledgeEntry(id: 61, english: "but", german: "aber, sondern", nextQuestionTime: 1358251974096, gapHistory: [800215916, 2433415455], wrongAnswers: [])
        
        return [0: knowledgeEntry0, 1: knowledgeEntry1, 59: knowledgeEntry2, 60: knowledgeEntry3, 61: knowledgeEntry4]
    }
    
    static private func sampleWrongAnswer() -> [WrongAnswer] {
        return [WrongAnswer(id: 194, when: 1326716015112, count: 1)]
    }
    
    private func sampleWrongAnswerString() -> String {
        return "{\n" +
        "\"59\": {\n" +
            "\"id\": 194,\n" +
            "\"when\": 1326716015112,\n" +
            "\"count\": 1\n" +
        "}"
    }
}
