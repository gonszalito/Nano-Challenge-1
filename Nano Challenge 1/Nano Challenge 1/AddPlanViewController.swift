//
//  AddPlanViewController.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

class AddPlanViewController: UIViewController {

    @IBOutlet weak var newPlanTitle: UITextField!
    @IBOutlet weak var newPlanNotes: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Refresh When Modal Dismisses
    weak var delegate: ModalViewControllerDelegate?

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.modalControllerWillDisapear(self)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil
        )
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {

            // Create a person object
        
        if (newPlanTitle.text == nil || newPlanTitle.text == "") {
            
        }else {
            let newPlan = Plan(context: self.context)
            newPlan.title = newPlanTitle.text
            newPlan.desc = newPlanNotes.text
            
            // Save the data
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
           
          
            
        self.dismiss(animated: true, completion: nil
        )
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


