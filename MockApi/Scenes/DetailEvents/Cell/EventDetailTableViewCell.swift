//
//  EventDetailTableViewCell.swift
//  MockApi
//
//  Created by Edwy Lugo on 04/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var ivEvent: UIImageView!
    @IBOutlet var priceEvent: UILabel!
    @IBOutlet var descriptionEvent: UILabel!
    

    class var reuseIdentifier: String {
        return "EventDetailTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(viewModel: Event) {

           let price = "\(viewModel.price)"
           let newFormatPrice = price.replacingOccurrences(of: ".", with: ",")
           
           priceEvent.text = "R$\(newFormatPrice)"
           descriptionEvent.text = viewModel.description
           
           if let url = URL(string: "\(viewModel.image)") {
              ivEvent.kf.setImage(with: url)
           } else {
               ivEvent.image = UIImage(named: "south")
           }
           
       }
    
}
