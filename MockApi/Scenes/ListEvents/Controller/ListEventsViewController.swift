//
//  ListEventsViewController.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

class ListEventsViewController: UIViewController {
    
    private var viewModel: ListEventViewModelProtocol
    
    init(viewModel: ListEventViewModelProtocol) {
              self.viewModel = viewModel
              super.init(nibName: "ListEventsViewController", bundle: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.reloadData()
    }
    
    func setupUI() {
           // Retorna a célula da interface
           let nib = UINib(nibName: "ListEventTableViewCell", bundle: nil)
           tableView.register(nib, forCellReuseIdentifier: ListEventTableViewCell.reuseIdentifier)
       }
    
    func setupBindings() {
           viewModel.dataSource.bind { [weak self] _ in
               guard let self = self else { return }
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
    }

}

extension ListEventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: ListEventTableViewCell.reuseIdentifier,
                                                              for: indexPath) as? ListEventTableViewCell else { return UITableViewCell() }
        
        return cell
        
        
    }
    
    
}
