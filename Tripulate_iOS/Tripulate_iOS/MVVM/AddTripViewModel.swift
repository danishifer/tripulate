//
//  AddTrip.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import CoreData
import TripulateKit

class AddTripViewModel: BindableObject {
    
    var configurationStore: ConfigurationStore
    let dataStore: DataStore
    
    init(dataStore: DataStore, configurationStore: ConfigurationStore) {
        self.dataStore = dataStore
        self.configurationStore = configurationStore
    }
    
    var didChange = PassthroughSubject<AddTripViewModel, Never>()
    
    var name: String = "" {
        didSet {
            didChange.send(self)
        }
    }
    
    var budget: String = "" {
        didSet {
            didChange.send(self)
        }
    }
    
    var currency: String = "" {
        didSet {
            didChange.send(self)
        }
    }
    
    var canAddTrip: Bool {
        get {
            return (
                self.name != "" &&
                self.budget != "" &&
                self.currency != "" &&
                Double(self.budget) != nil
            )
        }
    }
    
    func addTrip() -> Bool {
        guard let budget = Double(budget) else {
            return false
        }
        
        let trip = Trip(name: name, budget: budget, currency: currency)
        
        do {
            let tripId = try dataStore.addTrip(trip)
            configurationStore.activeTripID = tripId
        } catch {
            print("Error: \(error)")
            return false
        }
        return true
    }
    
    lazy var categories: [ExpenseCategory] = {
        return self.dataStore.getExpenseCategories()
    }()
    
    let currencies: [Currency] = Currency.all
}

