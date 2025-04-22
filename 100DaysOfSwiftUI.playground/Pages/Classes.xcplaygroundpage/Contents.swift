//: [Previous](@previous)

import Foundation

// Sample Class

class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    // This is a method of the parent Class
    func printCommuteHours() {
        print("I commute \(hours) hours a day.")
    }
}

// Inheritance - a Class inherits properties and methods from another Class
// Both Manager and Developer Class can use hours properties as they were inherited from Employee Class
class Manager: Employee {
    func work() -> String {
        return "I work \(hours) hours a day."
    }
}

class Developer: Employee {
    func work() -> String {
        return "I code \(hours) hours a day."
    }
}

// Now you can create child Classes
let manager = Manager(hours: 10)
let developer = Developer(hours: 5)

print(manager.work())
print(developer.work())

// You can also use methods from a parent Class
// Here we use printCommuteHours in both child Classes
manager.printCommuteHours()
developer.printCommuteHours()

// Overriding methods or properties
// We can override a method of a parent Class using override class keyword
// With this, you can use the parent Class method but with a different definition

class Janitor: Employee {
    // Here we override the parent Class method definition
    // and create our own
    override func printCommuteHours() {
        print("I walk \(hours) hours a day.")
    }
}

let janitor = Janitor(hours: 3)
janitor.printCommuteHours()

// Final keyword is when we don't want the Class to inherit its methods or properties to another Class
// This Guard Class is final and cannot be inherited by a child class
final class Guard: Employee {
    override func printCommuteHours() {
        print("I patrol \(hours) hours a day.")
    }
    
    // Methods of a final Class can only be used
    // by the Class itself
    func eat() -> String {
        return "I eat a lot"
    }
}

// Creating a new class SecurityGuard to inherit from Guard class
// is not allowed. Because Guard class is a final class
/*class SecurityGuard: Guard {
    
}*/

//: [Next](@next)
