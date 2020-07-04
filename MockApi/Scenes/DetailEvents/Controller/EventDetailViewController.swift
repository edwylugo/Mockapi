//
//  EventDetailViewController.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    private var viewModel: EventDetailViewModelProtocol
    
    init(viewModel: EventDetailViewModelProtocol) {
              self.viewModel = viewModel
              super.init(nibName: "EventDetailViewController", bundle: nil)
       }

    required init?(coder _: NSCoder) {
              fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.events.title
    }

}
