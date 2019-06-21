//
//  RootView.swift
//  Tripulate
//
//  Created by Haim Marcovici on 21/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct RootView : View {
    let controller: MainViewController
    @State private var showWelcomeScreen = true
    
    var body: some View {
        controller
            .edgesIgnoringSafeArea(.all)
            .presentation(showWelcomeScreen ? Modal(WelcomeView()) : nil)
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView(controller: .init(viewControllers: []))
    }
}
#endif
