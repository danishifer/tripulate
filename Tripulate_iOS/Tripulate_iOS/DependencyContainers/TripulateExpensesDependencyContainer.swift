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
    
    
    // MARK: - Methods
    init(appDependencyContainer: TripulateAppDependencyContainer) {
        self.sharedConfigurationStore = appDependencyContainer.sharedConfigurationStore
    }
    
    
    func makeExpensesNavigationController() -> UINavigationController {
        return ExpensesNavigationController(rootViewController: makeExpensesHostingController())
    }
    
    func makeExpensesHostingController() -> UIHostingController<ContentView> {
        return ExpensesHostingController(rootView: makeExpensesView())
    }
    
    func makeExpensesView() -> ContentView {
        return ContentView()
    }
}
