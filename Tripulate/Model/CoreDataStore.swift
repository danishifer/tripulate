//
//  CoreDataStore.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore: DataStore {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTrip(_ trip: Trip) throws {
        let cdTrip = CDTrip(context: context)
        cdTrip.name = trip.name
        cdTrip.budget = trip.budget
        cdTrip.currency = trip.currency
        try context.save()
    }
}
