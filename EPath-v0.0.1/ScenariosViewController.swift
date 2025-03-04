//
//  ScenariosViewController.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-03.
//

import UIKit

class ScenariosViewController: UIViewController , UITableViewDataSource {
    
  
    @IBOutlet weak var table: UITableView!
    
    struct Scenarios {
        let title:String
        let tag:String
        let imageName:String
    }
    
    let data: [Scenarios] = [
        Scenarios(title: "Scenario 1 - DB", tag: "Tags: Action", imageName: "DB"),
        Scenarios(title: "Scenario 2 - Mr. Huang's Dilemma", tag: "Tags: Racism", imageName: "RACISM"),
        Scenarios(title: "Scenario 3 - Peter's Sunday", tag: "Tags: Religion", imageName: "RELIGION"),
        Scenarios(title: "Scenario 4 - Team 4D's Teamwork", tag: "Tags: Respect", imageName: "WORKPLACE"),
        Scenarios(title: "Scenario 5 - Three Minions, One Heart", tag: "Tags: Empathy", imageName: "MINIONS")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
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
        self.performSegue(withIdentifier: "select_Scenario", sender: self)
    }
}
