//
//  Coordinator.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/7/1.
//

import UIKit

public
class Coordinator
{
    // MARK: - Properties -
    
    public static
    let shared: Coordinator = Coordinator()
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    private
    init()
    {
        
    }
    
    public
    func nextPage(_ page: Page, from viewController: UIViewController)
    {
        switch page
        {
            case let .questionDetail(questionId, store):
                self.showQuestionDetail(with: questionId, store: store, from: viewController)
            
            case let .back(animated, completion):
                viewController.dismiss(animated: animated, completion: completion)
        }
    }
    
    deinit
    {
        
    }
}

// MARK: - Private Methods -

private
extension Coordinator
{
    func showQuestionDetail(with questionId: Int, store: StackExchangeStore, from viewController: UIViewController)
    {
        let questionDetailController = QuestionDetailController(with: questionId, store: store)
        
        viewController.navigationController?.pushViewController(questionDetailController, animated: true)
    }
}

// MARK: - Coordinator.Page -

public
extension Coordinator
{
    enum Page
    {
        case questionDetail(Int, StackExchangeStore)
        
        case back(Bool, (() -> Void)? = nil)
    }
}
