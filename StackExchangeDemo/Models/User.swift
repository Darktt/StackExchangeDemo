//
//  User.swift
//  StackExchangeDemo
//
//  Created by Eden on 2024/6/27.
//

import Foundation
import JsonProtection

public
struct User
{
    // MARK: - Properties -
    
    public private(set)
    var name: String?
    
    @NumberProtection
    public
    var reputation: Int?
    
    @URLProtection
    public
    var profileImageURL: URL?
}

extension User: Decodable
{
    enum CodingKeys: String, CodingKey {
        
        case name = "display_name"
        
        case reputation
        
        case profileImageURL = "profile_image"
    }
}
