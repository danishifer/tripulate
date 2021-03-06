//
//  RootViewModel.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import TripulateKit

class RootViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    var configurationStore: ConfigurationStore
    let welcomeViewFactory: () -> WelcomeView.WithViewModel
    
    init(
        configurationStore: ConfigurationStore,
        welcomeViewFactory: @escaping () -> WelcomeView.WithViewModel
    ) {
        self.configurationStore = configurationStore
        self.welcomeViewFactory = welcomeViewFactory
        
        let _ = NotificationCenter.default.publisher(for: .activeTripDidChange)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.didChange.send(())
            }
    }
    
    var showWelcomeView: Bool {
        get {
            return (
                self.configurationStore.activeTripID == nil
            )
        }
    }
}
