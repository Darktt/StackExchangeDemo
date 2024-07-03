//
//  ImageLoaderMiddware.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/7/2.
//

import Foundation
import UIKit

@MainActor
public
let ImageLoaderMiddware: Middleware<StackExchangeState, StackExchangeAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
                
                if case let StackExchangeAction.fetchImage(request) = action {
                    
                    Task {
                        
                        let newAction: StackExchangeAction = await fetchImage(url: request)
                        
                        next(newAction)
                    }
                    return
                }
                
                next(action)
        }
    }
}

func fetchImage(url: URL) async -> StackExchangeAction 
{
    do {
        
        let downloader = ImageLoader.shared
        let image: UIImage? = try await downloader.load(with: url)
        
        let newAction: StackExchangeAction = StackExchangeAction.fetchImageResponse(image)
        
        return newAction
        
    } catch {
        
        let newAction = StackExchangeAction.fetchApiError(error)
        
        return newAction
    }
}
