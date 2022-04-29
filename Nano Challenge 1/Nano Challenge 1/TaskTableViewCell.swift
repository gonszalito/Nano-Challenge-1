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
    
    var checkedStatus : Bool?
    var checkColor : Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
    @IBAction func clickCheckButton(_ sender: Any) {
//        if checkColor == false {
//            self.backgroundColor = UIColor.systemGreen
//            self.checkColor = true
//        }
//        else {
//            self.backgroundColor = UIColor.clear
//            self.checkColor = false
//        }
//
        
    }
    
    @IBOutlet weak var buttonHolder: UIButton!
    func customButton(view: UIButton) {
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.systemGreen
        // border
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.systemGreen
        
    }
    
    func customButtonBack(view: UIButton) {
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.clear
        // border
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.clear
        
    }
}
