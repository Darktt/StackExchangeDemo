//
//  ImageLoader.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/7/2.
//

import Foundation
import UIKit.UIImage
import SwiftExtensions

public final
class ImageLoader
{
    // MARK: - Properties -
    
    public static
    let shared = ImageLoader()
    
    private
    var chachedImages: URLCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 0)
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    private
    init()
    {
        
    }
    
    public
    func load(with url: URL) async throws -> UIImage?
    {
        let request = URLRequest(url: url)
        
        if let cachedResponse = self.chachedImages.cachedResponse(for: request) {
            
            let image = UIImage(data: cachedResponse.data)
            
            return image
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            
            return nil
        }
        
        let statusCode: Int = response.statusCode
        
        if let statusCode = HTTPError.StatusCode(rawValue: statusCode) {
            
            let error = HTTPError(statusCode)
            throw error
        }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let image = UIImage(data: data)
        
        if image != nil {
            
            self.chachedImages.storeCachedResponse(cachedResponse, for: request)
        }
        
        return image
    }
    
    deinit
    {
        
    }
}
