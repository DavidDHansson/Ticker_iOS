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
        
        tabBar.tintColor = UIColor.Ticker.mainColorReversed
        
        let homeNVC = UINavigationController(rootViewController: HomeViewController())
        homeNVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "menu-item-myday")?.withRenderingMode(.alwaysTemplate), selectedImage: nil)
        
        let settingsNVC = UINavigationController(rootViewController: SettingsViewController())
        settingsNVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "menu-item-myday")?.withRenderingMode(.alwaysTemplate), selectedImage: nil)
        
        viewControllers = [
            homeNVC,
            settingsNVC
        ]
        
        selectedIndex = 0
    }
    
}

