//
//  NavigationController.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    override func loadView() {
        super.loadView()
        configureNavigation()
    }

    private func configureNavigation() {
        navigationBar.tintColor = .white
        navigationBar.prefersLargeTitles = true
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = true
    }
}
