//
//  WelcomeViewModel.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine

class WelcomeViewModel: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var showAddTripModal: Bool = false {
        didSet {
            self.didChange.send(())
        }
    }
    
    let addTripViewFactory: (Binding<Bool>) -> AddTrip
    
    init(addTripViewFactory: @escaping (Binding<Bool>) -> AddTrip) {
        self.addTripViewFactory = addTripViewFactory
    }
}
