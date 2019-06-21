//
//  SceneDelegate.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller
        
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot get AppDelegate")
        }
        
        do {
            let trips = try appDelegate.persistentContainer.viewContext.fetch(request)
            
        } catch {
            fatalError("Error \(error) \(error.localizedDescription)")
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let contentHostingController = UIHostingController(rootView: ContentView())
        
        let expensesNavigationController = UINavigationController(rootViewController: contentHostingController)
        expensesNavigationController.navigationBar.prefersLargeTitles = true
        expensesNavigationController.tabBarItem = UITabBarItem(title: "Expenses", image: UIImage(systemName: "tray.full"), tag: 1)
        
        let statisticsHostingController = UIHostingController(rootView: StatisticsView())
        statisticsHostingController.tabBarItem = UITabBarItem(title: "Statistics", image: UIImage(systemName: "chart.bar"), tag: 0)
        
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Expenses"
        
        contentHostingController.navigationItem.searchController = searchController
        contentHostingController.definesPresentationContext = true
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [statisticsHostingController, expensesNavigationController]
        tabBarController.selectedIndex = 2
        
        window.rootViewController = tabBarController
    
        window.rootViewController = appDelegate.appContainer.makeMainViewController(
            viewControllers: [
                appDelegate.appContainer.makeExpensesViewController(),
                appDelegate.appContainer.makeSettingsViewController()
            ],
            defaultTabIndex: 1
        )
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

