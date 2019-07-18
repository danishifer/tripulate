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
                self.loadCurrency()
                self.loadExpenses()
            }
        
        self.loadCurrency()
        self.loadExpenses()
    }
    
    func loadTrip() -> Trip? {
        guard let activeTripID = self.configurationStore.activeTripID else {
            return nil
        }
        
       return self.dataStore.getTrip(byID: activeTripID)
    }
    
    func loadCurrency() {
        guard let code = self.trip?.currency else {
            return
        }
        
        self.currency = Currency.from(code: code)
    }
    
    
    lazy var trip: Trip? = self.loadTrip()
    
    var currency: Currency? = nil
    
    lazy var categories: [ExpenseCategory] = {
        return self.dataStore.getExpenseCategories()
    }()
    
    var categoriesDistibution: [BarData<AnyView>] {
        get {
            let categoriesSum = self.loadCategoriesSum()
            
            return self.categories.map { (category: ExpenseCategory) -> BarData<AnyView> in
                let sum = categoriesSum[category.id!] ?? 0.0
                return BarData(
                    id: category.id,
                    value: sum,
                    label: AnyView(Group {
                        Text(numberFormatter.string(for: sum)!)
                            .font(.caption)
                            .color(.secondary)
                            .padding(.top, 2)
                        
                        Image(uiImage: category.icon)
                    })
                )
            }
        }
    }
    
    var daysDistribution: [BarData<AnyView>] {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd"
            
            struct DayBar {
                let label: String
                var sum: Double = 0.0
            }
            
            var data: [DayBar] = []
            
            // Expenses are already sort by creation date
            
            self.expenses.forEach { (expense) in
                let label = formatter.string(from: expense.creationDate)
                if data.last?.label != label {
                    data.append(DayBar(label: label))
                }
                
                data[data.count - 1].sum += expense.amount
            }
            
            return data.map { (day) -> BarData<AnyView> in
                return BarData(
                    id: day.label,
                    value: day.sum,
                    label: AnyView(
                        Text(day.label)
                            .font(.caption)
                            .color(.secondary)
                            .padding(.top, 2)
                    )
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
