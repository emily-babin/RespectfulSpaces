//
//  BaseViewController.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-05-13.
//

import UIKit

class BaseViewController: UIViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        <#code#>
    }
    
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initSearchController() {
        
        //searchResultsController: nil means the search results will be shown in the same view controller, not a separate one.
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        
        if let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                
            searchBarTextField.backgroundColor = UIColor.white.withAlphaComponent(0.10)
            searchBarTextField.layer.cornerRadius = 8
            searchBarTextField.clipsToBounds = true
            
            let glassIconView = searchBarTextField.leftView as! UIImageView
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .white
            
            // Set placeholder color
            searchBarTextField.attributedPlaceholder = NSAttributedString(
                string: "Search",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
            )
        }

       
        //WHITE TINT FOR CANCEL
        searchController.searchBar.tintColor = .white
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
