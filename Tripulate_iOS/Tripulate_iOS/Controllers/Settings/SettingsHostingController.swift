//
//  SettingsHostingController.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

class SettingsHostingController: UIHostingController<SettingsView> {
    override init(rootView: SettingsView) {
        super.init(rootView: rootView)
        
        self.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
