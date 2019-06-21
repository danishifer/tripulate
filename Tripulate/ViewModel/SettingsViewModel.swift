//
//  SettingsViewModel.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine

class SettingsViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
   
    
    let configurationStore: ConfigurationStore!
    
    init(configurationStore: ConfigurationStore) {
        self.configurationStore = configurationStore
    }
    
    
}
