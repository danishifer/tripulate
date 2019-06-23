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
    @ObjectBinding var viewModel: AddTripViewModel
    @Binding var isPresented: Bool
    
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
                    self.isPresented = false
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                }) {
                    Text("Add")
                }
            )
            .navigationBarTitle(Text("New Trip"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

//#if DEBUG
//struct AddTrip_Previews : PreviewProvider {
//    static var previews: some View {
//        AddTrip(isPresented: .constant(true))
//    }
//}
//#endif
