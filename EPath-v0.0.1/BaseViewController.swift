//
//  BaseViewController.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-05-13.
//

import UIKit

class BaseViewController: UIViewController, UISearchResultsUpdating {
        
    var searchController: UISearchController!
    var styledSearchBar = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if(!styledSearchBar) {
            searchController.searchBar.searchTextField.textColor = .white
            styledSearchBar = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if(searchController.isActive) {
            searchController.isActive = false
            searchController.searchBar.text = ""
        }
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
    
    func updateSearchResults(for searchController: UISearchController) {
        
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
    
    /*
    @objc
     func bookButtonTapped() {
         
         //Dismiss/hide the search UI immediately
         if searchController.isActive {
           searchController.dismiss(animated: true)
           searchController.searchBar.text = ""
         }
         
        
         //Delay the push to the next run loop
         DispatchQueue.main.async {
             let libraryVC = BookViewController()
             self.navigationController?.pushViewController(libraryVC, animated: false)
         }
     }*/

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
    
    func setupTable(table: UITableView, dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        table.dataSource = dataSource
        table.delegate = delegate
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.keyboardDismissMode = .onDrag
    }
}
