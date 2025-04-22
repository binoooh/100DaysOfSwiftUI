//: [Previous](@previous)

import Foundation

// Swift classes are reference types
// which means they refer to a value somewhere else
// meaning if you copy a class and change its value of a property
// it will change the property value of the class being copied to as well
class User {
    var name = "Anynomous"
}

// Here user1 class has the same value of the property of User class
var user1 = User()
// Now user2 class has the same value of the property of user1 class
var user2 = user1
// If we change the property value of user2 class different from the User class property value
user2.name = "John"

// It will both update the property values of the class property values
print(user1.name)
print(user2.name)

// If we want to change the value of a property in a class copy
// we use can create a function that will create a copy of the property being updated
class Fruit {
    var name = "Orange"
    // The method below creates a new clas instance and copies the class property then return it
    func copy() -> Fruit {
        let fruit = Fruit()
        fruit.name = self.name
        return fruit
    }
}
// Now we can change the name property and set their values separately
var mango = Fruit()
var pineapple = mango.copy()
pineapple.name = "Pineapple"

print(mango.name) 
print(pineapple.name) 


//: [Next](@next)
