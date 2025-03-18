//
//  ScenariosViewController.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-03.
//

import UIKit
import FirebaseFirestore

class ScenariosViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
  
    @IBOutlet weak var table: UITableView!
    
    var selectedScenario:Int = 0
    let db = Firestore.firestore()
    var selectedItem = Scenarios()
    var listScenarioAll: [Scenarios] = []

    /*let data: [Scenarios] = [
        Scenarios(title: "DB", tag: "Tags: Action", imageName: "DB", description: ""),
        
        Scenarios(title: "Mr. Huang's Dilemma", tag: "Tags: Racism", imageName: "RACISM", description: "Huang, a skilled electrician, has years of experience and a strong work ethic, but he notices that his supervisor, Dave, consistently assigns him the toughest, least desirable tasks while giving easier jobs to less experienced workers. \nHuang, the only Chinese tradesperson on the crew, also overhears coworkers making racially insensitive jokes, and when he speaks up, he's told to \"toughen up\" and \"not take things so seriously.\" Despite his qualifications, Huang is repeatedly passed over for leadership opportunities, while others with less experience move up quickly."),
        
        Scenarios(title: "Peter's Sunday", tag: "Tags: Religion", imageName: "RELIGION", description: ""),
        
        Scenarios(title: "Team 4D's Teamwork", tag: "Tags: Respect", imageName: "WORKPLACE", description: ""),
        
        Scenarios(title: "Three Minions", tag: "Tags: Empathy", imageName: "EMPATHY", description: "")
    ]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await loadData()
        }
        table.dataSource = self
        table.delegate = self
        
    }
    
    //remove month
    //replace with desc tag and imageName
    func loadData() async{
        
        do {
            let snapshot = try await db.collection("Scenarios").order(by: "month").getDocuments()
    
          for document in snapshot.documents {
              let title = document.get("title") as? String ?? "No Title"
              let tag = document.get("tag") as? String ?? "No Tag"
              let imageName = document.get("imageName") as? String ?? "No Image"
              let description = document.get("description") as? String ?? "No Description"
              let content = document.get("content") as? String ?? "No Content"
            
              let Scenario = Scenarios(title:title, tag: tag, imageName:imageName, description:description, content:content)
              listScenarioAll.append(Scenario)
              
          }
        } catch {
          print("Error getting documents: \(error)")
        }
        
        self.table.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Returns how many items in the array which for now is 5
        return listScenarioAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let scenarios = listScenarioAll[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "scenario_cell", for:indexPath) as! CustomTableViewCell
        
        cell.lbl_Title.text = scenarios.title
        cell.lbl_Tag.text = scenarios.tag
        cell.iconImageView.image = UIImage(named: scenarios.imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        selectedScenario = indexPath.row
        self.performSegue(withIdentifier: "select_Scenario_Segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "select_Scenario_Segue") {
            
            let ScenariosDetailVC = segue.destination as! ScenariosDetailViewController
            
            ScenariosDetailVC.current_Scenario = listScenarioAll[selectedScenario]
        }
    }
}
