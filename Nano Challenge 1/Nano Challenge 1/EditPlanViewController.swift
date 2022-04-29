//
//  EditPlanViewController.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

class EditPlanViewController: UIViewController {

    var chosenIndex : Int?
    var chosenPlan : Plan?
    var isUpdate : (()-> Void)?
    var pageTitle : String?
    
    @IBOutlet weak var planTitle: UITextField!
    
    @IBOutlet weak var planNotes: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    weak var delegate: EditTaskViewControllerDelegate?

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.modalControllerWillDisapear(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            fetchData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil
        )
    }
    
    func fetchData() {
        
        
        // Fetch the data from Core Data to display in the tableView
        do {
            if let chosen = self.chosenIndex {
                self.chosenPlan = try context.fetch(Plan.fetchRequest())[chosen]
            }
            else {}
       
    
        } catch {
            print(error)
        }
    }
    
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        // Create a person object
        chosenPlan?.title = self.planTitle.text
        chosenPlan?.desc = self.planNotes.text
        
        // Save the data
        do {
            try
            
            self.context.save()
        } catch {
            print(error)
        }
        
        self.dismiss(animated: true, completion: nil
        )
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
