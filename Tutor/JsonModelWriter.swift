//
//  JsonModelWriter.swift
//  Tutor
//
//  Created by Fuzzymeme on 08/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class JsonModelWriter {
    
    func saveToJsonFile() {
        let file = "output.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            let personArray =  [["person": ["name": "Danny", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]
            
            do {
                let data = try JSONSerialization.data(withJSONObject: personArray, options: [])
                try data.write(to: path, options: [])
            } catch {
                print(error)
            }
        }
    }
}
