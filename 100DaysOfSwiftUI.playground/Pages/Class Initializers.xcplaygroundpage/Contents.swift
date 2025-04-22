//: [Previous](@previous)

import Foundation

// If a child class has its own initializer, it must always
// call the parent's class initializer after it has finished
// setting up its own property, if has any.

// Swift won’t automatically generate a memberwise initializer for classes.
// This applies with or without inheritance happening

class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

// Here the Car class has its own initializer to initialize its property
class Car: Vehicle {
    let isConvertible: Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        // We need to call the parent class initializer
        // because Swift doesn't generate memberwise initializer
        // Otherwise, Swift will throw an error
        // We use super keyword to call the parent class methods or properties
        super.init(isElectric: isElectric)
    }
}

class Truck: Vehicle {
    let payloadCapacity: Int
    
    init(payloadCapacity: Int) {
        self.payloadCapacity = payloadCapacity
        super.init(isElectric: false)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)
let f150 = Truck(payloadCapacity: 10000)

//: [Next](@next)
