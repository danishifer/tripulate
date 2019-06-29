//
//  TripSettingsView.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 6/29/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct TripSettingsView : View {
    @EnvironmentObject var viewModel: TripSettingsViewModel
    
    var body: some View {
        Form {
            
            TextField(self.$viewModel.name)
            
            
        }
    }
    
    typealias WithViewModel = TripSettingsView.Modified<_EnvironmentKeyWritingModifier<TripSettingsViewModel?>>
}

#if DEBUG
struct TripSettingsView_Previews : PreviewProvider {
    static var previews: some View {
        TripSettingsView()
    }
}
#endif
