//
//  TabBarViewModel.swift
//  MockApi
//
//  Created by Edwy Lugo on 04/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation

protocol TabBarAppNavigationProtocol: AnyObject {}

protocol TabBarAppViewModelProtocol {}

struct TabBarAppViewModel {
    private var navigationDelegate: TabBarAppNavigationProtocol

    init(navigationDelegate: TabBarAppNavigationProtocol) {
        self.navigationDelegate = navigationDelegate
    }
}
