//
//  TripPickerView.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import TripulateKit

struct TripPickerView : View {
    @State var showAddTripModal = false
    @EnvironmentObject var viewModel: TripPickerViewModel
    
    var body: some View {
        List(viewModel.trips) { (trip: Trip) in
            Button(action: {
                self.viewModel.setActiveTrip(trip: trip)
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(trip.name)
                            .color(.primary)
                        
                        Text(
                            { () -> String in
                                let currency = Currency.from(code: trip.currency)
                                return [
                                    "\(self.viewModel.dateFormatter.string(from: trip.creationDate))",
                                    " • ",
                                    "\(currency?.symbol ?? "")\(trip.budget)",
                                    " ",
                                    "\(currency?.code.uppercased() ?? "")",
                                ].joined()
                            }()
                        )
                            .font(.caption)
                            .color(.secondary)
                    }
                    Spacer()
                    if (self.viewModel.activeTripId == trip.persistentID) {
                        Image(systemName: "checkmark").foregroundColor(.accentColor)
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle(Text("Active Trip"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.viewModel.showAddTripModal.toggle()
        }) {
            Image(systemName: "plus")
        })
        .presentation(viewModel.showAddTripModal ? Modal(viewModel.addTripView, onDismiss: {
            self.viewModel.showAddTripModal = false
        }) : nil)
    }
    
    typealias WithViewModel = TripPickerView.Modified<_EnvironmentKeyWritingModifier<TripPickerViewModel?>>
}

#if DEBUG
struct TripPickerView_Previews : PreviewProvider {
    static var previews: some View {
        TripPickerView()
    }
}
#endif
