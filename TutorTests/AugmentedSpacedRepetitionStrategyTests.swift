//
//  AugmentedSpacedRepetitionStrategyTests.swift
//  Tutor
//
//  Created by Richard Smith on 14/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import XCTest
@testable import Tutor

class AugmentedSpacedRepetitionStrategyTests: XCTestCase {

    var model = QandAViewModel()
    var strategy = AugmentedSpacedRepetitionStrategy()
    
    override func setUp() {
        super.setUp()
        
        strategy = AugmentedSpacedRepetitionStrategy()
        model = QandAViewModel()
        for entry in Helper.sampleKnowledgeEntries().values {
            model.addEntry(entry)
        }
    }
    
    func test_WhenAskedForNextQuestionSet_ThenChosesOneWithOldestNextQuestionTime() {
        let qAndASet = strategy.qAndASet(from: model)
        XCTAssertEqual("das Jahrhundert", qAndASet.question)
    }

    func test_WhenCorrectAnswerGiven_ThenWrongAnswersListRemainsTheSame() {
        let qAndASet = strategy.qAndASet(from: model)
        let correctEntry = strategy.getEntryFor(index: qAndASet.indexOfCorrectAnswer)
        
        XCTAssertEqual(0, correctEntry.getWrongAnswers().count)
        
        strategy.recordAnswerGiven(qAndASet.indexOfCorrectAnswer)
        
        XCTAssertEqual(0, correctEntry.getWrongAnswers().count)
    }

    func test_WhenWrongAnswerGiven_ThenWrongAnswersListIncreasesForThatEntry() {
        let qAndASet = strategy.qAndASet(from: model)
        let wrongIndex = getWrongIndex(correctIndex: qAndASet.indexOfCorrectAnswer)
        let correctEntry = strategy.getEntryFor(index: qAndASet.indexOfCorrectAnswer)
        
        XCTAssertEqual(0, correctEntry.getWrongAnswers().count)
        
        strategy.recordAnswerGiven(wrongIndex)
        
        XCTAssertEqual(1, correctEntry.getWrongAnswers().count)
    }
        
    // MARK: - Helper funcs
    private func getWrongIndex(correctIndex: Int) -> Int {
        return (correctIndex + 1) % 4
    }

}
