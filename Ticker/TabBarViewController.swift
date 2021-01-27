//
//  ViewController.swift
//  Ticker
//
//  Created by David Hansson on 27/01/2021.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Tabbar
        setupTabBar()
        
        // Style the Tabbar
        styleTabBar()
        
    }

    private func styleTabBar() {
        
    }

    private func setupTabBar() {
        
        let homeNVC = UINavigationController(rootViewController: HomeViewController())
        homeNVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "menu-item-myday"), selectedImage: nil)
        
        viewControllers = [
            homeNVC
        ]
        
        selectedIndex = 0
    }
    
}

