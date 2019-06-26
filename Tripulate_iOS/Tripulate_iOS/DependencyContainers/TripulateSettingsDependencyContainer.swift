//
//  TripulateSettingsDependencyContainer.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI
import TripulateKit

class TripulateSettingsDependencyContainer {
    
    // MARK: - Properties
    // From parent container
    let sharedConfigurationStore: ConfigurationStore
    let sharedDataStore: DataStore
    let addTripViewFactory: (@escaping () -> Void) -> AddTrip.WithViewModel
    
    // MARK: - Methods
    init(appDependencyContainer: TripulateAppDependencyContainer) {
        self.sharedConfigurationStore = appDependencyContainer.sharedConfigurationStore
        self.sharedDataStore = appDependencyContainer.sharedDataStore
        self.addTripViewFactory = appDependencyContainer.makeAddTripView
    }
    
    func makeSettingsHostingController() -> UIHostingController<SettingsView> {
        return SettingsHostingController(rootView: makeSettingsView())
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel.init(dataStore: sharedDataStore, configurationStore: sharedConfigurationStore)
    }
    
    func makeSettingsView() -> SettingsView {
        return SettingsView(viewModel: makeSettingsViewModel(), tripPickerView: makeTripPickerView())
    }
    
    func makeTripPickerViewModel() -> TripPickerViewModel {
        return TripPickerViewModel(
            configurationStore: sharedConfigurationStore,
            dataStore: sharedDataStore,
            addTripViewFactory: addTripViewFactory
        )
    }
    
    func makeTripPickerView() -> TripPickerView.WithViewModel {
        return TripPickerView().environmentObject(makeTripPickerViewModel())
    }
}
