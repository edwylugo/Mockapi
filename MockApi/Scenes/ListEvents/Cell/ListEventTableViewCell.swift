//
//  ListEventTableViewCell.swift
//  MockApi
//
//  Created by Edwy Lugo on 03/07/20.
//  Copyright © 2020 Edwy Lugo. All rights reserved.
//

import UIKit

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
    
}
