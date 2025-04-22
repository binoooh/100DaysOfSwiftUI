//: [Previous](@previous)

import Foundation

// Different types of access controls
// private - don't let anything outside the Struct use the property
// fileprivate - don't let anything outside the current file use this
// public - let anyone, anywhere use the property
// private(set) - can read outside the Struct but can't write outside the Struct

struct Salary {
    // private keyword is access control modifier
    // a property can only be accessed by func inside the Struct
    private var amount: Double = 0.0
    
    mutating func addSalary(addAmount: Double) {
        amount += addAmount
    }
    
    mutating func deductSalary(deductAmount: Double) {
        amount -= deductAmount
    }
    
    mutating func printSalary() {
        print("Salary: \(amount)")
    }
}

// Now you can create an instance of the Struct
// and to access it's properties, you have to call
// it's functions
var payStub = Salary()
payStub.addSalary(addAmount: 10000)
payStub.printSalary()
payStub.deductSalary(deductAmount: 200)
payStub.printSalary()

// Static property and functions
// When a property or a function is declared static
// You don't need to create an instance of a Struct
struct School {
    nonisolated(unsafe) static var numberOfStudents: Int = 0
    
    static func addStudent(pupil: String) {
        print("\(pupil) has joined the school")
        numberOfStudents += 1
    }
}

// Structs with static property or function
// We don't need to create an instance of the Struct
// We just call it's property or function
School.addStudent(pupil: "Bino")
print(School.numberOfStudents)

// Static makes sense when we don't want to create another instance of a Struct
struct App {
    static let appUrl = "https://someurl.com"
    static let appVersion = "1.0"
    
    static func launchApp() {
        print("Launching the app...")
    }
}

// with Struct static properties and functions I can just access then like below
print(App.appUrl)
print(App.appVersion)
App.launchApp()

//: [Next](@next)
