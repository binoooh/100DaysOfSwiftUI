//: [Previous](@previous)

import Foundation

// creating functions with function parameters
func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(number) x \(i) = \(number * i)")
    }
}

// using functions with arguments
printTimesTables(number: 5, end: 20)

// returning values from functions
func rollDice() -> Int {
    return Int.random(in: 1...6)
}

print("You rolled a \(rollDice())")

// We can also ommit return keyword specially for single line return values
func sortString(stringA: String, stringB: String) -> Bool {
    stringA.sorted() == stringB.sorted()
}

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

print("The hypotenuse is \(pythagoras(a: 3, b: 4))")

//: [Next](@next)
