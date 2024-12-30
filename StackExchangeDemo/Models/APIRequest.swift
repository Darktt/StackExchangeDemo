//
//  APIRequest.swift
//
//  Created by Darktt on 2023/10/6.
//

import Foundation
import SwiftExtensions

public
protocol APIRequest
{
    associatedtype Response: JsonDecodable
    
    typealias Result = Swift.Result<Response, any Error>
    
    // MARK: - Properties -
    
    var apiName: APIName { get }
    
    var method: HTTPMethod { get }
    
    var parameters: Dictionary<AnyHashable, Any>? { get }
    
    var headers: Array<HTTPHeader>? { get }
}

extension APIRequest
{
    var urlRequest: URLRequest {
        
        var url: URL = self.apiName.url
        
        if method == .get {
            
            if #available(iOS 16.0, *) {
                
                url.append(queryItems: self.parameters?.queryItems() ?? [])
            } else {
                
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = self.parameters?.queryItems()
                
                url = urlComponents?.url ?? url
            }
        }
        
        var request = URLRequest(url: url)
        request.method = self.method
        request.allHTTPHeaderFields = self.headers?.dictionary()
        
        return request
    }
}

extension Dictionary<AnyHashable, Any>
{
    func queryItems() -> Array<URLQueryItem>
    {
        self.compactMap {
            
            (key, value) in
            
            guard let keyString = key as? String else {
                
                return nil
            }
            
            let valueString = "\(value)"
            let item = URLQueryItem(name: keyString, value: valueString)
            
            return item
        }
    }
}
