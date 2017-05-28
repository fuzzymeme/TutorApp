//
//  QandAViewModel.swift
//  Tutor
//
//  Created by Fuzzymeme on 23/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class QandAViewModel {
    
    private let qnaGroup = QandAGroup()
    private var givenAnswer: String?
    private var entries = [KnowledgeEntry]()
    
    func loadModel() {
        
        retrieveFromJsonFile()
    }
    
    func retrieveFromJsonFile() {
        
        let filePath = Bundle.main.resourcePath!
        
//        let data = try! String(contentsOfFile: filePath + "/basic_vocabulary_en2de.json", encoding: String.Encoding.utf8)
        let data = try! String(contentsOfFile: filePath + "/foo.json", encoding: String.Encoding.utf8)
        
        if let entriesDict = convertToDictionary(text: data) {
            for(key, value) in entriesDict {
                if let newEntry = parseEntry(key: key, value: value) {
                    entries.append(newEntry)
                }
            }
        }

        for entry in entries {
            print(entry)
        }
    }
    
    private func parseEntry(key: String, value: Any?) -> KnowledgeEntry? {
        
        var gapHistory = [Int]()
        var wrongAnswers = [WrongAnswer]()

        if let entry = value as? [String: Any] {
            if entry["gapHistory"] != nil,
                let nonEmpty = entry["gapHistory"] as? [Int] {
                gapHistory = nonEmpty
            }
            
            if entry["wrongAnswers"] != nil,
                let nonEmpty = entry["wrongAnswers"] as? [String : Any] {
                wrongAnswers.append(contentsOf: parseWrongAnswers(wrongAnswerInput: nonEmpty))
            }
            
            if let id = Int(key),
                let english = entry["english"] as? String,
                let german = entry["german"] as? String,
                let nextTime = entry["nextQuestionTime"] as? Int {
                let entry = KnowledgeEntry(id: id, english: english, german: german, nextQuestionTime: nextTime, gapHistory: gapHistory, wrongAnswers: wrongAnswers)
                return entry
            } else {
                return nil
            }
        }
        return nil
    }
    
    private func parseWrongAnswers(wrongAnswerInput: [String: Any?]) -> [WrongAnswer] {
        var wrongAnswers = [WrongAnswer]()

        for wrongAnswerValue in wrongAnswerInput.values {
            if let wrongAnswerDict = wrongAnswerValue as? [String : Int],
                let wrongAnswer = parseWrongAnswer(wrongAnswerDict) {
                wrongAnswers.append(wrongAnswer)
            }
        }
        return wrongAnswers
    }

    private func parseWrongAnswer(_ wrongAnswerInput: [String : Int]) -> WrongAnswer? {
        if let id = wrongAnswerInput["id"],
            let when = wrongAnswerInput["when"],
            let count = wrongAnswerInput["count"] {
            return WrongAnswer(id: id, when: when, count: count)
        }
        return nil
    }

    func convertToArray(text: String) -> [[String : Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func entry(_ index: Int) -> KnowledgeEntry {
        return entries[index]
    }
    
    func question() -> String {
        return qnaGroup.question
    }
    
    func answer(index : Int!) -> String {
        return qnaGroup.answers[index]
    }
    
    func answerGiven(answer : String) {
        givenAnswer = answer
    }
    
    func isCorrect(_ givenAnswer : String) -> Bool  {
        return qnaGroup.answers[qnaGroup.indexOfCorrectAnswer] == givenAnswer
    }
}
