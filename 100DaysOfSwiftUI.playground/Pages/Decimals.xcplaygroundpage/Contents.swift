//: [Previous](@previous)

import Foundation

let number: Double = 0.1 * 0.2
print(number)

// Swift doesn't allow to mix whole number with decimals
// You need to type cast
let numberAsInt: Int = 5
let numberAsDouble: Double = 5.0
let numberAsFloat: Float = 10.4
let totalNumbers = Double(numberAsInt) + numberAsDouble + Double(numberAsFloat)
print(totalNumbers)

//: [Next](@next)
