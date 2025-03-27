//
//  ToolBoxViewController.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-03-26.
//

import UIKit
import FirebaseFirestore

class ToolBoxViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table_Toolbox: UITableView!

    var selectedToolBox: Int = 0
    let db = Firestore.firestore()
    var selectedItem = ToolBox()
    var listToolBoxAll: [ToolBox] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await loadData()
        }
        
        table_Toolbox.dataSource = self
        table_Toolbox.delegate = self
        
        //This fixes the changing color when the list is not at the end
        tabBarController?.tabBar.barTintColor = .systemBlue
        tabBarController?.tabBar.isTranslucent = false
        

    }
    
    func loadData() async{
        
        do {
            let snapshot = try await db.collection("ToolboxTalks").order(by: "title").getDocuments()
    
          for document in snapshot.documents {
              let title = document.get("title") as? String ?? "No Title"
              //let tag = document.get("tag") as? String ?? "No Tag"
              let tag = "tag"
              //let imageName = document.get("type") as? String ?? "No Image"
              let imageName = "toolbox_placeholder"
              let description = document.get("description") as? String ?? "No Description"
              let content = document.get("text") as? String ?? "No Text"
            
              let toolbox = ToolBox(title:title, tag: tag, imageName:imageName, description:description, content:content)
              listToolBoxAll.append(toolbox)
              
          }
        } catch {
          print("Error getting documents: \(error)")
        }
        
        self.table_Toolbox.reloadData()
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Returns how many items in the array which for now is 5
        return listToolBoxAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toolbox = listToolBoxAll[indexPath.row]
        let cell = table_Toolbox.dequeueReusableCell(withIdentifier: "toolbox_cell", for:indexPath) as! CustomToolBoxTableViewCell
        
        cell.lbl_Title_Toolbox.text = toolbox.title
        cell.lbl_Tag_Toolbox.text = toolbox.description
        cell.iconImageViewToolBox.image = UIImage(named: toolbox.imageName)
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        selectedScenario = indexPath.row
        self.performSegue(withIdentifier: "select_Scenario_Segue", sender: self)
        
    }*/
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "select_Scenario_Segue") {
            
            let ScenariosDetailVC = segue.destination as! ScenariosDetailViewController
            
            ScenariosDetailVC.current_Scenario = listScenarioAll[selectedScenario]
        }
    }*/
}
