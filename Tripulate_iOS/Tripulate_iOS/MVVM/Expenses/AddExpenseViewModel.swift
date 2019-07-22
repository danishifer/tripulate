//
//  AddExpenseViewModel.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 25/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import TripulateKit

class AddExpenseViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    let dataStore: DataStore
    let configurationStore: ConfigurationStore
    
    init(configurationStore: ConfigurationStore, dataStore: DataStore) {
        self.dataStore = dataStore
        self.configurationStore = configurationStore
    }
    
    func addExpense() -> Bool {
        guard
            let amount = Double(self.amount),
            self.category != ""
        else {
            print("Couldn't add expense - requirements not met")
            return false
        }
        
        guard
            let activeTripID = configurationStore.activeTripID,
            let activeTrip = dataStore.getTrip(byID: activeTripID)
        else {
            print("Couldn't add expense - active trip not found")
            return false
        }
        
        let expense = Expense(
            id: nil,
            creationDate: .init(),
            amount: amount,
            name: name != "" ? name : nil,
            categoryId: self.category
        )
        
        do {
            let _ = try self.dataStore.addExpense(expense, toTrip: activeTrip)
            NotificationCenter.default.post(name: .TripulateExpenseAdded, object: activeTrip)
            return true
        } catch {
            print("Couldn't add expense - data store error")
            return false
        }
    }
    
    var amount: String = "" {
        didSet {
            self.didChange.send(())
        }
    }
    
    var name: String = "" {
        didSet {
            self.didChange.send(())
        }
    }
    
    var category: String = "" {
        didSet {
            self.didChange.send(())
        }
    }
    
    var canAddExpense: Bool {
        get {
            return (
                Double(self.amount) != nil &&
                self.name != "" &&
                self.category != ""
            )
        }
    }
    
    lazy var categories: [ExpenseCategory] = {
        return self.dataStore.getExpenseCategories()
    }()
}
