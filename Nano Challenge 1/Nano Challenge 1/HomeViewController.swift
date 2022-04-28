//
//  HomeViewController.swift
//  Nano Challenge 1
//
//  Created by Jonathan Andryana on 28/04/22.
//

import UIKit

class HomeViewController: UIViewController{
    
    var plans = ["Work", "Groceries", "School", "Workout", "Family", "Friends", "Medical", "Do Project"]


    var pageTitle : String!
    
    
    @IBOutlet weak var todayTitle: UILabel!
  
    @IBOutlet weak var planTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        planTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func todayButtonPressed(_ sender: UIButton) {
        pageTitle = "Today"
        performSegue(withIdentifier: "toTaskPage", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskPage" {
            let taskVC = segue.destination as? TaskViewController
            taskVC?.title = pageTitle
            
            
            // since we already subscribe the delegate from second page, we need to connect it to here
//            taskVC?.delegate = self
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

}

extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = planTableView.dequeueReusableCell(withIdentifier: "planCell") as! PlanTableViewCell
        
        let plan = plans[indexPath.row]
        cell.planTitle.text = plan
        
        return cell
    }
    
    
}
