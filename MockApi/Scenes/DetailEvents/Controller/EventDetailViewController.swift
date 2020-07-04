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
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBAction func btCheckin(_ sender: Any) {
        let modalViewController = ModalViewController(navigationDelegate: self)
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.modalTransitionStyle = .crossDissolve
        modalViewController.popoverPresentationController?.permittedArrowDirections = .any
        navigationController?.present(modalViewController, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.events.title
        setupUI()
    }
    
    func setupUI() {
      // Retorna a célula da interface
      let nib = UINib(nibName: "EventDetailTableViewCell", bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: EventDetailTableViewCell.reuseIdentifier)
      tableView.reloadData()
    }

}

extension EventDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 780
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailTableViewCell.reuseIdentifier,
                                                              for: indexPath) as? EventDetailTableViewCell else { return UITableViewCell() }
    
        return cell
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           guard let cell = cell as? EventDetailTableViewCell else { return }
           cell.setup(viewModel: viewModel.events)
       }
    
}


extension EventDetailViewController: ModalNavigationDelegate {
    func yesAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func noAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
