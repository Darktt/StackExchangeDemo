//
//  APIHandler.swift
//  YouBikeMap
//
//  Created by Eden on 2023/7/4.
//

import Foundation
import SwiftExtensions

public
class APIHandler
{
    // MARK: - Properties -
    
    public static var shared: APIHandler = .init()
    
    private lazy var urlSession: URLSession = {
        
        let configuration = URLSessionConfiguration.ephemeral
        let urlSession = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
        
        return urlSession
    }()
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    private
    init()
    {
        
    }
    
    deinit
    {
        
    }
    
    public
    func sendRequest<Request>(_ request: Request) async throws -> Request.Response where Request: APIRequest
    {
        let response: (Data, URLResponse) = try await self.urlSession.data(for: request.urlRequest)
        
        if let response = response.1 as? HTTPURLResponse,
            let statusCode = HTTPError.StatusCode(rawValue: response.statusCode) {
            
            throw HTTPError(statusCode)
        }
        
        let responseObject = try Request.Response.decode(with: response.0)
        
        return responseObject
    }
    
    public
    func sendRequest<Request>(_ request: Request, completion: @escaping (Request.Result) -> Void) where Request: APIRequest
    {
        let handler: URLSession.DataTaskResultHandler = {
            
            [unowned self] result in
            
            self.urlSession.finishTasksAndInvalidate()
            
            let newResult: Request.Result = result.flatMap {
                
                data in
                
                Result {
                    
                    try Request.Response.decode(with: data)
                }
            }
            
            completion(newResult)
        }
        
        let dataTask: URLSessionDataTask = self.urlSession.dataTask(with: request.urlRequest, completionHandler: handler)
        
        dataTask.resume()
    }
}

private
extension APIHandler
{
    func logJsonString(_ data: Data?)
    {
        guard let data = data else {
            
            return
        }
        
        let jsonString: String = data.string(encoding: .utf8) ?? ""
        
        print(jsonString)
    }
}
