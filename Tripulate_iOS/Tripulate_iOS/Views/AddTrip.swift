//
//  AddTrip.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import CoreData
import TripulateKit

struct AddTrip: View {
    @EnvironmentObject var viewModel: AddTripViewModel
    let onDismiss: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField($viewModel.name, placeholder: Text("Name"))
                AmountTextField(text: $viewModel.budget, placeholder: "Budget")
                Picker(selection: $viewModel.currency, label: Text("Currency")) {
                    ForEach(self.viewModel.currencies.identified(by: \.code)) { (currency: Currency) in
                        Text(currency.displayName).tag(currency.code)
                    }
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    self.onDismiss()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    if self.viewModel.addTrip() {
                        self.onDismiss()
                    } else {
                        print("Couldn't add trip")
                    }
                }) {
                    Text("Add")
                }
            )
            .navigationBarTitle(Text("New Trip"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    typealias WithViewModel = AddTrip.Modified<_EnvironmentKeyWritingModifier<AddTripViewModel?>>
}


//#if DEBUG
//struct AddTrip_Previews : PreviewProvider {
//    static var previews: some View {
//        AddTrip(isPresented: .constant(true))
//    }
//}
//#endif
