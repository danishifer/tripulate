//
//  TripulateAppDependencyContainer.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI
import TripulateKit
import UserDefaultsConfigurationStore

class TripulateAppDependencyContainer {
    
    // MARK: - Properties
    
    let sharedConfigurationStore: ConfigurationStore
    let sharedDataStore: DataStore

    // MARK: - Methods
    
    init(dataStore: DataStore) {
        func makeConfigurationStore() -> ConfigurationStore {
            return UserDefaultsConfigurationStore()
        }
        
        self.sharedDataStore = dataStore
        self.sharedConfigurationStore = makeConfigurationStore()
    }
    
    func makeRootViewModel() -> RootViewModel {
        return RootViewModel(
            configurationStore: sharedConfigurationStore,
            welcomeViewFactory: self.makeWelcomeView
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
    
    func makeAddTripViewModel() -> AddTripViewModel {
        return AddTripViewModel(dataStore: sharedDataStore, configurationStore: sharedConfigurationStore)
    }
    
    func makeAddTripView(onDismiss: @escaping () -> Void) -> AddTrip.WithViewModel {
        return AddTrip(onDismiss: onDismiss).environmentObject(makeAddTripViewModel())
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        return WelcomeViewModel(addTripViewFactory: self.makeAddTripView)
    }
    
    func makeWelcomeView() -> WelcomeView.WithViewModel {
        return WelcomeView().environmentObject(makeWelcomeViewModel())
    }
    
    func makeStatisticsView() -> StatisticsView {
        return StatisticsView()
    }
    
}
