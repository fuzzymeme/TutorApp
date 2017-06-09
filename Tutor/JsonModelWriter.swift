//
//  JsonModelWriter.swift
//  Tutor
//
//  Created by Fuzzymeme on 08/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class JsonModelWriter {
    
    func saveToJsonFile(_ model: QandAViewModel) {
        let file = "output.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            let jsonable =  modelAsJsonable(model)
            print("jsonable: \(jsonable)")

            do {
                let data = try JSONSerialization.data(withJSONObject: jsonable, options: .prettyPrinted)
                try data.write(to: path, options: [])
            } catch {
                print(error)
            }
        }
    }
    
    private func modelAsJsonable(_ model: QandAViewModel) -> [String: [String: String]] {
        
        var json = [String: [String: String]]()
        for i in 0..<model.count() {
            let entry = model.entryAt(index: i)
            let entryIdString = String(entry.id)
            json[entryIdString] = entryAsJsonable(entry)
        }
        
        return json
    }
    
    private func entryAsJsonable(_ entry: KnowledgeEntry) -> [String: String] {
        
        var json = [String: String]()
        json["id"] = String(entry.id)
        json["english"] = entry.english
        
        return json
    }
}
