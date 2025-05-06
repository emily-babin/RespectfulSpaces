//
//  ScenariosViewController.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-03.
//

import UIKit
import FirebaseFirestore

class ScenariosViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

        
    @IBOutlet weak var table: UITableView!
    
    var selectedScenario:Int = 0
    let db = Firestore.firestore()
    var selectedItem = Scenarios()
    var listScenarioAll: [Scenarios] = []
    var filteredScenarios: [Scenarios] = []
    
    var searchController = UISearchController()
    
    private var scenariosListener: ListenerRegistration?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTable()
        setupNavBar()
        setupTabBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scenariosListener?.remove()
    }
    
    func setupTable() {
        attachRealtimeListener()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.keyboardDismissMode = .onDrag
    }
    
    func initSearchController() {
       
        //searchResultsController: nil means the search results will be shown in the same view controller, not a separate one.
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        //Assigns the current view controller (self) as the object that responds to search updates.
        searchController.searchResultsUpdater = self
        
        //Places the search bar in the navigation bar of the view controller.
        navigationItem.searchController = searchController
        
        //This line keeps the search bar always visible
        navigationItem.hidesSearchBarWhenScrolling = false
       
        // Assign the search controller to the navigation item
        navigationItem.searchController = searchController
       
        // Ensure the context is defined to prevent weird UI behavior
        definesPresentationContext = true
    }
    
    func attachRealtimeListener() {
      //detach any existing listener
      scenariosListener?.remove()

      scenariosListener = db.collection("Scenarios").order(by: "title").addSnapshotListener { [weak self] snapshot, error in
          guard let self = self, let snapshot = snapshot else {
            print("Listener error:", error ?? "unknown")
            return
          }
              // rebuild local array
              self.listScenarioAll = snapshot.documents.map { doc in
                Scenarios(
                  title: doc.get("title") as? String ?? "No Title",
                  imageName: doc.get("type") as? String ?? "EMPATHY",
                  description: doc.get("description") as? String ?? "No Description",
                  content: doc.get("content") as? String ?? "No content",
                  commonResponse: doc.get("common") as? String ?? "No Response",
                  facts: doc.get("facts") as? String ?? "No Facts",
                  tags: doc.get("tag") as? [String] ?? []
                )
              }

              // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                 self.updateSearchResults(for: self.searchController)
            }
        }
    }
    
    /*func loadData() async{
        
        do {
            let snapshot = try await db.collection("Scenarios").order(by: "title").getDocuments()
    
          for document in snapshot.documents {
              let title = document.get("title") as? String ?? "No Title"
              
              //let tag = document.get("tag") as? String ?? "No Tag"
              let imageName = document.get("type") as? String ?? "EMPATHY"
              let description = document.get("description") as? String ?? "No Description"
              let content = document.get("content") as? String ?? "No Content"
            
              let commonResponse = document.get("common") as? String ?? "No Response"
              
              let facts = document.get("facts") as? String ?? "No Facts"
              
              let tags = document.get("tag") as? [String] ?? []

              let Scenario = Scenarios(title:title, imageName:imageName, description:description, content:content, commonResponse: commonResponse, facts: facts, tags: tags)
              
              listScenarioAll.append(Scenario)
          }
            
        } catch {
          print("Error getting documents: \(error)")
        }
        
        filteredScenarios = listScenarioAll

        self.table.reloadData()
    }*/
    
  
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.isEmpty {
            filteredScenarios = listScenarioAll
            self.table.reloadData()
            
        } else {
            filteredScenarios = listScenarioAll.filter { scenario in
                let matchesTitle = scenario.title.lowercased().contains(searchText.lowercased())
                let matchesTags = scenario.tags.contains { tag in
                    tag.lowercased().contains(searchText.lowercased())
                }
                return matchesTitle || matchesTags
            }
            self.table.reloadData()
        }
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
        
        //Returns how many items in the array which for now is 5
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredScenarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let scenarios = filteredScenarios[indexPath.section]
        let cell = table.dequeueReusableCell(withIdentifier: "scenario_cell", for:indexPath) as! CustomTableViewCell
        
        cell.lbl_Title.text = scenarios.title
        cell.lbl_Tag.text = scenarios.description
        cell.iconImageView.image = UIImage(named: scenarios.imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        selectedScenario = indexPath.section
        self.performSegue(withIdentifier: "select_Scenario_Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "select_Scenario_Segue") {
            
            let ScenariosDetailVC = segue.destination as! ScenariosDetailViewController
            
            ScenariosDetailVC.current_Scenario = filteredScenarios[selectedScenario]
        }
    }
    
    
    func setupNavBar() {
        //Fix Navigation Bar Color Change Issue
        //Initialize a Appearance object which will hold all the design changes for the navBar
        let navBarAppearance = UINavigationBarAppearance()
        
        //Custom RGB color for BUILD NS
        navBarAppearance.backgroundColor = UIColor(red: 222/255, green: 61/255, blue: 38/255, alpha: 1.0)
        
        //Set title text color
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        //This will ensure the color of the nav bar above does not change when scrolling
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        //This changes the color of the back button up in navigationw
        navigationController?.navigationBar.tintColor = UIColor.white
        
        initSearchController()
    }

    func setupTabBar() {
        
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
        itemAppearance.selected.iconColor = UIColor.white // For selected icon*/

        //Apply the itemAppearance to the standard appearance
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance

        //This adds all the changes above
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
       
        //This will ensure the color of the tab bar does not change when scrolling
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
