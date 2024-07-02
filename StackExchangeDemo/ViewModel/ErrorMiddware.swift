//
//  ErrorMiddware.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/6/28.
//

import Foundation
import SwiftExtensions

@MainActor
public
let ErrorMiddware: Middleware<StackExchangeState, StackExchangeAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
            
            guard case let StackExchangeAction.fetchApiError(error) = action else {
                
                next(action)
                return
            }
            
            if let error = error as? CustomNSError {
                
                let stackError = (error.errorCode, error.localizedDescription)
                
                next(.error(stackError))
                return
            }
            
            if let error = error as? HTTPError {
                
                let stackError = (error.statusCode.rawValue, error.description)
                
                next(.error(stackError))
                return
            }
            
            next(action)
        }
    }
}
