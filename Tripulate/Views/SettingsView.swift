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
    
    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("Select the active trip or create a new one").color(.gray)) {
                    NavigationButton(destination: TripPickerView()) {
                        HStack {
                            Text("Trip")
                            Spacer()
                            Text("").color(.secondary)
                        }
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
