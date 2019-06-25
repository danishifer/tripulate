//
//  ExpensesViewModel.swift
//  Tripulate_iOS
//
//  Created by Haim Marcovici on 25/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import TripulateKit

class ExpensesViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    let configurationStore: ConfigurationStore
    let dataStore: DataStore
    let addExpenseViewFactory: (@escaping () -> Void) -> AddExpenseView.WithViewModel
    
    let dateFormatter: DateFormatter
    
    init(
        configurationStore: ConfigurationStore,
        dataStore: DataStore,
        addExpenseViewFactory: @escaping (@escaping () -> Void) -> AddExpenseView.WithViewModel
    ) {
        self.configurationStore = configurationStore
        self.dataStore = dataStore
        self.addExpenseViewFactory = addExpenseViewFactory
        
        self.dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
    }
    
    var showAddExpenseView: Bool = false {
        didSet {
            self.didChange.send(())
        }
    }
    
    lazy var addExpenseView: AddExpenseView.WithViewModel = {
        return self.addExpenseViewFactory {
            self.expenses = self.loadExpenses()
            self.showAddExpenseView = false
        }
    }()
    
    lazy var trip: Trip? = {
        guard let activeTripID = self.configurationStore.activeTripID else {
            return nil
        }
        
        return self.dataStore.getTrip(byID: activeTripID)
    }()
    
    lazy var expenses: [Expense] = self.loadExpenses()
    
    private func loadExpenses() -> [Expense] {
        guard let trip = self.trip else { return [] }
        return self.dataStore.getExpenses(ofTrip: trip, sortedBy: .creationDate)
    }
}

