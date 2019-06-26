//
//  TripPickerViewModel.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 25/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import TripulateKit


class TripPickerViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    var configurationStore: ConfigurationStore
    let dataStore: DataStore
    let addTripViewFactory: (@escaping () -> Void) -> AddTrip.WithViewModel
    let dateFormatter: DateFormatter
    
    init(
        configurationStore: ConfigurationStore,
        dataStore: DataStore,
        addTripViewFactory: @escaping (@escaping () -> Void) -> AddTrip.WithViewModel
    ) {
        self.configurationStore = configurationStore
        self.dataStore = dataStore
        self.addTripViewFactory = addTripViewFactory
        self.dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let _ = NotificationCenter.default.publisher(for: .activeTripDidChange)
            .receive(on: RunLoop.main)
            .sink { _ in
                self.activeTripId = self.configurationStore.activeTripID
                self.didChange.send(())
            }
        
        self.loadTrips()
    }
    
    func setActiveTrip(trip: Trip) {
        guard let tripId = trip.id else { return }
        self.configurationStore.activeTripID = tripId
    }
    
    var showAddTripModal: Bool = false {
        didSet {
            self.didChange.send(())
        }
    }
    
    lazy var activeTripId: String? = {
       return self.configurationStore.activeTripID
    }()
    
    var trips = [Trip]() {
        didSet {
            self.didChange.send(())
        }
    }
    
    lazy var addTripView: AddTrip.WithViewModel = {
        return self.addTripViewFactory {
            self.showAddTripModal = false
            self.loadTrips()
        }
    }()
    
    private func loadTrips() {
        DispatchQueue(label: "LoadTrips", qos: .background).async {
            let trips = self.dataStore.getTrips(sortedBy: .creationDate)
            DispatchQueue.main.async {
                self.trips = trips
            }
        }
    }
}
