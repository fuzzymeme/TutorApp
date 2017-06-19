//
//  KnowledgeEntry.swift
//  Tutor
//
//  Created by Fuzzymeme on 26/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class KnowledgeEntry: CustomStringConvertible, Equatable {
    
    public let id: Int
    public let english: String
    public let german: String
    private var nextQuestionTime: Int?
//    private var gapHistory: [Int]
    private var history:[HistoryItem]
    private var wrongAnswers: [WrongAnswer]
    
    init(id: Int, english: String, german: String, nextQuestionTime: Int?, wrongAnswers: [WrongAnswer], history: [HistoryItem] = [HistoryItem]()) {
        self.id = id
        self.english = english
        self.german = german
        self.nextQuestionTime = nextQuestionTime
//        self.gapHistory = gapHistory
        self.wrongAnswers = wrongAnswers
        self.history = history
    }
    
    func recordHistory(_ answerType: HistoryItem.AnswerType) {
        history.append(HistoryItem(correctness: answerType, time: Utils.getCurrentMillis()))
    }
    
    func addWrongAnswer(_ newWrongAnswerEntry: KnowledgeEntry) {
        if hasHadWrongAnswerBefore(givenAnswer: newWrongAnswerEntry) {
            print("Had that wrong answer before")
            if let previousWrongAnswer = wrongAnswers.filter({$0.id == newWrongAnswerEntry.id}).first {
                print("Found \(previousWrongAnswer)")
                let newWrongAnswer = WrongAnswer(id: newWrongAnswerEntry.id, when: Utils.getCurrentMillis(), count: previousWrongAnswer.count + 1)
                removeWrongAnswer(previousWrongAnswer)
                wrongAnswers.append(newWrongAnswer)
            }
        } else {
            print("New wrong answer")
            let newWrongAnswer = WrongAnswer(id: newWrongAnswerEntry.id, when: Utils.getCurrentMillis(), count: 1)
            wrongAnswers.append(newWrongAnswer)
        }
    }
    
    public func hasHadWrongAnswerBefore(givenAnswer: KnowledgeEntry) -> Bool {
        for previousWrongAnswer in wrongAnswers {
            if previousWrongAnswer.id == givenAnswer.id {
                return true
            }
        }
        return false
    }
    
    public func removeWrongAnswer(_ wrongAnswer: WrongAnswer) {
        if let index = wrongAnswers.index(of: wrongAnswer) {
            wrongAnswers.remove(at: index)
        }
    }
    
    public func getNextQuestionTime() -> Int? {
        return nextQuestionTime
    }
    
    public func setNextQuestionTime(_ nextTime: Int) {
        nextQuestionTime = nextTime
    }
    
    public func getHistory() -> [HistoryItem] {
        return history
    }
    
    public func getWrongAnswers() -> [WrongAnswer] {
        return wrongAnswers
    }
    
    public var description : String {
        let nextTimeString = (nextQuestionTime != nil) ? String(nextQuestionTime!) : "none"
        return "id: \(id), english: \(english), german: \(german), nextQuestionTime: \(nextTimeString), history: \(history), wrongAnswers: \(wrongAnswers)"
    }
    
    public static func ==(lhs: KnowledgeEntry, rhs: KnowledgeEntry) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.english == rhs.english &&
            lhs.german == rhs.german &&
            lhs.nextQuestionTime == rhs.nextQuestionTime &&
            lhs.wrongAnswers == rhs.wrongAnswers &&
            lhs.history == rhs.history
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

struct HistoryItem: Equatable {
    
    enum AnswerType {
        case Correct
        case Wrong
    }
    
    public let correctness: AnswerType
    public let time: Int
    
    public var description : String {
        return "Correctness: \(correctness), Time: \(time)"
    }
    
    public static func ==(lhs: HistoryItem, rhs: HistoryItem) -> Bool {
        return
            lhs.correctness == rhs.correctness &&
            lhs.time == rhs.time
    }
    
}
