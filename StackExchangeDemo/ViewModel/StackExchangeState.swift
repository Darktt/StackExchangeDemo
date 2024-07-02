//
//  StackExchangeState.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/27.
//

import Foundation
import UIKit.UIImage

public
struct StackExchangeState
{
    // MARK: - Properties -
    
    public private(set)
    var topQuestions: Array<QuestionItem> = []
    
    public private(set)
    var questionItem: QuestionItem?
    
    public private(set)
    var page: Int = 1
    
    public private(set)
    var endOfPage: Bool = false
    
    public private(set)
    var avatarImage: UIImage?
    
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
    
    mutating
    func questionItem(via questionId: Int)
    {
        let item: QuestionItem? = self.topQuestions.first(where: { $0.id == questionId })
        
        self.questionItem = item
    }
    
    mutating
    func updateQuestionItem(_ question: QuestionItem?)
    {
        guard let question = question, question.id == self.questionItem?.id else {
            
            return
        }
        
        self.questionItem = question
    }
    
    mutating
    func updateAvatarImage(_ image: UIImage?)
    {
        self.avatarImage = image
    }
}
