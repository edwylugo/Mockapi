//
//  ListEventsViewModel.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import Foundation

protocol ListEventNavigationProtocol: AnyObject {
    func gotoEventDetail(events: Event)
}

protocol ListEventViewModelProtocol {
    var dataSource: Observable<[Event]> { get }

    func didSelectItemAt(indexPath: IndexPath)
    mutating func filterEvent(search: String?)

    var isLoading: Observable<Bool> { get }
    var isPullRefresh: Observable<Bool> { get }
    var error: Observable<Error?> { get }

    func setDataSource()
    func pullRefresh()
}

struct ListEventsViewModel: ListEventViewModelProtocol {
    private weak var navigationDelegate: ListEventNavigationProtocol?
    private var eventsFilter: Observable<[Event]> = Observable([])
    private var eventsNoFilter: Observable<[Event]> = Observable([])
    var isLoading: Observable<Bool>
    var isPullRefresh: Observable<Bool>
    var error: Observable<Error?>
    var filterEnable = false

    var dataSource: Observable<[Event]> {
        if filterEnable {
            return eventsFilter
        } else {
            return eventsNoFilter
        }
    }
    
    init(navigationDelegate: ListEventNavigationProtocol? = nil) {
        self.navigationDelegate = navigationDelegate
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isPullRefresh = Observable(false)
        setDataSource()
    }
    
    func setDataSource() {
        
    }
    
    func pullRefresh() {
        
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        guard dataSource.value.indices.contains(indexPath.row) else { return }
        let item = dataSource.value[indexPath.row]
        navigationDelegate?.gotoEventDetail(events: item)
    }
    
    mutating func filterEvent(search: String?) {
        
    }
    
    
}
