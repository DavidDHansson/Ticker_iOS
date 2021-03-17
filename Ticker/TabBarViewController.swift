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
        tabBar.tintColor = UIColor.Ticker.mainColor
    }

    private func setupTabBar() {
        
        let homeNVC = UINavigationController(rootViewController: HomeViewController())
        homeNVC.tabBarItem = UITabBarItem(title: "Forside", image: UIImage(systemName: "newspaper")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(systemName: "newspaper.fill")?.withRenderingMode(.alwaysTemplate))
        
        let settingsNVC = UINavigationController(rootViewController: SettingsViewController())
        settingsNVC.tabBarItem = UITabBarItem(title: "Indstillinger", image: UIImage(systemName: "gearshape.2")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(systemName: "gearshape.2.fill")?.withRenderingMode(.alwaysTemplate))
        
        viewControllers = [
            homeNVC,
            settingsNVC
        ]
        
        selectedIndex = 0
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        guard item.title == "Forside", selectedIndex == 0 else { return }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scrollToTop"), object: nil, userInfo: nil)
    }
    
}

