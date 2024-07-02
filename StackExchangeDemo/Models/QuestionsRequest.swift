//
//  QuestionsRequest.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/6/27.
//

import Foundation
import SwiftExtensions

public
struct QuestionsRequest: APIRequest
{
    public
    typealias Response = QuestionsResponse
    
    // MARK: - Properties -
    
    public private(set)
    var apiName: APIName = .questions
    
    public private(set)
    var method: HTTPMethod = .get
    
    public
    var parameters: Dictionary<AnyHashable, Any>? = [
        
        "site": "stackoverflow",
        "order": "desc",
        "sort": "votes",
        "tagged": "swiftui",
        "pagesize": "10",
    ]
    
    public private(set)
    var headers: Array<SwiftExtensions.HTTPHeader>? = nil
    
    public
    var page: Int = 1 {
        
        willSet {
                
            self.parameters?["page"] = "\(newValue)"
        }
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init()
    {
        self.parameters?["filter"] = "L7V2EDvuysm0H*BIB_.(egYSjq"
    }
    
    public
    init(with questionId: Int)
    {
        self.apiName = APIName.questions(with: questionId)
        self.parameters?["filter"] = ")3fFI)sF9pUF13d.QOYHh2wF41eBt2dc"
    }
}
