//
//  SettingsView.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("Select the active trip or create a new one").color(.gray)) {
                    NavigationButton(destination: TripPickerView()) {
                        HStack {
                            Text("Trip")
                            Spacer()
                            Text("Hawaii 2019").color(.secondary)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle(Text("Settings"))
        }
    }
}

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
