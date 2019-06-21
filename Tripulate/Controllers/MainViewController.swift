//
//  MainViewController.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct MainViewController: UIViewControllerRepresentable {
    let viewControllers: [UIViewController]
    let defaultTabIndex: Int
    
    init(viewControllers: [UIViewController], defaultTabIndex: Int = 0) {
        self.viewControllers = viewControllers
        self.defaultTabIndex = defaultTabIndex
    }
    
    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedIndex = defaultTabIndex
        return tabBarController
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        
    }
}
