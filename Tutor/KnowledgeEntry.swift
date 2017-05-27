//
//  KnowledgeEntry.swift
//  Tutor
//
//  Created by Fuzzymeme on 26/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class KnowledgeEntry: CustomStringConvertible {
    
    public let id: Int
    public let english: String
    private let german: String
    private var nextQuestionTime: Int?
    private var gapHistory: [Int]
    private var wrongAnswers: [WrongAnswer]
    
    init(id: Int, english: String, german: String, nextQuestionTime: Int?, gapHistory: [Int], wrongAnswers: [WrongAnswer]) {
        self.id = id
        self.english = english
        self.german = german
        self.nextQuestionTime = nextQuestionTime
        self.gapHistory = gapHistory
        self.wrongAnswers = wrongAnswers
    }
    
    public var description : String {        
        let nextTimeString = (nextQuestionTime != nil) ? String(nextQuestionTime!) : "none"
        return "id: \(id), english: \(english), german: \(german), nextQuestionTime: \(nextTimeString), history: \(gapHistory), wrongAnswers: \(wrongAnswers)"
    }
}

struct WrongAnswer: CustomStringConvertible {
    
    public let id: Int
    public let when: Int
    public let count: Int
    
    public var description : String {
        return "id: \(id), when: \(when), count: \(count)"
    }
}
