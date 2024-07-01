//
//  FluentInterface+CustomCellRegisterable.swift
//
//  Created by Darktt on 21/12/28.
//  Copyright © 2021 Darktt. All rights reserved.
//

import UIKit

public 
extension FluentInterface where Subject == UITableView
{
    func register<Cell>(_ cell: Cell.Type) -> FluentInterface<Subject> where Cell: UITableViewCellRegistrable
    {
        self.subject.register(cell)
        
        return self
    }
    
    func register<ReusableView>(_ view: ReusableView.Type) -> FluentInterface<Subject> where ReusableView: UITableViewHeaderFooterViewRegistrable
    {
        self.subject.register(view)
        
        return self
    }
}

public
extension FluentInterface where Subject == UICollectionView
{
    func register<Cell>(_ cell: Cell.Type) -> FluentInterface<Subject> where Cell: UICollectionViewCellRegistrable
    {
        self.subject.register(cell)
        
        return self
    }
    
    func register<ReusableView>(_ view: ReusableView.Type) -> FluentInterface<Subject>  where ReusableView: UICollectionReusableViewRegistrable
    {
        self.subject.register(view)
        
        return self
    }
}
