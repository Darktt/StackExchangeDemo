//
//  StackExchangeState.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/27.
//

import Foundation

public
struct StackExchangeState
{
    // MARK: - Properties -
    
    public private(set)
    var topQuestions: Array<QuestionItem> = []
    
    public private(set)
    var page: Int = 1
    
    public private(set)
    var endOfPage: Bool = false
    
    public
    var isFetching: Bool = false
    
    public
    var error: StackExchangeError?
    
    public
    let numberFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
}

public
extension StackExchangeState
{
    mutating
    func updateTopQuestions(_ questions: Array<QuestionItem>?, in page: Int)
    {
        self.page = page
        
        guard let questions = questions.and({ !$0.isEmpty }) else {
            
            self.endOfPage = true
            return
        }
        
        if page == 1 {
            
            self.topQuestions = questions
        } else {
            
            self.topQuestions.append(contentsOf: questions)
        }
    }
}
