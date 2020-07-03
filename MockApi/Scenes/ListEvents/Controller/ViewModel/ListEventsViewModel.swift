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
    
    private var eventsFilter: Observable<[Event]> = Observable([])
    private var eventsNoFilter: Observable<[Event]> = Observable([])
    
    init(navigationDelegate: ListEventNavigationProtocol? = nil) {
        self.navigationDelegate = navigationDelegate
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isPullRefresh = Observable(false)
        setDataSource()
    }
    
    func setDataSource() {
        
        isLoading.value = true
        
        MockREST.loadBook(onComplete: { events in
            self.dataSource.value = events.self
            self.isLoading.value = false
        }) { error in
            DispatchQueue.main.async {
                print(error)
                switch error {
                case .url:
                    self.isLoading.value = false
                    print("Não foi possível carregar a URL")
                case let .taskerror(error):
                    self.isLoading.value = false
                    CommonToUI.sharedInstance.showAlert("Mocki:", "Para visualizar os Eventos é necessário estar conectado com a internet.", nil)
                    print("\(error)")
                case let .noResponse(error):
                    self.isLoading.value = false
                    CommonToUI.sharedInstance.showAlert(error.localizedDescription, "Serviço fora do ar. Entre em contato com a equipe técnica para visualizar os eventos.", nil)
                case .noData:
                    self.isLoading.value = false
                    print("Não foi possível carregar os dados para visualizar os Eventos.")
                case let .responseStatusCode(code):
                    self.isLoading.value = false
                    CommonToUI.sharedInstance.showAlert("Mocki:", "Verificamos que o servidor está fora do ar (Status: \(code).", nil)
                case let .invalidJSON(error):
                    self.isLoading.value = false
                    CommonToUI.sharedInstance.showAlert(error.localizedDescription, "Uma nova estrutura foi criada pela equipe de desenvolvedores. Entre em contato com a equipe técnica.", nil)
                }
            }
            
        }
    }
    
    func pullRefresh() {
        isPullRefresh.value = true
        
        MockREST.loadBook(onComplete: { events in
             self.dataSource.value = events.self
             self.isPullRefresh.value = false
         }) { error in
             DispatchQueue.main.async {
                 print(error)
                 switch error {
                 case .url:
                    self.isPullRefresh.value = false
                     print("Não foi possível carregar a URL")
                 case let .taskerror(error):
                    self.isPullRefresh.value = false
                     CommonToUI.sharedInstance.showAlert("Mocki:", "Para visualizar os Eventos é necessário estar conectado com a internet.", nil)
                     print("\(error)")
                 case let .noResponse(error):
                    self.isPullRefresh.value = false
                     CommonToUI.sharedInstance.showAlert(error.localizedDescription, "Serviço fora do ar. Entre em contato com a equipe técnica para visualizar os eventos.", nil)
                 case .noData:
                    self.isPullRefresh.value = false
                     print("Não foi possível carregar os dados para visualizar os Eventos.")
                 case let .responseStatusCode(code):
                    self.isPullRefresh.value = false
                     CommonToUI.sharedInstance.showAlert("Mocki:", "Verificamos que o servidor está fora do ar (Status: \(code).", nil)
                 case let .invalidJSON(error):
                    self.isPullRefresh.value = false
                     CommonToUI.sharedInstance.showAlert(error.localizedDescription, "Uma nova estrutura foi criada pela equipe de desenvolvedores. Entre em contato com a equipe técnica.", nil)
                 }
             }
             
         }
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        guard dataSource.value.indices.contains(indexPath.row) else { return }
        let item = dataSource.value[indexPath.row]
        navigationDelegate?.gotoEventDetail(events: item)
    }
    
    mutating func filterEvent(search: String?) {
        if let text = search?.uppercased(), text != "" {
                      filterEnable = true

                       eventsFilter.value = eventsNoFilter.value.filter { events -> Bool in
                        events.title.uppercased().contains(text.uppercased())
                      }

                  } else {
                      filterEnable = false
                       eventsFilter.value = []
                  }
        
    }
    
    
}
