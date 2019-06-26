//
//  CoreDataStore+Trip.swift
//  CoreDataStore
//
//  Created by Dani Shifer on 6/26/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import TripulateKit
import CoreData


extension CoreDataStore {
    public func getTrips(
        sortedBy: Trip.Sort,
        ascending: Bool,
        completion callback: @escaping ([Trip]) -> Void
    ) {
        let fetchRequest: NSFetchRequest<CDTrip> = CDTrip.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: sortedBy.rawValue, ascending: ascending)
        ]
        
        let request = NSAsynchronousFetchRequest<CDTrip>(fetchRequest: fetchRequest) { result in
            guard let cdTrips = result.finalResult else {
                print("Couldn't fetch trips, finalResult is nil")
                return
            }
            
            callback(cdTrips.map { (trip: CDTrip) -> Trip in
                return trip.toStandardTrip()
            })
        }
        
        do {
            try context.execute(request)
        } catch {
            print("Couldn't fetch trips: \(error)")
        }
    }
    
    public func getTripsSync(sortedBy: Trip.Sort, ascending: Bool) -> [Trip] {
        let request: NSFetchRequest<CDTrip> = CDTrip.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(key: sortedBy.rawValue, ascending: ascending)
        ]
        
        do {
            let results = try context.fetch(request)
            return results.map { (trip: CDTrip) -> Trip in
                return trip.toStandardTrip()
            }
        } catch {
            print("[Tripulate] [CoreDataStore] Cannot fetch trips: \(error)")
            return []
        }
    }
    
    public func addTrip(_ trip: Trip) throws -> String {
        let cdTrip = CDTrip(context: context)
        cdTrip.creationDate = trip.creationDate
        cdTrip.name = trip.name
        cdTrip.budget = trip.budget
        cdTrip.currency = trip.currency
        try context.save()
        return cdTrip.objectID.uriRepresentation().absoluteString
    }
    
    func getCDTrip(byID id: String) -> CDTrip? {
        guard
            let idURL = URL(string: id),
            let coordinator = context.persistentStoreCoordinator,
            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: idURL)
            else {
                print("Cannot get CDTrip with id \(id)")
                return nil
        }
        
        return context.object(with: managedObjectID) as? CDTrip
    }
    
    public func getTrip(byID id: String) -> Trip? {
        return self.getCDTrip(byID: id)?.toStandardTrip()
    }
}
