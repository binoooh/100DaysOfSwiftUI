//: [Previous](@previous)

import Foundation

// type annotations explicitly defines the data type to be stored on a variable or constants
var girlNames : String = "Aria"
let score : Int = 90

print("My name is \(girlNames)")
print("My score is \(score)")

let gameOver : Bool = true
let temperature : Double = 25.3
let time : Float = 10.5
let number: Int = 20

// type annotated array of strings
var pastYears: [String] = ["2018", "2019", "2020"]

// type annotated dictionary of strings
var emailAddresses: [String: String] = ["Alice": "alice@example.com", "Bob": "bob@example.com"]

// type annotated set of strings
var famousBooks : Set<String> = Set(["Harry Potter", "To Kill a Mockingbird", "Clearly, I'm Not Your Average Joe"])

// type annotated empty arrays
var teams : [String] = [String]()
var cities : [String] = []
var games = [String]()

// swift allow constants without a value then later initialize it
// but swift will not allow you to use uninitialized constant type
let houseNumber : Int
// code here
houseNumber = 106
// code here
print("My house number is \(houseNumber)")

//: [Next](@next)
