//
//  RootView.swift
//  Tripulate
//
//  Created by Dani Shifer on 21/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct RootView : View {
    let controller: MainViewController
    @EnvironmentObject var viewModel: RootViewModel
    
    var body: some View {
        controller
            .edgesIgnoringSafeArea(.all)
            .presentation(viewModel.showWelcomeView ? Modal(viewModel.welcomeViewFactory()) : nil)
    }
}

//#if DEBUG
//struct RootView_Previews : PreviewProvider {
//    static var previews: some View {
//        RootView(controller: .init(viewControllers: []), viewModel: .init())
//    }
//}
//#endif
