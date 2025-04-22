//: [Previous](@previous)

import Foundation

// We can skip parameter name using _ specially when functions is a verb
// Here we are not using parameter names so we can just call the function without specifying the paramter name
func isUpperCased(_ string: String) -> Bool {
    string == string.uppercased()
}

print(isUpperCased("HELLO")) // returns true
print(isUpperCased("hello")) // returns false

// External parameters are use as parameter name
// Here for is an external parameter and number is an internal parameter
func timesTable(for number: Int) {
    for i in 1...12 {
        print("\(i) * \(number) is \(i * number)")
    }
}

// We now pass the value to the external parameter
print(timesTable(for: 5))

func greet(_ name: String) {
    print("Hi, \(name)!")
}

//print(greet("World"))
//: [Next](@next)
