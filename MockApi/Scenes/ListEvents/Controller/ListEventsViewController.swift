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
    
    @IBOutlet var searchBar: UISearchBar! {
           didSet {
            searchBar.delegate = self
            searchBar.searchTextField.textColor = UIColor.black
           }
       }
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var refreshControl = UIRefreshControl()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MockiAPI"
        setupUI()
        setupBindings()
        addPullToRefresh()
    }
    
    func setupUI() {
        
           // Retorna a célula da interface
           let nib = UINib(nibName: "ListEventTableViewCell", bundle: nil)
           tableView.register(nib, forCellReuseIdentifier: ListEventTableViewCell.reuseIdentifier)
        
        searchBar.placeholder = "Pesquisar Eventos..."
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchBarStyle = .default
        addToolBar(searchBar.searchTextField)
        
        activityIndicator.isHidden = true
        
       }
    
    func setupBindings() {
           viewModel.dataSource.bind { [weak self] _ in
               guard let self = self else { return }
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
        
        viewModel.isLoading.bind { [weak self] isLoading in
                  guard let self = self else { return }
                  DispatchQueue.main.async {
                      isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
                      self.tableView.reloadData()
                  }
              }

              viewModel.isPullRefresh.bind { [weak self] isLoading in
                  guard let self = self else { return }
                  DispatchQueue.main.async {
                      isLoading ? print() : self.refreshControl.endRefreshing()
                      self.tableView.reloadData()
                  }
              }
        
    }
    
    func addToolBar(_ textField: UITextField) {
           // ToolBar
        let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.bounds.width, height: CGFloat(44))))
           toolBar.barStyle = .default
           toolBar.isTranslucent = true
           toolBar.tintColor = UIColor(red: 92 / 255, green: 216 / 255, blue: 255 / 255, alpha: 1)
           toolBar.sizeToFit()

           let title = ""

           // Adding Button ToolBar in UIPickerView
           let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(ListEventsViewController.doneClick))
        doneButton.tintColor = UIColor.black
           let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ListEventsViewController.cancelClick))
        cancelButton.tintColor = UIColor.black

           let labelSelecione = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil) // 7
           labelSelecione.tintColor = UIColor.white

           toolBar.setItems([cancelButton, spaceButton, labelSelecione, spaceButton, doneButton], animated: false)
           toolBar.isUserInteractionEnabled = true
           textField.inputAccessoryView = toolBar
       }
    
      @objc func doneClick() {
        viewModel.filterEvent(search: searchBar.searchTextField.text)
        tableView.reloadData()
        self.view.endEditing(true)
       }

       @objc func cancelClick() {
          self.view.endEditing(true)
       }
    
    private func addPullToRefresh() {
           refreshControl.tintColor = .gray
           refreshControl.addTarget(viewModel, action: #selector(ListEventsViewController.pullRefresh), for: UIControl.Event.valueChanged)
           tableView.addSubview(refreshControl)
       }

       @objc private func pullRefresh() {
           searchBar.searchTextField.text = ""
           viewModel.filterEvent(search: nil)
           viewModel.pullRefresh()
       }
    
      override func viewDidDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
          viewModel.pullRefresh()
      }

    override var prefersStatusBarHidden: Bool {
            return false
    }
    
}

extension ListEventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: ListEventTableViewCell.reuseIdentifier,
                                                              for: indexPath) as? ListEventTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           guard let cell = cell as? ListEventTableViewCell else { return }
           guard viewModel.dataSource.value.indices.contains(indexPath.row) else { return }
           let event = viewModel.dataSource.value[indexPath.row]
           cell.setup(viewModel: event)
       }

}

extension ListEventsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterEvent(search: searchBar.text)
        tableView.reloadData()
        view.endEditing(true)
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        viewModel.filterEvent(search: nil)
        tableView.reloadData()
        view.endEditing(true)
    }

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        viewModel.filterEvent(search: searchText)
        tableView.reloadData()
    }
}

extension ListEventsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_: UIScrollView) {
        view.endEditing(true)
    }
}
