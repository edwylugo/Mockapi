//
//  EventDetailViewModel.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation

protocol EventDetailNavigationProtocol: AnyObject {}

protocol EventDetailViewModelProtocol {
    var events: Event { get }
}

struct EventDetailViewModel {
    var events: Event

    private weak var navigationDelegate: EventDetailNavigationProtocol?

    init(navigationDelegate: EventDetailNavigationProtocol? = nil, events: Event) {
        self.navigationDelegate = navigationDelegate
        self.events = events
    }
}

extension EventDetailViewModel: EventDetailViewModelProtocol {}
