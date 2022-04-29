//
//  AddTaskViewController.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 29/04/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    //Delegate TaskViewController
    
    weak var delegate: AddTaskViewControllerDelegate?

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           delegate?.modalControllerWillDisapear(self)
       }
    
    var chosenPlan : Plan?
    var chosenIndex : Int?
    
    @IBOutlet weak var newTaskTitle: UITextField!
    @IBOutlet weak var newTaskNotes: UITextField!
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil
        )
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

        
        // Fetch the data from Core Data to display in the tableView
       
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {

            // Create a person object
            let newTask = Task(context: self.context)
            newTask.title = newTaskTitle.text
            newTask.notes = newTaskNotes.text
            self.chosenPlan?.addToTask(newTask)
            self.chosenPlan?.noTasks += 1
            
  
        
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
