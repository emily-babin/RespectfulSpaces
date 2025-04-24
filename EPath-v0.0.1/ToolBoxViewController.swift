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
        
        table_Toolbox.separatorStyle = .none
        table_Toolbox.showsVerticalScrollIndicator = false
     
        let navBarAppearance = UINavigationBarAppearance()
        
        //Custom RGB color for BUILD NS
        navBarAppearance.backgroundColor = UIColor(red: 221/255, green: 64/255, blue: 38/255, alpha: 1.0)
        
        //Set title text color
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        //This will ensure the color of the nav bar above does not change when scrolling
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1 // spacing between cells
    }
  

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listToolBoxAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toolbox = listToolBoxAll[indexPath.section]
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
