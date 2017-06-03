//
//  JsonModelReader.swift
//  Tutor
//
//  Created by Fuzzymeme on 31/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

struct JsonModelReader {
    
    func retrieveFromJsonFile(filename: String) -> [Int: KnowledgeEntry] {
        
        let filePath = Bundle.main.resourcePath!
        var entries = [Int: KnowledgeEntry]()
        
        let data = try! String(contentsOfFile: filePath + "/" + filename, encoding: String.Encoding.utf8)
        
        if let entriesDict = convertToDictionary(text: data) {
            for(key, value) in entriesDict {
                if let newEntry = parseEntry(key: key, value: value) {
                    entries[newEntry.id] = newEntry
                }
            }
        }
        
        return entries
    }
    
    private func parseEntry(key: String, value: Any?) -> KnowledgeEntry? {
        
        var gapHistory = [Int]()
        var wrongAnswers = [WrongAnswer]()
        
        if let entry = value as? [String: Any] {
            if let nonEmpty = entry["gapHistory"] as? [Int] {
                gapHistory = nonEmpty
            }
            
            if let nonEmpty = entry["wrongAnswers"] as? [String : Any] {
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
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
