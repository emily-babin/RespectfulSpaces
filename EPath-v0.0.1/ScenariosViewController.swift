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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await loadData()
        }
        table.dataSource = self
        table.delegate = self
        
        //This fixes the changing color when the list is not at the end
        tabBarController?.tabBar.barTintColor = .systemBlue
        tabBarController?.tabBar.isTranslucent = false
        

    }
    
    func loadData() async{
        
        do {
            let snapshot = try await db.collection("Scenarios").order(by: "title").getDocuments()
    
          for document in snapshot.documents {
              let title = document.get("title") as? String ?? "No Title"
              let tag = document.get("tag") as? String ?? "No Tag"
              let imageName = document.get("type") as? String ?? "No Image"
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
        cell.lbl_Tag.text = scenarios.description
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
