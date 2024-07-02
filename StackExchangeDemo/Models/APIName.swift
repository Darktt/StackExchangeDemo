//
//  APIName.swift
//
//  Created by Darktt on 2023/7/4.
//

import Foundation

public
struct APIName
{
    // MARK: - Properties -
    
    public static
    var questions: APIName = APIName("https://api.stackexchange.com/2.3/questions")
    
    public
    var url: URL
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public static
    func questions(with identifier: Int) -> APIName
    {
        APIName("https://api.stackexchange.com/2.3/questions/\(identifier)")
    }
    
    private
    init(_ urlString: String)
    {
        self.url = URL(string: urlString)!
    }
}
