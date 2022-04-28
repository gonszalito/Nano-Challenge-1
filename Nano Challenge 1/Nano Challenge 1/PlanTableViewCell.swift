//
//  PlanTableViewCell.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

class PlanTableViewCell: UITableViewCell {

    @IBOutlet weak var planView: UIView!
    @IBOutlet weak var planTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func planCellPressed(_ sender: Any) {
    }
    
    
}
