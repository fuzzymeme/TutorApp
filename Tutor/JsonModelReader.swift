//
//  JsonModelReader.swift
//  Tutor
//
//  Created by Fuzzymeme on 31/05/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

struct JsonModelReader {
    
    func retrieveFromJsonFile(filename: String, forceFromBundle: Bool = false) -> [Int: KnowledgeEntry] {
        
        var entries = [Int: KnowledgeEntry]()
        
        let data = dataFromSavedFileOrBundleFile(filename, forceFromBundle: forceFromBundle)
        
        if let entriesDict = convertToDictionary(text: data) {
            for(key, value) in entriesDict {
                if let newEntry = parseEntry(key: key, value: value) {
                    entries[newEntry.id] = newEntry
                }
            }
        }
        
        return entries
    }
    
    private func dataFromSavedFileOrBundleFile(_ filename: String, forceFromBundle: Bool = false) -> String {
        
        var data: String
        
        let savedFilePath = pathForSavedFile()
        let bundleFilePath = Bundle.main.resourcePath! + "/" + filename
        
        if forceFromBundle || !FileManager.default.fileExists(atPath: savedFilePath) {
            data = try! String(contentsOfFile: bundleFilePath, encoding: String.Encoding.utf8)
        } else {
            data = try! String(contentsOfFile: savedFilePath, encoding: String.Encoding.utf8)
        }
        
        return data
    }
    
    private func pathForSavedFile() -> String {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return dir!.appendingPathComponent("output.json").path
    }
    
    private func parseEntry(key: String, value: Any?) -> KnowledgeEntry? {
        
        var gapHistory = [Int]()
        var wrongAnswers = [WrongAnswer]()
        
        if let entry = value as? [String: Any] {
            if let nonEmpty = entry["gapHistory"] as? [Int] {
                gapHistory = nonEmpty
            }
            
            if let nonEmpty = entry["wrongAnswers"] as? [Any] {
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
    
    private func parseWrongAnswers(wrongAnswerInput: [Any?]) -> [WrongAnswer] {
        var wrongAnswers = [WrongAnswer]()
        
        for wrongAnswerValue in wrongAnswerInput {
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
