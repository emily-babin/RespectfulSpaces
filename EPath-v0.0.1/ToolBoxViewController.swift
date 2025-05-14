//
//  ToolBoxViewController.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-03-26.
//

import UIKit

class ToolBoxViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table_Toolbox: UITableView!

    var selectedToolBox: Int = 0
    var selectedItem = ToolBox()
    var repository = FirebaseRepository.shared
    var filteredToolBox: [ToolBox] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Find this function in BaseViewController File
        //Setup table design, datasource, delegate
        setupTable(table: table_Toolbox, dataSource: self, delegate: self)
        
        //Adds the data for scenarios
        setupTableData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //This calls the function in base that will remove the text in the search bar if there is any and de activates the searchbar
        super.viewDidDisappear(animated)
    }

    func setupTableData() {
        self.filteredToolBox = repository.toolBox
        self.table_Toolbox.reloadData()
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        
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
}
