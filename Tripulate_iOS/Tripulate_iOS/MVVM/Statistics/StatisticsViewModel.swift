//
//  StatisticsViewModel.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 6/26/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import TripulateKit

class StatisticsViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    let configurationStore: ConfigurationStore
    let dataStore: DataStore
    
    let numberFormatter: NumberFormatter
    
    init(configurationStore: ConfigurationStore, dataStore: DataStore) {
        self.configurationStore = configurationStore
        self.dataStore = dataStore
        
        self.numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        let _ = NotificationCenter.default.publisher(for: .activeTripDidChange)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.trip = self.loadTrip()
                self.loadExpenses()
            }
        
        self.loadExpenses()
    }
    
    func loadTrip() -> Trip? {
        guard let activeTripID = self.configurationStore.activeTripID else {
            return nil
        }
        
       return self.dataStore.getTrip(byID: activeTripID)
    }
    
    
    lazy var trip: Trip? = self.loadTrip()
    
    lazy var categories: [ExpenseCategory] = {
        return self.dataStore.getExpenseCategories()
    }()
    
    var categoriesDistibution: [BarData] {
        get {
            let categoriesSum = self.loadCategoriesSum()
            
            return self.categories.map { (category: ExpenseCategory) -> BarData in
                let sum = categoriesSum[category.id!] ?? 0.0
                return BarData(
                    id: category.id,
                    value: sum,
                    label: Text(numberFormatter.string(for: sum)!),
                    icon: Image(uiImage: category.icon)
                )
            }
        }
    }
    
    func loadCategoriesSum() -> [String: Double] {
        var result = [String: Double]()
        
        for expense in expenses {
            if result[expense.categoryId] == nil {
                result[expense.categoryId] = 0.0
            }
            
            result[expense.categoryId]! += expense.amount
        }
        
        return result
    }
    
    var expenses = [Expense]() {
        didSet {
            self.didChange.send(())
        }
    }
    
    var totalBudgetSpent: Double {
        get {
            return self.calculateTotalBudgetSpent()
        }
    }
    
    var totalBudget: Double {
        get {
            return self.trip?.budget ?? 0.0
        }
    }
    
    private func calculateTotalBudgetSpent() -> Double {
        var sum = 0.0
        for expense in expenses {
            sum += expense.amount
        }
        return sum
    }
    
    func loadExpenses() {
        DispatchQueue(label: "StatisticsViewModel.LoadExpenses").async {
            guard let trip = self.trip else {
                return
            }
            
            let expenses = self.dataStore.getExpenses(
                ofTrip: trip,
                sortedBy: .creationDate,
                ascending: false
            )
            
            DispatchQueue.main.async {
                self.expenses = expenses
            }
        }
    }
}
