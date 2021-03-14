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
        tabBar.tintColor = UIColor.Ticker.mainColorReversed
    }

    private func setupTabBar() {
        
        let homeNVC = UINavigationController(rootViewController: HomeViewController())
        homeNVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "tv")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(systemName: "tv.fill")?.withRenderingMode(.alwaysTemplate))
        
        let settingsNVC = UINavigationController(rootViewController: SettingsViewController())
        settingsNVC.tabBarItem = UITabBarItem(title: "Min Profil", image: UIImage(systemName: "person")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysTemplate))
        
        viewControllers = [
            homeNVC,
            settingsNVC
        ]
        
        selectedIndex = 0
    }
    
}

