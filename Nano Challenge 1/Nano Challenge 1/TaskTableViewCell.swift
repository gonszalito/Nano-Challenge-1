//
//  TaskTableViewCell.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var taskCheckButton: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
    @IBAction func clickCheckButton(_ sender: Any) {
        // corner radius
        taskCheckButton.layer.cornerRadius = 10
        taskCheckButton.backgroundColor = UIColor.systemGreen
        // border
        taskCheckButton.layer.borderWidth = 0
        taskCheckButton.layer.borderColor = UIColor.black.cgColor

    }
    
    func customButton(view: UIButton) {
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true

        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5.0
    }
}
