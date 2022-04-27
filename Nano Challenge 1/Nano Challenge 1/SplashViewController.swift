//
//  SplashViewController.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       makeRoundedAndShadowed(view: continueButton)
        // Do any additional setup after loading the view.
    }
    
    @IBAction
    func doContinueButton(_ sender: UIButton) {
        
    }
    
    func makeRoundedAndShadowed(view: UIButton) {
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true

        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5.0
    }
    
    func customContinueButton(view: UIButton){
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
