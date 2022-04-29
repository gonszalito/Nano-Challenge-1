//
//  HomeViewController.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

protocol ModalViewControllerDelegate : AnyObject {
    func modalControllerWillDisapear(_ modal: AddPlanViewController)
}

class HomeViewController: UIViewController{
    
//    var plans = ["Work", "Groceries", "School", "Workout", "Family", "Friends", "Medical", "Do Project"]

    @IBOutlet weak var scheduledNoTasks: UILabel!
    @IBOutlet weak var tommorowNoTasks: UILabel!
    @IBOutlet weak var todayNoTasks: UILabel!
    
    
    var chosenPlan : Plan?
    var chosenIndex : Int?
    var todayPlan : Plan?
    var tommorowPlan : Plan?
    var scheduledPlan : Plan?
    var checkStart = true
    
    var pageTitle : String!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var plans: [Plan]?
    
    @IBOutlet weak var todayTitle: UILabel!
  
    @IBOutlet weak var planTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadOnce()
        let df = DateFormatter()
        df.dateFormat = "E, dd-MMM-yyyy"
        let dateString = df.string(from: Date())
        self.title = "My Plans"
        navigationController?.navigationBar.prefersLargeTitles = true
        

    }
    
//    func loadOnce () {
//        if checkStart == true {
//            let newContainer = PlanHolder(context: self.context)
//            newContainer.title = "initial"
//            let newPlan = Plan(context: self.context)
//            newPlan.title = "Do Now"
//            newPlan.noTasks = 0
//
//            newContainer.addToPlans(newPlan)
//            // Save the data
//            do {
//                try
//
//                self.context.save()
//            } catch {
//                print(error)
//            }
//
//            self.checkStart = false
//        }
//    }
//
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        
        planTableView.dragInteractionEnabled = true
//        navigationItem.rightBarButtonItem = editButtonItem
    
        planTableView.delegate = self
        planTableView.dataSource = self
//        planTableView.dragDelegate = self
        
    }
    
    // delegate
    private func presentModalController() {
        let modal = AddPlanViewController()
        modal.delegate = self
        self.present(modal, animated: true)
    }
    
    func fetchData() {
        
        // Fetch the data from Core Data to display in the tableView
        do {
            self.plans = try context.fetch(Plan.fetchRequest())
            DispatchQueue.main.async {
                self.planTableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    
    
    @IBAction func todayButtonPressed(_ sender: UIButton) {
        pageTitle = "Do Now"
        performSegue(withIdentifier: "toDoNowPage", sender: self)
    }
    
    @IBAction func tommorowButtonPressed(_ sender: UIButton) {
        pageTitle = "Tommorow"
        self.chosenPlan = self.tommorowPlan
        performSegue(withIdentifier: "toTaskPage", sender: self)
    }
    
    @IBAction func scheduledButtonPressed(_ sender: UIButton) {
        pageTitle = "Scheduled"
        self.chosenPlan = self.scheduledPlan
        performSegue(withIdentifier: "toTaskPage", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskPage" {
            let taskVC = segue.destination as? TaskViewController
            taskVC?.chosenPlan = self.chosenPlan
            taskVC?.title = pageTitle
            taskVC?.chosenIndex = self.chosenIndex
        }
        
        if segue.identifier == "toDoNowPage" {
            let taskVC = segue.destination as? TaskViewController
            taskVC?.chosenPlan = self.chosenPlan
            taskVC?.title = pageTitle
            taskVC?.chosenIndex = self.chosenIndex
            
        }
        
        switch (segue.identifier, segue.destination) {
            // Check that the segue identifer matches and destination controller is a ModalViewController
        case ("toAddPlan", let destination as AddPlanViewController):
            
            destination.delegate = self
        case _:
            break
        }

    }
    
    
    
    @IBAction func addPlanButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddPlan", sender: self)
    }
    

}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plans?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "planCell") as! PlanTableViewCell
        
        // Get person from array and set the label
        let plan = self.plans![indexPath.row]
        
        
        cell.planNoTasks.text = String(plan.noTasks)
        cell.planTitle.text = plan.title
        
        return cell
    }
    
    //Click on cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let plan = self.plans![indexPath.row]
        self.chosenPlan = plan
        self.chosenIndex = indexPath.row
        pageTitle = plan.title
        performSegue(withIdentifier: "toTaskPage", sender: self)
        // Put logic here
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Which person to remove
            let plans = self.plans![indexPath.row]
            
            // Remove the person
            self.context.delete(plans)
            
            // Save the data
            do {
                try self.context.save()
            } catch {
                
            }
   
            // Re-fetch the data
            self.fetchData()
        }
        
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

// Refresh Page after modal dismisses
extension HomeViewController: ModalViewControllerDelegate {
    func modalControllerWillDisapear(_ modal: AddPlanViewController) {
        // This is called when your modal will disappear. You can reload your data.
        fetchData()
        
        planTableView.dragInteractionEnabled = true
//        navigationItem.rightBarButtonItem = editButtonItem

        planTableView.delegate = self
        planTableView.dataSource = self
    }
    
    
}
//
//extension HomeViewController : UITableViewDragDelegate {
//
//    /**
//     You have to declare a `UIDragItem` to tell the tableview which object you want to detach from the tableview.
//     This stub will execute when you first click and hold and detach the cell on the tableview
//     */
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        let dragItem = UIDragItem(itemProvider: NSItemProvider())
//        dragItem.localObject = plans![indexPath.row]
//        return [dragItem]
//    }
//
//
//    /**
//     Tell the tableview the source index and the destination index.
//     This stub will execute when you put the cell on a new position
//     */
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let mv = plans![sourceIndexPath.row]
//        self.plans?.remove(at: sourceIndexPath.row)
//        self.plans?.insert(mv, at: destinationIndexPath.row)
//
//    }
//
//}
