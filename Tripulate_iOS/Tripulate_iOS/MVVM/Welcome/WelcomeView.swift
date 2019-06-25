//
//  WelcomeView.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct WelcomeView : View {
    @EnvironmentObject var viewModel: WelcomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Tripulate")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.top, 72.0)
                
                
                Text("To get started, add a trip")
                    .font(.callout)
                    .color(.secondary)
                
                Spacer()
                
                Button(action: {
                    self.viewModel.showAddTripModal.toggle()
                }) {
                    HStack {
                        Spacer()
                        
                        Text("Add Trip")
                            .font(.headline)
                            .color(.white)
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color.accentColor)
                .cornerRadius(14)
            }
            .padding(.horizontal, 24.0)
            .padding(.bottom, 50.0)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .presentation(
                viewModel.showAddTripModal ?
                Modal(viewModel.addTripView, onDismiss: {
                    self.viewModel.showAddTripModal = false
                }):
                nil
            )
        }
    }
    
    typealias WithViewModel = WelcomeView.Modified<_EnvironmentKeyWritingModifier<WelcomeViewModel?>>
}

//#if DEBUG
//struct WelcomeView_Previews : PreviewProvider {
//    static var previews: some View {
//        WelcomeView()
//    }
//}
//#endif
