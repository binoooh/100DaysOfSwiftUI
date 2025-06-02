//
//  Order.swift
//  CupcakeCorner
//
//  Created by Vinz on 6/1/25.
//

import Foundation

// Day 52 - Coding Challenge
extension String {
    func isOnlyWhitespace() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Stawberry", "Chocolate", "Raibow"]
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
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
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
            // Day 52 - Coding Challenge
        } else if name.isOnlyWhitespace() || streetAddress.isOnlyWhitespace() || city.isOnlyWhitespace() || zip.isOnlyWhitespace() {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        // complicated cakes costs more
        cost += Decimal(type) / 2
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
