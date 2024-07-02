//
//  ViewControllerExtension.swift
//
//  Created by Darktt on 2024/7/2.
//  
//

import UIKit

public
extension UIViewController
{
    func presentErrorAlert(with error: StackExchangeError)
    {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alertController = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
