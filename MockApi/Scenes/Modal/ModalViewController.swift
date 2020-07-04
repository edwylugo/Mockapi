//
//  ModalViewController.swift
//  MockApi
//
//  Created by Edwy Lugo on 04/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

protocol ModalNavigationDelegate {
    func yesAction()
    func noAction()
}

class ModalViewController: UIViewController {
    
    let navigationDelegate: ModalNavigationDelegate
    
    init(navigationDelegate: ModalNavigationDelegate) {
           self.navigationDelegate = navigationDelegate
           super.init(nibName: "ModalViewController", bundle: nil)
       }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func yesButtonTapped(_: UIButton) {
         navigationDelegate.yesAction()
         self.dismiss(animated: true, completion: nil)
     }

     @IBAction func noButtonTapped(_: UIButton) {
         navigationDelegate.noAction()
         self.dismiss(animated: true, completion: nil)
     }

    
}
