//
//  ExpensesViewModel.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 25/06/2019.
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
    let numberFormatter: NumberFormatter
    
    init(
        configurationStore: ConfigurationStore,
        dataStore: DataStore,
        addExpenseViewFactory: @escaping (@escaping () -> Void) -> AddExpenseView.WithViewModel
    ) {
        self.configurationStore = configurationStore
        self.dataStore = dataStore
        self.addExpenseViewFactory = addExpenseViewFactory
        self.dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        self.numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumFractionDigits = 2
        
        let _ = NotificationCenter.default.publisher(for: .activeTripDidChange)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.trip = self.loadTrip()
                self.loadExpenses()
            }
        
        self.loadExpenses()
    }
    
    var showAddExpenseView: Bool = false {
        didSet {
            self.didChange.send(())
        }
    }
    
    lazy var addExpenseView: AddExpenseView.WithViewModel = {
        return self.addExpenseViewFactory {
            self.loadExpenses()
            self.showAddExpenseView = false
        }
    }()
    
    lazy var trip: Trip? = self.loadTrip()
    
    private func loadTrip() -> Trip? {
        guard let activeTripID = self.configurationStore.activeTripID else {
            return nil
        }
        
        return self.dataStore.getTrip(byID: activeTripID)
    }
    
    lazy var currency: Currency? = {
        guard let trip = self.trip else {
            return nil
        }
        
        return Currency.from(code: trip.currency)
    }()
    
    var expenses = [[Expense]]() {
        didSet {
            self.didChange.send(())
        }
    }
    
    private func partitionExpenses(_ expenses: [Expense]) -> [[Expense]] {
        if (expenses.count == 0) { return [] }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        var to = [[expenses[0]]]
        for i in 1..<expenses.count {
            let prev = expenses[i - 1]
            let curr = expenses[i]
            
            if formatter.string(from: prev.creationDate) != formatter.string(from: curr.creationDate) {
                to.append([])
            }
            
            to[to.count - 1].append(curr)
        }
        return to
    }
    
    private func loadExpenses() {
        DispatchQueue(label: "LoadExpenses", qos: .background).async {
            guard let trip = self.trip else { return }
            let expenses = self.dataStore.getExpenses(ofTrip: trip, sortedBy: .creationDate)
            let partitioned = self.partitionExpenses(expenses)
            
            DispatchQueue.main.async {
                self.expenses = partitioned
            }
        }
    }
}

