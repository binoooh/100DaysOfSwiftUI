//: [Previous](@previous)

import Foundation

var luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

var _ = luckyNumbers
    .filter { !$0.isMultiple(of: 2)}
    .sorted()
    .map { print("\($0) is a lucky number") }

//: [Next](@next)
