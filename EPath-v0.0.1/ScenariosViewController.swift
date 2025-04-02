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
    var filteredScenarios: [Scenarios] = []
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        Task {
            await loadData()
        }
        
        table.dataSource = self
        table.delegate = self
        
        //Fix Navigation Bar Color Change Issue
        //Initialize a Appearance object which will hold all the design changes for the navBar
        let navBarAppearance = UINavigationBarAppearance()
        
        //Custom RGB color for BUILD NS
        navBarAppearance.backgroundColor = UIColor(red: 221/255, green: 64/255, blue: 38/255, alpha: 1.0)
        
        //Set title text color
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]		

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        //This will ensure the color of the nav bar above does not change when scrolling
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        //Fix Tab Bar Color Change Issue
        let tabBarAppearance = UITabBarAppearance()
        
        //Same RGB color for consistency
        tabBarAppearance.backgroundColor = UIColor(red: 221/255, green: 64/255, blue: 38/255, alpha: 1.0)
        
        //Create UITabBarItemAppearance to customize the item appearance
        let itemAppearance = UITabBarItemAppearance()

        //Change the unselected item color
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] // For normal (unselected) text
        itemAppearance.normal.iconColor = UIColor.white // For normal (unselected) icon

        //Change the selected item color
        //For selected text
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        itemAppearance.selected.iconColor = UIColor.white // For selected icon

        //Apply the itemAppearance to the standard appearance
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance

        
        //This adds all the changes above
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        
        //This will ensure the color of the tab bar does not change when scrolling
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        //initSearchController()
    }
    
    //SEARCH BAR
    /*func updateSearchResults(for searchController: UISearchController) {
        <#code#>
    }
    
    func initSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.scopeButtonTitles = ["All", "Scenarios", "Perspective"]
        searchController.searchBar.delegate = self
    }*/
    
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
