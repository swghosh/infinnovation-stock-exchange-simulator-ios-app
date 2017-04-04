//
//  DetailedStockTableViewCell.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 03/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class DetailedStockTableViewCell: UITableViewCell {

    @IBOutlet weak var sector: UILabel!
    @IBOutlet weak var profile: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
