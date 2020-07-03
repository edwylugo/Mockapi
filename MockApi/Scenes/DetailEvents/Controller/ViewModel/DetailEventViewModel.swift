//
//  DetailEventViewModel.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//


import Foundation

protocol DetailEventNavigationProtocol: AnyObject {}

protocol DetailEventViewModelProtocol {
    var dataSource: Observable<Event?> { get }
}

struct DetailEventViewModel: DetailEventViewModelProtocol {
    private weak var navigationDelegate: DetailEventNavigationProtocol?
    var dataSource: Observable<Event?>
    
    init(navigationDelegate: DetailEventNavigationProtocol? = nil) {
        self.navigationDelegate = navigationDelegate
        self.dataSource = Observable(nil)
    }
    
   
}

