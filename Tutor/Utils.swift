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
}

extension String {
    func replace(_ target: String, with withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
}
