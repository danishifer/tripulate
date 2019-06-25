//
//  TripulateExpensesDependencyContainer.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import TripulateKit
import SwiftUI

class TripulateExpensesDependencyContainer {
    
    // MARK: - Properties
    // From parent container
    let sharedConfigurationStore: ConfigurationStore
    let sharedDataStore: DataStore
    
    // MARK: - Methods
    init(appDependencyContainer: TripulateAppDependencyContainer) {
        self.sharedConfigurationStore = appDependencyContainer.sharedConfigurationStore
        self.sharedDataStore = appDependencyContainer.sharedDataStore
    }
    
    func makeExpensesNavigationController() -> UINavigationController {
        return ExpensesNavigationController(rootViewController: makeExpensesHostingController())
    }
    
    func makeExpensesHostingController() -> UIHostingController<ExpensesView.WithViewModel> {
        return ExpensesHostingController(rootView: makeExpensesView())
    }
    
    func makeAddExpenseViewModel() -> AddExpenseViewModel {
        return AddExpenseViewModel(configurationStore: sharedConfigurationStore, dataStore: sharedDataStore)
    }
    
    func makeAddExpenseView(onDismiss: @escaping () -> Void) -> AddExpenseView.WithViewModel {
        return AddExpenseView(onDismiss: onDismiss).environmentObject(makeAddExpenseViewModel())
    }
    
    func makeExpensesViewModel() -> ExpensesViewModel {
        return ExpensesViewModel(
            configurationStore: sharedConfigurationStore,
            dataStore: sharedDataStore,
            addExpenseViewFactory: self.makeAddExpenseView
        )
    }
    
    func makeExpensesView() -> ExpensesView.WithViewModel {
        return ExpensesView().environmentObject(makeExpensesViewModel())
    }
}
