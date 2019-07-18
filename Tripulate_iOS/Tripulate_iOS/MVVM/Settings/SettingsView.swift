//
//  SettingsView.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    @ObjectBinding var viewModel: SettingsViewModel
    let tripPickerView: TripPickerView.WithViewModel
    let tripSettingsView: TripSettingsView.WithViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Active Trip"),
                    footer: Text("Select the active trip or create a new one").color(.gray)
                ) {
                    NavigationLink(destination: tripPickerView) {
                        HStack {
                            Text("Active Trip")
                            Spacer()
                            Text(viewModel.activeTripName ?? "").color(.secondary)
                        }
                    }
                    
                    NavigationLink(destination: tripSettingsView) {
                        Text("Trip Settings")
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}

//#if DEBUG
//struct SettingsView_Previews : PreviewProvider {
//
//    static var previews: some View {
//        SettingsView(viewModel: (UIApplication.shared.delegate as! AppDelegate).appContainer.makeSettingsViewModel())
//    }
//}
//#endif
