//
//  TripulateAppDependencyContainer.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI

class TripulateAppDependencyContainer {
    
    // MARK: - Properties
    
    let sharedConfigurationStore: ConfigurationStore

    // MARK: - Methods
    
    init() {
        func makeConfigurationStore() -> ConfigurationStore {
            return UserDefaultsConfigurationStore()
        }
        
        let configurationStore = makeConfigurationStore()
        self.sharedConfigurationStore = configurationStore
    }
    
    func makeMainViewController(
        viewControllers: [UIViewController],
        defaultTabIndex: Int = 0
    ) -> MainViewController {
        return MainViewController(
            viewControllers: viewControllers,
            defaultTabIndex: defaultTabIndex,
            welcomeViewFactory: {
                return self.makeWelcomeView()
            }
        )
    }
    
    func makeExpensesViewController() -> UIViewController {
        let expensesDependencyContainer = TripulateExpensesDependencyContainer(appDependencyContainer: self)
        return expensesDependencyContainer.makeExpensesNavigationController()
    }
    
    func makeSettingsViewController() -> UIViewController {
        let settingsDependecyContainer = TripulateSettingsDependencyContainer(appDependencyContainer: self)
        return settingsDependecyContainer.makeSettingsHostingController()
    }
    
    func makeWelcomeView() -> WelcomeView {
        return WelcomeView()
    }

    
    func makeStatisticsView() -> StatisticsView {
        return StatisticsView()
    }
    
}
