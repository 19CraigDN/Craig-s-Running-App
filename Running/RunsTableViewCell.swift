//
//  RunsTableViewCell.swift
//  Running
//
//  Created by Debbie Neubieser on 8/1/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit

class RunsTableViewCell: UITableViewCell {
        
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
