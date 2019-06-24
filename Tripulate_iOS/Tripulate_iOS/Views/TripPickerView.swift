//
//  TripPickerView.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct TripPickerView : View {
    @State var showAddTripModal = false
    
    private let trips = ["London 2019", "San Francisco 2020"]
    
    var body: some View {
        List(trips.identified(by: \.self)) { name in
            Button(action: {}) {
                HStack {
                    Text(name).color(.primary)
                    Spacer()
                    if true {
                        Image(systemName: "checkmark").foregroundColor(.accentColor)
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle(Text("Active Trip"), displayMode: .inline)
//        .navigationBarItems(trailing: PresentationButton(destination: AddTrip(isPresented: $showAddTripModal)) {
//            Image(systemName: "plus")
//        })
    }
}

#if DEBUG
struct TripPickerView_Previews : PreviewProvider {
    static var previews: some View {
        TripPickerView()
    }
}
#endif
