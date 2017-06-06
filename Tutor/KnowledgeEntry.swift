//
//  KnowledgeEntry.swift
//  Tutor
//
//  Created by Fuzzymeme on 26/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

struct KnowledgeEntry: CustomStringConvertible, Equatable {
    
    public let id: Int
    public let english: String
    public let german: String
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
    
    mutating func addWrongAnswer(_ newWrongAnswerEntry: KnowledgeEntry) {
        let newWrongAnswer = WrongAnswer(id: newWrongAnswerEntry.id, when: 0, count: 1024)  // TODO fill in the correct details
        wrongAnswers.append(newWrongAnswer)
    }
    
    public var description : String {
        let nextTimeString = (nextQuestionTime != nil) ? String(nextQuestionTime!) : "none"
        return "id: \(id), english: \(english), german: \(german), nextQuestionTime: \(nextTimeString), history: \(gapHistory), wrongAnswers: \(wrongAnswers)"
    }
    
    public static func ==(lhs: KnowledgeEntry, rhs: KnowledgeEntry) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.english == rhs.english &&
            lhs.german == rhs.german &&
            lhs.nextQuestionTime == rhs.nextQuestionTime &&
            lhs.gapHistory == rhs.gapHistory &&
            lhs.wrongAnswers == rhs.wrongAnswers
    }
}

struct WrongAnswer: CustomStringConvertible, Equatable {
    
    public let id: Int
    public let when: Int
    public let count: Int
    
    public var description : String {
        return "id: \(id), when: \(when), count: \(count)"
    }
    
    public static func ==(lhs: WrongAnswer, rhs: WrongAnswer) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.when == rhs.when &&
            lhs.count == rhs.count
    }
}
