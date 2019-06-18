//
//  AddTrip.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import CoreData

struct AddTrip: View {
    @Environment(\.isPresented) private var isPresented
    @State private var name: String = ""
    @State private var budget: String = ""
    @State private var currency: String = ""
    
    let viewModel = AddTripViewModel()
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField($name, placeholder: Text("Name"))
                    AmountTextField(text: $budget, placeholder: "Budget")
                    Picker(selection: $currency, label: Text("Currency")) {
                        ForEach(self.viewModel.currencies.identified(by: \.code)) { (currency: Currency) in
                            Text(currency.displayName).tag(currency.code)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarItems(
                leading: Button(action: {
                    self.isPresented?.value = false
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                }) {
                    Text("Add")
                }
            )
            .navigationBarItem(title: Text("New Trip"), titleDisplayMode: .inline, hidesBackButton: true)
        }
    }
}

#if DEBUG
struct AddTrip_Previews : PreviewProvider {
    static var previews: some View {
        AddTrip()
    }
}
#endif
