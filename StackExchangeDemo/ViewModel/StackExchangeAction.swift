//
//  StackExchangeAction.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/6/27.
//

import Foundation
import UIKit.UIImage

public
enum StackExchangeAction
{
    case fetchTopQuestions(QuestionsRequest)
    
    case fetchTopQuestionsResponse(Array<QuestionItem>, Int)
    
    case fetchQuestion(QuestionsRequest)
    
    case fetchQuestionResponse(QuestionItem?)
    
    case fetchApiError(Error)
    
    case fetchImage(URL)
    
    case fetchImageResponse(UIImage?)
    
    case error(StackExchangeError)
}
