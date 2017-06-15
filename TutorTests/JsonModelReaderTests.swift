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
        let actual = reader.retrieveFromJsonFile(filename: "test.json", forceFromBundle: true)
        
        let expected = Helper.sampleKnowledgeEntries()
        
        XCTAssertEqual(expected[0], actual[0])
        XCTAssertEqual(expected[1], actual[1])
        XCTAssertEqual(expected[2], actual[2])
        XCTAssertEqual(expected[3], actual[3])
        XCTAssertEqual(expected[4], actual[4])
        
        XCTAssert(expected == actual)
    }
    
}
