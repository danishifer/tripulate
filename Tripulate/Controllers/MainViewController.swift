//
//  MainViewController.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

class MainViewController: UITabBarController {
    convenience init(
        viewControllers: [UIViewController],
        defaultTabIndex: Int = 0,
        welcomeViewFactory: @escaping () -> WelcomeView
    ) {
        self.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        self.selectedIndex = defaultTabIndex
    }
}
