//: [Previous](@previous)

import Foundation

struct Car {
    // If we have a property that's private
    // We need an initializer otherwise Swift will throw an error
    let model: String
    let numberOfSeats: Int
    private var currentGear: Int
    
    // We use init to initialize all property since we have a private property
    init(model: String, numberOfSeats: Int, currentGear: Int = 0) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.currentGear = currentGear
    }
    
    mutating func changeGear(changeGearBy: Int) {
        for i in 0..<changeGearBy {
            if i < 6 {
                currentGear = i
            } else if i > 6 {
                currentGear = i - 1
            }
        }
        print("Make: \(model), Number of Seats: \(numberOfSeats), Current gear: \(currentGear)")
    }
    
//    mutating func getCarInfo() -> String {
//        return "Make: \(model), Number of Seats: \(numberOfSeats), Current gear: \(currentGear)"
//    }
}

var mazda = Car(model: "Mazda3", numberOfSeats: 5)
mazda.changeGear(changeGearBy: 4)
mazda.changeGear(changeGearBy: 7)
mazda.changeGear(changeGearBy: 5)

var vios = Car(model: "Vios", numberOfSeats: 4)
vios.changeGear(changeGearBy: 1)


//: [Next](@next)
