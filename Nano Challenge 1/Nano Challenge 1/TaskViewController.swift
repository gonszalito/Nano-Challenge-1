//
//  TaskViewController.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit


protocol AddTaskViewControllerDelegate : AnyObject {
    func modalControllerWillDisapear(_ modal: AddTaskViewController)
}

protocol EditTaskViewControllerDelegate : AnyObject {
    func modalControllerWillDisapear(_ modal: EditPlanViewController)
}

class TaskViewController: UIViewController {
    
//    var tasks = ["Work", "Groceries", "School", "Workout", "Family", "Friends", "Medical", "Do Project"]
//
    
    var tasks : [Task]?
    var pageTitle : String?
    var chosenTask : Task?
    var chosenPlan : Plan?
    var chosenIndex : Int?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
//        taskTableView.dragDelegate = self

        
        // Do any additional setup after loading the view.
    }
    
    //Delegate
    private func presentModalController() {
         let modal = EditPlanViewController()
         modal.delegate = self
         self.present(modal, animated: true)
     }
    
    func fetchData() {
        
        
        // Fetch the data from Core Data to display in the tableView
        do {
            if let chosen = self.chosenIndex {
                self.chosenPlan = try context.fetch(Plan.fetchRequest())[chosen]
            }
            else {
                
            }
            
            
            
            if let taskArray = self.chosenPlan?.task?.array{
               
                    self.tasks = taskArray as! [Task]
                
            }

    
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toPlanEditPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlanEditPage" {
            
        }
        
        switch (segue.identifier, segue.destination) {
              // Check that the segue identifer matches and destination controller is a ModalViewController
          case ("toTaskDetailsPage", let destination as AddTaskViewController):
            destination.chosenIndex = self.chosenIndex
            destination.title = self.title
            destination.chosenPlan = self.chosenPlan
            destination.delegate = self
        case ("toPlanEditPage", let destination as EditPlanViewController):
            destination.chosenIndex = self.chosenIndex
            destination.chosenPlan = self.chosenPlan
            destination.delegate = self
            destination.pageTitle = "Edit"
            destination.isUpdate = { [weak self] in
                self?.fetchData()
                self?.title = self?.chosenPlan?.title
                
            }
          case _:
              break
          }
      
    }
    
    
    @IBAction func addTaskButtonPressed(_ sender: Any) {
        pageTitle = chosenPlan?.title
        performSegue(withIdentifier: "toTaskDetailsPage", sender: self)
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

extension TaskViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        
        let task = self.tasks![indexPath.row]
        
        cell.taskTitle.text = task.title
        if task.isDone == true {
            cell.buttonHolder.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.backgroundColor = UIColor.systemGreen
        } else {
            cell.buttonHolder.setImage(UIImage(systemName: "circle"), for: .normal)
            cell.backgroundColor = UIColor.clear
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row)")
        // Put logic here
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = self.tasks![indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "Done") { (action, view, completionHandler) in
            
            task.isDone = true
            self.chosenPlan?.noTasks -= 1
            // Save the data
            do {
                try self.context.save()
            } catch {
                
            }
   
            // Re-fetch the data
            self.fetchData()
        }
        action.backgroundColor = UIColor.systemGreen
        
        // Create swipe action
        let action2 = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Which person to remove
            
            
            task.isDone = false
            self.chosenPlan?.noTasks -= 1
            // Remove the person
            self.context.delete(task)
            
            
            
            // Save the data
            do {
                try self.context.save()
            } catch {
                
            }
            task.isDone = false
   
            // Re-fetch the data
            self.fetchData()
        }
        
        let action3 = UIContextualAction(style: .destructive, title: "Undo") { (action, view, completionHandler) in
            
            // Which person to remove
            
            
            task.isDone = false
            // Remove the person
            
            self.chosenPlan?.noTasks += 1
            
            // Save the data
            do {
                try self.context.save()
            } catch {
                
            }
            task.isDone = false
   
            // Re-fetch the data
            self.fetchData()
        }
        action3.backgroundColor = UIColor.systemBlue
        
        // Return swipe actions
        if task.isDone == true{
            return UISwipeActionsConfiguration(actions: [action2,action3])
        }
        
        return UISwipeActionsConfiguration(actions: [action2,action])
    }
    
    
    
    
}

extension TaskViewController: AddTaskViewControllerDelegate, EditTaskViewControllerDelegate {
    func modalControllerWillDisapear(_ modal: EditPlanViewController) {
        fetchData()
        self.title = chosenPlan?.title
        taskTableView.dragInteractionEnabled = true
//        navigationItem.rightBarButtonItem = editButtonItem

        taskTableView.delegate = self
        taskTableView.dataSource = self
        
    }
    
    func modalControllerWillDisapear(_ modal: AddTaskViewController) {
        // This is called when your modal will disappear. You can reload your data.
        
        
        fetchData()
        self.title = chosenPlan?.title
        taskTableView.dragInteractionEnabled = true
//        navigationItem.rightBarButtonItem = editButtonItem

        taskTableView.delegate = self
        taskTableView.dataSource = self
        
    }
    
  
}
//
//extension TaskViewController : UITableViewDragDelegate {
//
//    /**
//     You have to declare a `UIDragItem` to tell the tableview which object you want to detach from the tableview.
//     This stub will execute when you first click and hold and detach the cell on the tableview
//     */
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        let dragItem = UIDragItem(itemProvider: NSItemProvider())
//        dragItem.localObject = tasks![indexPath.row]
//        return [dragItem]
//    }
//
//
//    /**
//     Tell the tableview the source index and the destination index.
//     This stub will execute when you put the cell on a new position
//     */
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let mv = tasks![sourceIndexPath.row]
//        self.tasks?.remove(at: sourceIndexPath.row)
//        self.tasks?.insert(mv, at: destinationIndexPath.row)
//    }
//
//}
