//
//  TripulateStatisticsDependencyContainer.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 6/26/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI
import TripulateKit

class TripulateStatisticsDependencyContainer {
    
    // MARK: - Properties
    // From parent container
    let sharedConfigurationStore: ConfigurationStore
    let sharedDataStore: DataStore
    
    
    init(appDependencyContainer: TripulateAppDependencyContainer) {
        self.sharedConfigurationStore = appDependencyContainer.sharedConfigurationStore
        self.sharedDataStore = appDependencyContainer.sharedDataStore
    }
    
    func makeStatisticsViewController() -> UIViewController {
        return StatisticsHostingController(rootView: makeStatisticsView())
    }
    
    func makeStatisticsViewModel() -> StatisticsViewModel {
        return StatisticsViewModel(configurationStore: sharedConfigurationStore, dataStore: sharedDataStore)
    }
    
    func makeStatisticsView() -> StatisticsView.WithViewModel {
        return StatisticsView().environmentObject(makeStatisticsViewModel())
    }
}
