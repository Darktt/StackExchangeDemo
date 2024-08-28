//
//  Coordinator.swift
//  StackExchangeDemo
//
//  Created by Darktt on 2024/7/1.
//

import UIKit

public
class Coordinator
{
    // MARK: - Properties -
    
    public static
    let shared: Coordinator = Coordinator()
    
    fileprivate
    lazy var navigationDelegate: NavigationDelegate = {
        
        NavigationDelegate(parent: self)
    }()
    
    fileprivate
    lazy var tabBarDelegate: TabBarDelegate = {
        
        TabBarDelegate(parent: self)
    }()
    
    fileprivate
    var currentViewController: UIViewController?
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    private
    init()
    {
        
    }
    
    public
    func nextPage(_ page: Page)
    {
        switch page
        {
            case let .questionDetail(questionId, store):
                self.showQuestionDetail(with: questionId, store: store)
        }
    }
    
    deinit
    {
        
    }
}

// MARK: - Private Methods -

private
extension Coordinator
{
    func showQuestionDetail(with questionId: Int, store: StackExchangeStore)
    {
        guard let viewController = self.currentViewController else {
            
            return
        }
        
        let questionDetailController = QuestionDetailController(with: questionId, store: store)
        
        viewController.navigationController?.pushViewController(questionDetailController, animated: true)
    }
}

// MARK: - Coordinator.NavigationDelegate -

private
extension Coordinator
{
    class NavigationDelegate: NSObject
    {
        fileprivate
        unowned var parent: Coordinator!
        
        fileprivate
        init(parent: Coordinator) {
            
            self.parent = parent
        }
    }
}

extension Coordinator.NavigationDelegate: UINavigationControllerDelegate
{
    public
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool)
    {
        self.parent.currentViewController = viewController
    }
}

// MARK: - Coordinator.TabBarDelegate -

private
extension Coordinator
{
    class TabBarDelegate: NSObject
    {
        fileprivate
        unowned var parent: Coordinator!
        
        fileprivate
        init(parent: Coordinator) {
            
            self.parent = parent
        }
    }
}

extension Coordinator.TabBarDelegate: UITabBarControllerDelegate
{
    public
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        self.parent.currentViewController = viewController
    }
}

// MARK: - Coordinator.Page -

public
extension Coordinator
{
    enum Page
    {
        case questionDetail(Int, StackExchangeStore)
    }
}

// MARK: - UINavigationController -

extension UINavigationController
{
    open override 
    func viewDidLoad()
    {
        super.viewDidLoad()
        
        let coordinator = Coordinator.shared
        coordinator.currentViewController = self.viewControllers.first
        
        self.delegate = coordinator.navigationDelegate
    }
}

// MARK: - UITabbarController -

extension UITabBarController
{
    open override 
    func viewDidLoad()
    {
        super.viewDidLoad()
        
        let viewController: UIViewController? = {
            
            guard let viewController = self.selectedViewController as? UINavigationController else {
                
                return self.selectedViewController
            }
            
            return viewController.topViewController
        }()
        
        let coordinator = Coordinator.shared
        coordinator.currentViewController = viewController
        
        self.delegate = coordinator.tabBarDelegate
    }
}
