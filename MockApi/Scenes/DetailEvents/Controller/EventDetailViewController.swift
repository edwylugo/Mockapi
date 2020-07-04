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
    
    var checkin: Checkin!
    var name: String? = ""
    var email: String? = ""
    
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
        alertWithTF()
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
    
    
    func sendCheckin() {
           if checkin == nil {
               checkin = Checkin()
           }
        
             checkin.eventId  = "\(viewModel.events.id)"
             checkin.name = "\(name?.description ?? "")"
             checkin.email = "\(email?.description ?? "")"
             print("checkin.eventId: \(viewModel.events.id)")
             print("checkin.name: \(name?.description ?? "")")
             print("checkin.email: \(email?.description ?? "")")
        
            MockREST.sendCheckin(sendCheck: self.checkin) { _ in
                   print("Checkin efetuado com sucesso")
            }
    }
    
    func alertWithTF() {
        
        let alert = UIAlertController(title: "MockAPI", message: "Preencha os dados:", preferredStyle: UIAlertController.Style.alert )
        
        alert.addAction(UIAlertAction(title: "Check-in", style: .default, handler: { _ in
            let textField = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            if textField.text != "" {
                //Read TextFields text data
                print(textField.text!)
                print("TF 1 : \(textField.text!)")
            } else {
                print("TF 1 is Empty...")
            }

            if textField2.text != "" {
                print(textField2.text!)
                print("TF 2 : \(textField2.text!)")
            } else {
                print("TF 2 is Empty...")
            }
            
            print("Modal Confirmação")
            let modalViewController = ModalViewController(navigationDelegate: self)
            modalViewController.modalPresentationStyle = .overCurrentContext
            modalViewController.modalTransitionStyle = .crossDissolve
            modalViewController.popoverPresentationController?.permittedArrowDirections = .any
            self.navigationController?.present(modalViewController, animated: true, completion: nil)
            
        }))
        
        alert.addTextField { (textField) in
            textField.placeholder = "Informe seu nome"
            textField.textColor = .red
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Informe seu e-mail"
            textField.textColor = .blue
        }
        
        //OR single line action
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
            print("Alert Cancelado")
        }))

        self.present(alert, animated:true, completion: nil)

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
        sendCheckin()
    }
    
    func noAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
