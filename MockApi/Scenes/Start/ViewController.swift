//
//  ViewController.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func goListEvents(_ sender: Any) {
           let coordinator = InitialCoordinator(presenter: self.navigationController!)
           coordinator.start()
       }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

