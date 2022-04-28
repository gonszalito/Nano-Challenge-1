//
//  PlanContainer.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

@IBDesignable class PlanContainer: UIView {

    @IBOutlet var planContainer: UIView!
    
    
    @IBOutlet weak var planTitle: UILabel!
    
    func customView(view: UIView){
        // corner radius
        view.layer.cornerRadius = 10

        // border
        view.layer.borderWidth = 0

        // shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
