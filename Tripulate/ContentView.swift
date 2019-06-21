//
//  ContentView.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {
//    @ObjectBinding var viewModel: AddTripViewModel
    @State private var selectedCategory = 0
    
    var body: some View {
        Text("Hello, World")
//        List {
//            Section {
//                TextField($viewModel.name, placeholder: Text("Name"))
//                AmountTextField(text: $viewModel.budget, placeholder: "Budget")
//                Picker(selection: $selectedCategory, label: Text("Category")) {
//                    Text("Hello").tag(0)
//                    Text("World").tag(1)
//                }
//            }
//        }
//        .listStyle(.grouped)
        .navigationBarTitle(Text("Expenses"))
//        .presentation(Modal(WelcomeView()))
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(/*viewModel: .init()*/)
        }
    }
}
#endif
