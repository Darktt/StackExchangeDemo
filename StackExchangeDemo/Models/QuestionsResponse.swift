//
//  QuestionsResponse.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/27.
//

import Foundation
import JsonProtection

public
struct QuestionsResponse
{
    // MARK: - Properties -
    
    public
    var items: Array<QuestionItem>
}

extension QuestionsResponse: JsonDecodable
{ }

public
struct QuestionItem
{
    // MARK: - Properties -
    
    @NumberProtection
    public
    var id: Int?
    
    @NumberProtection
    public
    var score: Int?
    
    @NumberProtection
    public
    var answerCount: Int?
    
    @NumberProtection
    public
    var viewCount: Int?
    
    public private(set)
    var title: String?
    
    public private(set)
    var body: String?
    
    public private(set)
    var date: Date?
    
    public private(set)
    var tags: Array<String> = []
    
    public private(set)
    var owner: User?
}

extension QuestionItem: Decodable
{
    enum CodingKeys: String, CodingKey {
        
        case id = "question_id"
        
        case score
        
        case answerCount = "answer_count"
        
        case viewCount = "view_count"
        
        case title
        
        case body = "body_markdown"
        
        case date = "creation_date"
        
        case tags
        
        case owner
    }
}
