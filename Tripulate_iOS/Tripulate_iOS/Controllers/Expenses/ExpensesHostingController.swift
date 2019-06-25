//
//  ExpensesHostingController.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

class ExpensesHostingController: UIHostingController<ExpensesView.WithViewModel> {
    override init(rootView: ExpensesView.WithViewModel) {
        super.init(rootView: rootView)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Expenses"
        
        self.navigationItem.searchController = searchController
        self.tabBarItem = UITabBarItem(title: "Expenses", image: UIImage(systemName: "tray.full"), tag: 1)
        self.definesPresentationContext = true
        
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
