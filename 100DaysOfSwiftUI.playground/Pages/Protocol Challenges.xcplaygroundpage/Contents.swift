//: [Previous](@previous)

import Foundation

// Challenge 01 - Basic Protocol Definition
// Define a protocol called Vehicle with a startEngine() method.
// Create two structs, Car and Bike, that conform to this protocol.
protocol Vehicle {
    func startEngine()
}

struct Car: Vehicle {
    func startEngine() {
        print("Vroom vroom!")
    }
}

struct Bike: Vehicle {
    func startEngine() {
        print("Pedal!")
    }
}

// Challenge 02 - Computed Property in Protocol
// Define a protocol Person with a computed property fullName: String.
// Create a struct Employee that conforms to Person and returns the full name from firstName and lastName.
protocol Person {
    var fullName: String { get }    //
}

struct Employee: Person {
    let firstName: String
    let lastName: String
    
    var fullName: String { // Computed property using get and set
        get {
            return "\(firstName) \(lastName)"
        }
    }
}

// Challenge 03 - Protocol Inheritance
// Create a protocol Animal with a method speak().
// Create a new protocol Pet that inherits from Animal and adds a property isFriendly: Bool.
protocol Animal {
    func speak()
}

protocol Pet: Animal {  // Pet inherits from Animal protocol
    var isFriendly: Bool { get }
}

struct Dog: Pet {   // Dog inherits from Pet and Animal protocols
    var isFriendly: Bool = true
    func speak() {
        print("Woof!")
    }
}

// Challenge 04 - Mutating Method in Protocol
// Define a protocol Toggleable with a mutating function toggle().
// Create an enum LightSwitch with states .on and .off, and make it conform to Toggleable.
protocol Toggleable {
    mutating func toggle()
}

enum LightSwitch: Toggleable {
    case on
    case off
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}
// toggle method is mutating beca`use it reassigns self
// to a new case, modifying enum's state
var lamp = LightSwitch.on
print(lamp) // on
lamp.toggle()
print(lamp) // off


// Challege 05 - Initializer Requirement
// Define a protocol Initializable with an initializer init(name: String).
// Create a class Product that conforms to this protocol.
protocol Initializable {
    init(name: String)
}

class Product: Initializable {
    let name: String
    
    // When a protocol defines an initializer requirement,
    // any conforming class must mark its implementation as required
    // to ensure subclasses also conform to the protocol.
    required init(name: String) {
        self.name = name
    }
}

class Item: Initializable {
    let name: String
    
    // The required keyword is used for protocol conformance with initializers
    // If a protocol has an initializer, a class must have required keyword
    // on its initializer to conform to the protocol
    required init(name: String) {
        self.name = name
    }
    
}

// Challenge 06 - Associated Type
// Define a protocol Container with an associated type Item and functions append(_:) and count.
// Implement it in a struct IntStack for Int items.
protocol Container {
    associatedtype Item                     // Item is an associated type,
    var count: Item { get }                 // the conforming Struct or Enum decides what data type
    mutating func append(_ newItem: Item)   // it will be e.g. Int, String etc.
}

// IntStack conforms Container
struct IntStack: Container {
    typealias Item = Int    // typealias explicitly specifies the type conforming the protocol
    var items: [Int]
    
    mutating func append(_ newItem: Int) {
        items.append(newItem)
    }
    
    var count: Int {
        return items.count
    }
}
// StringStack conforms Container
struct StringStack: Container {
    typealias Item = String     // typealias explicitly specifies the type conforming the protocol
    var items: [String] = []
    
    mutating func append(_ newItem: String) {
        items.append(newItem)
    }
    
    var count: String {
        return "\(items.count)"
    }
}


var intStack = IntStack(items: [5,1,2,6,45,1201,10])
intStack.append(10102)
intStack.append(2281)
print(intStack.count)

var stringStack = StringStack()
stringStack.append("Hello")
stringStack.append("World")
print(stringStack.count)

// Challenge 07 - Protocol as Type Constraint
// Define a protocol Drawable with a method draw().
// Write a function renderScene(objects: [Drawable]) that loops over and calls draw() on each object.
protocol Drawable {
    mutating func draw()
}

extension Drawable {
    func draw() {
        print("\(Self.self)")
    }
}

func renderScene(objects: [Drawable]) {
    for object in objects {
        object.draw()
    }
}

// Challenge 08 - Multiple Protocol Conformance
// Define two protocols: Flyable and Swimmable, each with a perform() method.
// Create a struct Duck that conforms to both and calls both methods from a single perform().
protocol Flyable {
    func perform()
}

protocol Swimmable {
    func perform()
}

struct Duck: Flyable, Swimmable {
    func perform() {
        print("Duck can fly and swim")
    }
}


//: [Next](@next)
