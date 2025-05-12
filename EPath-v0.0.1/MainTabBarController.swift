//
//  TabBarController.swift
//  EPath-v0.0.1
//
//  Created by Emily Babin on 2025-02-21.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var lastSelectedIndex = 0
    var repository = FirebaseRepository.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRepo()
        setupTabBar()
        setupNavBar()
    }
    
    func setupRepo() {
        self.repository.startAll {
            print("repo started")
        }
    }
    
    func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(red: 222/255, green: 61/255, blue: 38/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = .white
        delegate = self
    }
    
    func setupNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(red: 222/255, green: 61/255, blue: 38/255, alpha: 1.0)

        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        //if the view controller is a nav controller then proceed with the function
        //if not then return and stop the function as we do not need to do anything 
        guard let navController = viewController as? UINavigationController else { return }

        if selectedIndex == lastSelectedIndex {
            //Re-tapping same tab
            navController.popToRootViewController(animated: true)
        } else {
            //Switched back from another tab
            navController.popToRootViewController(animated: true)
        }

        lastSelectedIndex = selectedIndex
    }
}
