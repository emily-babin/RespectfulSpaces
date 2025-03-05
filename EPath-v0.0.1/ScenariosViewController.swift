//
//  ScenariosViewController.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-03.
//

import UIKit

class ScenariosViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
  
    @IBOutlet weak var table: UITableView!
    
    var selectedScenario:Int = 0
    
    let data: [Scenarios] = [
        Scenarios(title: "Scenario 1 - DB", tag: "Tags: Action", imageName: "DB", description: ""),
        
        Scenarios(title: "Scenario 2 - Mr. Huang's Dilemma", tag: "Tags: Racism", imageName: "RACISM", description: "Huang, a skilled electrician, has years of experience and a strong work ethic, but he notices that his supervisor, Dave, consistently assigns him the toughest, least desirable tasks while giving easier jobs to less experienced workers. Huang, the only Chinese tradesperson on the crew, also overhears coworkers making racially insensitive jokes, and when he speaks up, he's told to \"toughen up\" and \"not take things so seriously.\" Despite his qualifications, Huang is repeatedly passed over for leadership opportunities, while others with less experience move up quickly."),
        
        Scenarios(title: "Scenario 3 - Peter's Sunday", tag: "Tags: Religion", imageName: "RELIGION", description: ""),
        
        Scenarios(title: "Scenario 4 - Team 4D's Teamwork", tag: "Tags: Respect", imageName: "WORKPLACE", description: ""),
        
        Scenarios(title: "Scenario 5 - Three Minions, One Heart", tag: "Tags: Empathy", imageName: "EMPATHY", description: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Returns how many items in the array which for now is 5
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Scenarios = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "scenario_cell", for:indexPath) as! CustomTableViewCell
        cell.lbl_Title.text = Scenarios.title
        cell.lbl_Tag.text = Scenarios.tag
        cell.iconImageView.image = UIImage(named: Scenarios.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedScenario = indexPath.row
        self.performSegue(withIdentifier: "select_Scenario_Segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "select_Scenario_Segue") {
            
            let ScenariosDetailVC = segue.destination as! ScenariosDetailViewController
            
            ScenariosDetailVC.current_Scenario = data[selectedScenario]
        }
    }
}
