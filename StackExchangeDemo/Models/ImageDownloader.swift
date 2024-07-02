//
//  ImageDownloader.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/7/2.
//

import Foundation
import UIKit.UIImage
import SwiftExtensions

public final
class ImageDownloader
{
    // MARK: - Properties -
    
    public static
    let shared = ImageDownloader()
    
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
        
        if statusCode != 200 {
            
            let error = HTTPError(statusCode)
            
            throw error
        }
        
        if statusCode == 200 {
            
            let cachedResponse = CachedURLResponse(response: response, data: data)
            self.chachedImages.storeCachedResponse(cachedResponse, for: request)
        }
        
        let image = UIImage(data: data)
        
        return image
    }
    
    deinit
    {
        
    }
}
