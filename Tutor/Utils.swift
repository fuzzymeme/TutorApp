//
//  File.swift
//  Tutor
//
//  Created by Fuzzymeme on 02/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class Utils {
    
    static func completeTemplate(_ template: String, replace target: String, with newString: String) -> String {
        return template.replace(target, with: newString)
    }
    
    static func randomInt(limit: Int) -> Int {
        return Int(arc4random_uniform(UInt32(limit)))
    }
    
    static func getCurrentMillis()-> Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
    static func dateString(from milliSeconds: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(milliSeconds / 1000))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date)
        
        return dateString
    }
    
    static func convertToIntArray(_ text: String) -> [Int]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [Int]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
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

extension String {
    func replace(_ target: String, with withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
}
