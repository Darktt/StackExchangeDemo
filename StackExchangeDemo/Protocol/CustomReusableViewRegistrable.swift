//
//  CustomReusableViewRegistrable.swift
//
//  Created by Darktt on 19/9/23.
//  Copyright © 2019 Darktt. All rights reserved.
//

import UIKit

public 
protocol CustomReusableViewRegistrable
{
    static var nib: UINib? { get }
    
    /// **elementKindSectionFooter** or **elementKindSectionHeader** for UICollectionView.
    static var kind: String? { get }
    
    static var reuseIdentifier: String { get }
}

// MARK: - Extensions -
// MARK: UITableView

public
typealias UITableViewHeaderFooterViewRegistrable = (UITableViewHeaderFooterView & CustomReusableViewRegistrable)

public 
extension UITableView
{
    func register<ReusableView>(_ view: ReusableView.Type) where ReusableView: UITableViewHeaderFooterViewRegistrable
    {
        if let nib = view.nib {
            
            self.register(nib, forHeaderFooterViewReuseIdentifier: view.reuseIdentifier)
        } else {
            
            self.register(view.self, forHeaderFooterViewReuseIdentifier: view.reuseIdentifier)
        }
    }
    
    func dequeueReusableHeaderFooterView<ReusableView>(_ view: ReusableView.Type) -> ReusableView where ReusableView: UITableViewHeaderFooterViewRegistrable
    {
        let view = self.dequeueReusableHeaderFooterView(withIdentifier: view.reuseIdentifier) as! ReusableView
        
        return view
    }
}

// MARK: UICollectionView

public
typealias UICollectionReusableViewRegistrable = (UICollectionReusableView & CustomReusableViewRegistrable)

public 
extension UICollectionView
{
    func register<ReusableView>(_ view: ReusableView.Type) where ReusableView: UICollectionReusableViewRegistrable
    {
        guard let kind: String = view.kind else {
            
            fatalError("Static property 'kind' can not be nil.")
        }
        
        let identifier: String = view.reuseIdentifier
        
        if let nib = view.nib {
            
            self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        } else {
            
            self.register(view.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }
    
    func dequeueReusableSupplementaryView<ReusableView>(_ view: ReusableView.Type, for indexPath: IndexPath) -> ReusableView where ReusableView: UICollectionReusableViewRegistrable
    {
        guard let kind: String = view.kind else {
            
            fatalError("Static property 'kind' can not be nil.")
        }
        
        let identifier: String = view.reuseIdentifier
        
        let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as! ReusableView
        
        return view
    }
}
