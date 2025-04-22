//: [Previous](@previous)

import Foundation

// create a number w/o initializing
var myNumber: Int
//myNumber = 7

// create and initialize a number
let smallNumbers: Int = 10

// use under score to make it readable
let bigNumbers: Int = 100_000_000

// arithmetic operators (+ - / %)
let lowNumber: Int = 120
let highNumber: Int = 10
let sum: Int = lowNumber + highNumber
let difference: Int = highNumber - lowNumber
let product: Int = lowNumber * highNumber
let quotient: Int = highNumber / lowNumber
let remainder: Int = highNumber % lowNumber

print("Sum: \(sum)")
print("Difference: \(difference)")
print("Product: \(product)")
print("Quotient: \(quotient)")
print("Remainder: \(remainder)")

// compound assignment operator
var totalSum: Int = lowNumber + highNumber
totalSum += 50
totalSum -= 2
totalSum *= 100
totalSum /= 3
totalSum %= 3
print("Total: \(totalSum)")

// number helper functions
let multiPleOfTwo: Bool = lowNumber.isMultiple(of: 2)
print("Is multiple of two: \(multiPleOfTwo)")
//: [Next](@next)
