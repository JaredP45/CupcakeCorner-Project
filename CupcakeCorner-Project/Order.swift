//
//  Order.swift
//  CupcakeCorner-Project
//
//  Created by Jared Paubel on 4/21/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

import Foundation

class ObservOrder: ObservableObject {
    @Published var order: Order
    
    init(order: Order) {
        self.order = order
    }
}


struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
           streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
           city.trimmingCharacters(in: .whitespaces).isEmpty ||
           zip.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
        }
        return true
    }
     
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
