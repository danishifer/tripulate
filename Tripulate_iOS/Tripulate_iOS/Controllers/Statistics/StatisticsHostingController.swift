//
//  StatisticsHostingController.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 6/26/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

class StatisticsHostingController: UIHostingController<StatisticsView.WithViewModel> {
    override init(rootView: StatisticsView.WithViewModel) {
        super.init(rootView: rootView)
        
        self.tabBarItem = UITabBarItem(title: "Statistics", image: UIImage(systemName: "chart.bar"), tag: 0)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
