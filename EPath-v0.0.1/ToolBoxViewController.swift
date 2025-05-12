//
//  ToolBoxViewController.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-03-26.
//

import UIKit

class ToolBoxViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var table_Toolbox: UITableView!

    var selectedToolBox: Int = 0
    var selectedItem = ToolBox()
    var repository = FirebaseRepository.shared
    var filteredToolBox: [ToolBox] = []
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupNavBar()
    }
    
    func setupTable() {
        table_Toolbox.dataSource = self
        table_Toolbox.delegate = self
        table_Toolbox.keyboardDismissMode = .onDrag
        
        self.filteredToolBox = repository.toolBox
        self.table_Toolbox.reloadData()
    }
    
    func setupNavBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        
        //Custom RGB color for BUILD NS
        navBarAppearance.backgroundColor = UIColor(red: 221/255, green: 64/255, blue: 38/255, alpha: 1.0)
        
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
        let tabBarAppearance = UITabBarAppearance()
        
        //Customer RGB color for BUILDNS
        tabBarAppearance.backgroundColor = UIColor(red: 221/255, green: 64/255, blue: 38/255, alpha: 1.0)
        
        //This will ensure the color of the tab bar stays the same and does not change when scrolling
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedToolBox = indexPath.section
        self.performSegue(withIdentifier: "select_ToolBox_Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "select_ToolBox_Segue") {
            
            let ToolBoxDetailVC = segue.destination as! ToolBoxDetailsViewController
            
            // Set the back button title before pushing the new view controller
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: filteredToolBox[selectedToolBox].title, style: .plain, target: nil, action: nil)
            
            ToolBoxDetailVC.current_ToolBox = filteredToolBox[selectedToolBox]
        }
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
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.isEmpty {
            filteredToolBox = repository.toolBox
            self.table_Toolbox.reloadData()
            
        } else {
            filteredToolBox = repository.toolBox.filter { toolbox in
                let matchesTitle = toolbox.title.lowercased().contains(searchText.lowercased())
                let matchesTags = toolbox.content.contains { tag in
                    tag.lowercased().contains(searchText.lowercased())
                }
                let matchesDesc = toolbox.description.lowercased().contains(searchText.lowercased())
                
                return matchesTitle || matchesTags || matchesDesc
            }
            table_Toolbox.reloadData()
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
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredToolBox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toolbox = filteredToolBox[indexPath.section]
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
    
    
   
}
