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
    
    var didChange = PassthroughSubject<Void, Never>()
    
    var name: String = "" {
        didSet {
            didChange.send(())
        }
    }
    
    var budget: String = "" {
        didSet {
            didChange.send(())
        }
    }
    
    lazy var categories: [Category] = {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        guard let categories = try? (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(request) else {
            print("Cannot fetch categories")
            return []
        }
        
        return categories
    }()
    
    let currencies: [Currency] = Currency.all
}

