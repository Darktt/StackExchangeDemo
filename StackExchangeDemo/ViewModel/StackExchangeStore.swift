//
//  StackExchangeStore.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/28.
//

import Foundation

@MainActor
private
func kReducer(state: StackExchangeState, action: StackExchangeAction) -> StackExchangeState {
    
    var newState = state
    newState.error = nil
    
    switch action {
        
        case let .fetchTopQuestionsResponse(questions, page):
            newState.updateTopQuestions(questions, in: page)
        
        case let .error(error):
            newState.error = error
        
        default:
            break
    }
    
    return newState
}

public
typealias StackExchangeStore = Store<StackExchangeState, StackExchangeAction>

@MainActor
let kStackExchangeStore: StackExchangeStore = Store(initialState: StackExchangeState(), reducer: kReducer, middlewares: [ApiMiddware, ErrorMiddware])
