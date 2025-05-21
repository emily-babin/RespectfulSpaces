//
//  ScenariosViewController.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-03.
//

import UIKit
import FirebaseFirestore
import CoreData
import Network

class ScenariosViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var table: UITableView!
    
    var selectedScenario:Int = 0
    var repository = FirebaseRepository.shared
    var selectedItem = Scenarios()
    var filteredScenarios: [Scenarios] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Find this function in BaseViewController File
        //Setup table design, datasource, delegate
        setupTable(table: table, dataSource: self, delegate: self)
        
        //Adds the data for scenarios
        setupTableData()
    }
    
    func setupTableData() {
        self.filteredScenarios = repository.scenarios
        self.table.reloadData()
    }
    
    /*
    override func setupNavBar() {
        super.setupNavBar()
        // 3. Create the book icon button
        let bookImage = UIImage(systemName: "book.fill")
        let bookButton = UIBarButtonItem(
            image: bookImage,
            style: .plain,
            target: self,
            action: #selector(bookButtonTapped)
        )

        bookButton.tintColor = UIColor.white

        // 4. Add it to the right side of the nav bar
        navigationItem.rightBarButtonItem = bookButton
    }*/
    
    override func updateSearchResults(for searchController: UISearchController) {

        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.isEmpty {
            filteredScenarios = repository.scenarios
            
        } else {
            filteredScenarios = repository.scenarios.filter { scenario in
                let matchesTitle = scenario.title.lowercased().contains(searchText.lowercased())
                
                let matchesTags = scenario.tags.contains { tag in
                    tag.lowercased().contains(searchText.lowercased())
                }
                
                let matchesDesc = scenario.description.lowercased().contains(searchText.lowercased())
                
                return matchesTitle || matchesTags || matchesDesc
            }
        }
        self.table.reloadData()
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
}
