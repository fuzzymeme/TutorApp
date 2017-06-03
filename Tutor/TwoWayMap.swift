//
//  TwoWayMap.swift
//  Tutor
//
//  Created by Fuzzymeme on 01/06/2017.
//  Copyright © 2017 Fuzzymeme. All rights reserved.
//

import Foundation

class TwoWayMap<T: Hashable , U: Hashable> {
  
    private var oneWay = [T: U]()
    private var otherWay = [U: T]()
    public var keys: LazyMapCollection<Dictionary<T, U>, T> {
        return oneWay.keys
    }
    
    public var values: LazyMapCollection<Dictionary<T, U>, U> {
        return oneWay.values
    }
    
    init(_ initialValues: [T:U]) {
        addAll(newValues: initialValues)
    }
    
    public func addAll(newValues: [T: U]) {
        addAllOneWay(newValues: newValues)
        addAllOtherWay(newValues: newValues)
    }
    
    public func get(_ keyOne: T) -> U? {
        return oneWay[keyOne]
    }
    
    public func getReverse(_ keyOther: U) -> T? {
        return otherWay[keyOther]
    }
    
    private func addAllOneWay(newValues: [T: U]) {
        newValues.forEach { (k,v) in oneWay[k] = v }
    }
    
    private func addAllOtherWay(newValues: [T: U]) {
        newValues.forEach { (k,v) in otherWay[v] = k }
    }
}
