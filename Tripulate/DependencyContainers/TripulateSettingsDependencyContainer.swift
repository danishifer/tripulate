//
//  TripulateSettingsDependencyContainer.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI

class TripulateSettingsDependencyContainer {
    
    // MARK: - Properties
    // From parent container
    let sharedConfigurationStore: ConfigurationStore
    let sharedDataStore: DataStore
    
    // MARK: - Methods
    init(appDependencyContainer: TripulateAppDependencyContainer) {
        self.sharedConfigurationStore = appDependencyContainer.sharedConfigurationStore
        self.sharedDataStore = appDependencyContainer.sharedDataStore
    }
    
    func makeSettingsHostingController() -> UIHostingController<SettingsView> {
        return SettingsHostingController(rootView: makeSettingsView())
    }
    
    func makeSettingsView() -> SettingsView {
        return SettingsView(viewModel: makeSettingsViewModel())
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel.init(dataStore: sharedDataStore, configurationStore: sharedConfigurationStore)
    }
}
