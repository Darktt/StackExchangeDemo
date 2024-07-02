//
//  ApiMiddware.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/28.
//

import Foundation

@MainActor
public
let ApiMiddware: Middleware<StackExchangeState, StackExchangeAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
            
            if case let StackExchangeAction.fetchTopQuestions(request) = action {
                
                Task {
                    
                    let newAction: StackExchangeAction = await fetchTopQuestions(with: request)
                    
                    next(newAction)
                }
                return
            }
            
            if case let StackExchangeAction.fetchQuestion(request) = action {
                
                Task {
                    
                    let newAction: StackExchangeAction = await fetchQuestion(with: request)
                    
                    next(newAction)
                }
                return
            }
            
            next(action)
        }
    }
}

private
func apiRequest<Request>(_ request: Request) async throws -> Request.Response where Request: APIRequest
{
    let apiHandler = APIHandler.shared
    let response: Request.Response = try await apiHandler.sendRequest(request)
    
    return response
}

private
func fetchTopQuestions(with request: QuestionsRequest) async -> StackExchangeAction
{
    do {
        
        let page = request.page
        let response: QuestionsResponse = try await apiRequest(request)
        let questions: Array<QuestionItem> = response.items
        
        let newAction = StackExchangeAction.fetchTopQuestionsResponse(questions, page)
        
        return newAction
    } catch {
        
        let newAction = StackExchangeAction.fetchApiError(error)
        
        return newAction
    }
}

private
func fetchQuestion(with request: QuestionsRequest) async -> StackExchangeAction
{
    do {
        
        let response: QuestionsResponse = try await apiRequest(request)
        let questions: Array<QuestionItem> = response.items
        
        let newAction = StackExchangeAction.fetchQuestionResponse(questions.first)
        
        return newAction
    } catch {
        
        let newAction = StackExchangeAction.fetchApiError(error)
        
        return newAction
    }
}
