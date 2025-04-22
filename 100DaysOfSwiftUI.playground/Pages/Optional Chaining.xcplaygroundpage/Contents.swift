//: [Previous](@previous)

import Foundation

// Optional chaining is a simplified syntax for reading optionals inside optionals.

// Optional chaining makes for a very good companion to nil coalescing,
// because it allows you to dig through layers of optionals
// while also providing a sensible fall back if any of the optionals are nil.

// Let's create an array of names
let names = ["Alice", "Bob", "John", "David"]

// This code tells me to pick an element from the array randomly.
// If it returns a random value, then we uppercase it.
// If it does not return any value after uppercase, then nil coalesce it then return No one
let chose = names.randomElement()?.uppercased() ?? "No one"

// A struct with optional parameter
struct Person {
    var personName: String?
}

// We have an optional instance of a Person struct
let name : Person? = nil // at this point, name is nil - it doesn't point to any instance of Person

// Since name is optional, you can't access its properties directly
// you need to unwrap it like below

// this line reads if we have a name and the name has personName property
// and personName has a first letter then uppercase it
// and send it back, otherwise return J
let john = name?.personName?.first?.uppercased() ?? "J"

// Structs itself can return nil during initialization
struct Product {
    var barCode: String
    
    init?(barCode: String?) {
        guard let barCode = barCode else { return nil }
        self.barCode = barCode
    }
}

let validProduct = Product(barCode: "12345")    // returns String
let invalidProduct = Product(barCode: "")       // returns nil

//: [Next](@next)
