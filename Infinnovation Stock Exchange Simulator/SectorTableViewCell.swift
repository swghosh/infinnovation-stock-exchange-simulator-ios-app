//
//  SectorTableViewCell.swift
//  InfiSES
//
//  Created by SwG Ghosh on 31/03/17.
//  Copyright © 2017 codecrafts. All rights reserved.
//

import UIKit

class SectorTableViewCell: UITableViewCell {
    @IBOutlet weak var sectorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
