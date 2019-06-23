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
    
    func addTrip(_ trip: Trip) throws -> String {
        let cdTrip = CDTrip(context: context)
        cdTrip.name = trip.name
        cdTrip.budget = trip.budget
        cdTrip.currency = trip.currency
        try context.save()
        return cdTrip.objectID.uriRepresentation().absoluteString
    }
    
    func getTrip(byID id: String) -> Trip? {
        print(id)
        guard
            let idURL = URL(string: id),
            let coordinator = context.persistentStoreCoordinator,
            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: idURL),
            let cdTrip = context.object(with: managedObjectID) as? CDTrip
        else {
            print("Cannot get trip with id \(id)")
            return nil
        }
        
        
        
        return cdTrip.asTrip()
    }
}
