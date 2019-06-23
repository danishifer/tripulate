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

class AddTripViewModel: BindableObject {
    
    let dataStore: DataStore!
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
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
    
    func addTrip() -> Bool {
        guard let budget = Double(budget) else {
            return false
        }
        
        let trip = Trip(name: name, budget: budget, currency: currency)
        
        do {
            try dataStore.addTrip(trip)
        } catch {
            print("Error: \(error)")
            return false
        }
        return true
    }
    
    lazy var categories: [CDCategory] = {
        let request: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
        
        guard let categories = try? (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(request) else {
            print("Cannot fetch categories")
            return []
        }
        
        return categories
    }()
    
    let currencies: [Currency] = Currency.all
}

