//
//  ListEventTableViewCell.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit
import Kingfisher

class ListEventTableViewCell: UITableViewCell {
    
    @IBOutlet var lbDate: UILabel!
    @IBOutlet var lbPrice: UILabel!
    @IBOutlet var ivEvent: UIImageView!
    @IBOutlet var titleEvent: UILabel!
    

    class var reuseIdentifier: String {
        return "ListEventTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(viewModel: Event) {
        
        let price = "\(viewModel.price)"
        let newFormatPrice = price.replacingOccurrences(of: ".", with: ",")
        
        lbDate.text = viewModel.data
        lbPrice.text = "R$\(newFormatPrice)"
        titleEvent.text = viewModel.title
        
        if let url = URL(string: "\(viewModel.image)") {
           ivEvent.kf.setImage(with: url)
        }
        
    }
    
}
