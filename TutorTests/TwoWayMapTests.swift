//
//  TwoWayMapTests.swift
//  Tutor
//
//  Created by Fuzzymeme on 01/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import XCTest
@testable import Tutor

class TwoWayMapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_StringToIntMap_ForSettingAndGettingForwardAndReverse() {
        let stringToIntMap = TwoWayMap<String, Int>(["A": 0, "B": 1, "C": 45])
        
        XCTAssertEqual(0, stringToIntMap.get("A"))
        XCTAssertEqual(1, stringToIntMap.get("B"))
        XCTAssertEqual(45, stringToIntMap.get("C"))
        
        XCTAssertEqual("A", stringToIntMap.getReverse(0))
        XCTAssertEqual("B", stringToIntMap.getReverse(1))
        XCTAssertEqual("C", stringToIntMap.getReverse(45))
    }
    
    func test_StringToIntMap_ForKeys() {
        let stringToIntMap = TwoWayMap<String, Int>(["A": 0, "B": 1, "C": 45])

        XCTAssertEqual(3, stringToIntMap.keys.count)
        XCTAssert(stringToIntMap.keys.contains("A"))
        XCTAssert(stringToIntMap.keys.contains("B"))
        XCTAssert(stringToIntMap.keys.contains("C"))
    }
    
    func test_StringToIntMap_ForValues() {
        let stringToIntMap = TwoWayMap<String, Int>(["A": 0, "B": 1, "C": 45])
        
        XCTAssertEqual(3, stringToIntMap.values.count)
        XCTAssert(stringToIntMap.values.contains(0))
        XCTAssert(stringToIntMap.values.contains(1))
        XCTAssert(stringToIntMap.values.contains(45))
    }
}
