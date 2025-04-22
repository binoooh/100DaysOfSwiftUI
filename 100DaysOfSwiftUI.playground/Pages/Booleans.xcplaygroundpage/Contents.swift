//: [Previous](@previous)

import Foundation

let fileName = "pic.jpg"
print(fileName.hasSuffix(".jpg")) // prints true

let numberIsMultiple = 120
print(numberIsMultiple.isMultiple(of: 3)) // prints true

let isMultiple = 120.isMultiple(of: 3)
print("isMultiple is \(isMultiple)")

// toggle function
var gameOver = true
gameOver.toggle() // flips gameOver to false
print("Game Over is \(gameOver)")

// negating booleans
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print("Is Authenticated is \(isAuthenticated)")

//: [Next](@next)
