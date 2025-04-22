//: [Previous](@previous)

import Foundation

// Protocols are contracts in Swift, it synonymous to interfaces in Java/C++
// they let us define what kinds of functionality we expect a data type to support,
// and Swift ensures that the rest of our code follows those rules.

// Example we have a Vehicle protocol
protocol Vehicle {
    // Protocols only contains blueprints of methods
    // hence you cannot write implementations on protocol methods
    func estimateTime(for distance: Int) -> Int
    func travelTime(for distance: Int)
}

// Structs, Classes and Enums can use protocols
// Using a protocol is a process called confirming to the protocol

struct Car: Vehicle { // Car is confirming to the Vehicle protocol
    
    // Now we are implementing the methods from the Vehicle protocol
    // All methods needs to be the same as defined in a protocol
    func estimateTime(for distance: Int) -> Int {
        return distance / 50
    }
    
    func travelTime(for distance: Int) {
        print("I'm driving \(distance) km")
    }
    // We can also create own methods that does not conform the protocol
    func engineType(engine: String) -> String {
        return "This has an \(engine) engine"
    }
}

// We can now use all the methods such as below
func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow!")
    } else {
        vehicle.travelTime(for: distance)
    }
}

// Then create a new Car instance and pass it to the commute method
let car = Car()
commute(distance: 100, using: car)

// Let's create a Bicycle struct that conforms Vehicle protocol
// Just like the Car's method implementation with slight differences
struct Bycicle: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        return distance / 10
    }
    
    func travelTime(for distance: Int) {
        print("I'm cycling \(distance) km")
    }
}

let bike = Bycicle()
commute(distance: 50, using: bike)
    

protocol Ride {
    // Here we have blueprints of properties inside a protocol
    // We cannot set default values just like protocol methods wherein we cannot implement logic on it
    var name: String { get }
    var engine: String { get set }
}

// Protocols supports multiple inheritance by passing protocols with commas
struct ElectricCar: Ride, Vehicle {
    // Properties below are from Ride protocol
    // And can now implement or set values in it inside a Struct
    var name: String = "Tesla Model 3"
    var engine: String = "Electric Motor"
    
    // Methods below are from the Vehicle protocol
    // We implement logic on them inside the Struct or Class
    func estimateTime(for distance: Int) -> Int {
        return distance / 10
    }
    
    func travelTime(for distance: Int) {
        print("I'm driving \(distance) km")
    }
}

// Here we create a method that uses both protocols and implement our logic
func getAutoDetails(using vehicle: Vehicle, using ride: Ride, distance: Int) {
    let estimate = vehicle.estimateTime(for: distance)
    print("I'm driving a \(ride.name) it's too damn slow with its \(ride.engine) it takes \(estimate) hours to travel \(distance)km")
}

let tesla = ElectricCar()
getAutoDetails(using: car, using: tesla, distance: 150)

//: [Next](@next)
