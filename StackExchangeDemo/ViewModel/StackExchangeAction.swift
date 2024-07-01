//
//  StackExchangeAction.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/27.
//

import Foundation

public
enum StackExchangeAction
{
    case fetchTopQuestions(QuestionsRequest)
    
    case fetchTopQuestionsResponse(Array<QuestionItem>, Int)
    
    case fetchApiError(Error)
    
    case error(StackExchangeError)
}
