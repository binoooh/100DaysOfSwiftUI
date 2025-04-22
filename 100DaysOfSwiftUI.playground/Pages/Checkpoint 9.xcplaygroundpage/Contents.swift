//: [Previous](@previous)

import Foundation

func numberPicker(from numbers: [Int]?) -> Int {
    return numbers?.randomElement() ?? Int.random(in: 1...100)
}

let num1 = numberPicker(from: nil)
print(num1)

let num2 = numberPicker(from: [1,5,23,768,6,53])
print(num2)

//: [Next](@next)
