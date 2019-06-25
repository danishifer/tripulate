//
//  SettingsViewModel.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import TripulateKit

class SettingsViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    let configurationStore: ConfigurationStore
    let dataStore: DataStore
    
    init(dataStore: DataStore, configurationStore: ConfigurationStore) {
        self.dataStore = dataStore
        self.configurationStore = configurationStore
        
        let _ = NotificationCenter.default.publisher(for: .activeTripDidChange)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                self.didChange.send(())
            })
        
    }
    
    
    var activeTripName: String? {
        get {
            guard let activeTripID = configurationStore.activeTripID else {
                return nil
            }
            
            return dataStore.getTrip(byID: activeTripID)?.name
        }
    }
    
}
