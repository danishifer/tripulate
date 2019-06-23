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
        return RootViewModel(configurationStore: sharedConfigurationStore, welcomeViewFactory: {
            return self.makeWelcomeView()
        })
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
        return AddTripViewModel(dataStore: sharedDataStore)
    }
    
    func makeAddTripView(isPresented: Binding<Bool>) -> AddTrip {
        return AddTrip(viewModel: makeAddTripViewModel(), isPresented: isPresented)
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        return WelcomeViewModel { (isPresented) -> AddTrip in
            return self.makeAddTripView(isPresented: isPresented)
        }
    }
    
    func makeWelcomeView() -> WelcomeView {
        return WelcomeView(viewModel: makeWelcomeViewModel())
    }

    
    func makeStatisticsView() -> StatisticsView {
        return StatisticsView()
    }
    
}
