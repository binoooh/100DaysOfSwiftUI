//: [Previous](@previous)

import Foundation

// Swift does not allow to concatenante different data types i.e. string + integer
// However, you can inject any type of data during runtime into a string with string interpolation
let firstName = "John"
let lastName = "Wick"
let numKills = 200
let message = "My name is \(firstName) \(lastName) I have \(numKills) kills"
print(message)

// Swift allows calculation within a string
let firstNum = 5;
let lastNum = 20;
let totalNum = "5 X 20 = \(5 * 20)"
print(totalNum)

//: [Next](@next)
