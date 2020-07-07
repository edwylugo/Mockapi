//
//  TabBarAppViewController.swift
//  MockApi
//
//  Created by Edwy Lugo on 04/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

class TabBarAppViewController: UITabBarController, UITabBarControllerDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }

       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           self.delegate = self
           title = "Eventos"
       }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationItem.setHidesBackButton(true, animated: true)
           // Custom Tab bar
          self.tabBar.barTintColor = UIColor.white
           UITabBar.appearance().tintColor = UIColor.black
           UITabBar.appearance().barTintColor = UIColor.white
           UITabBar.appearance().unselectedItemTintColor = .lightGray
           UITabBar.appearance().isTranslucent = true

           let viewModel = ListEventsViewModel(navigationDelegate: self)
           let tabOne = ListEventsViewController(viewModel: viewModel)
        
           let tabOneBarItem = UITabBarItem(title: "Eventos", image: UIImage(systemName: "book.fill"), selectedImage: UIImage(systemName: "book.fill"))
           tabOne.tabBarItem = tabOneBarItem

           self.viewControllers = [tabOne]
       }
    
    func tabBarController(_: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.isKind(of: ListEventsViewController.self) {
             self.navigationItem.title = "Eventos"
        }
    }
}


extension TabBarAppViewController: ListEventNavigationProtocol {
    func gotoBackMenuSync() {
        navigationController?.popViewController(animated: true)
    }
    
    func gotoEventDetail(events: Event) {
        let viewModel = EventDetailViewModel(navigationDelegate: self, events: events)
        let viewController = EventDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TabBarAppViewController: EventDetailNavigationProtocol {}
