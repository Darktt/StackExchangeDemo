//
//  RawReferenceConvertible.swift
//
//  Created by Eden on 2021/8/25.
//  Copyright © 2021 Darktt. All rights reserved.
//

import Foundation

protocol RawReferenceConvertible: RawRepresentable, ReferenceConvertible where RawValue == Int, ReferenceType == NSNumber, _ObjectiveCType == NSNumber
{
    
}

extension RawReferenceConvertible
{
    func _bridgeToObjectiveC() -> NSNumber
    {
        NSNumber(self.rawValue)
    }
    
    static func _forceBridgeFromObjectiveC(_ source: NSNumber, result: inout Self?)
    {
        result = Self(rawValue: source.intValue)
    }
    
    static func _conditionallyBridgeFromObjectiveC(_ source: NSNumber, result: inout Self?) -> Bool
    {
        self._forceBridgeFromObjectiveC(source, result: &result)
        
        return true
    }
    
    static func _unconditionallyBridgeFromObjectiveC(_ source: NSNumber?) -> Self
    {
        let rawValue: Int = source?.intValue ?? 0
        let bar = Self(rawValue: rawValue)!
        
        return bar
    }
}
