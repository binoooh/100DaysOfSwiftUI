//: [Previous](@previous)

import Foundation

// Variables or Constants
// Swift prefers constants
// ****************************
// Variables can change values
var var1: String = "Hello, World!"
var1 = "Hello, playground!"

// While constants has fixed values
let const1: String = "Hello, World!"

// Strings
let string1: String = "Hello, World"
let quotedString: String = "Hello, \"World\" from inside quotes" // This will print Hello "World"
let multiLineString: String = """
Hello I am
A multi-line
string.
"""
let string1Count: Int = string1.count // returns number of chars in a string
// Get the prefix & suffix in a string
let suffix: Bool = quotedString.hasSuffix("Hel")
let prefix: Bool = quotedString.hasPrefix("otes")

// Integers
// ****************************

let score: Int = 20
let topScore: Int = score + 30
let halfScore: Int = score / 2

// Increment
var count: Int = 0
count += 1

// Functions

// checking for is the number multiple of
let number: Int = 120
let isMultipleNumber: Bool = number.isMultiple(of: 3) // returns true

// creating random numbers
let randomNumbers = Int.random(in: 1...1000)

// Doubles
// If you set a value with decimals swift automatically
// treat it as a Double
// ****************************
let percentage: Double = 80.5 // 80.0 is still double


// Booleans
// Swift booleans only returns true or false
// ****************************
let isOn: Bool = true
let isOff: Bool = false

// You can use toggle to flip a value from true to false vice-versa
var isLightOn: Bool = true
isLightOn.toggle() // this will return false

// String Interpolation
// You can append any data type in a string to create a new string
// ****************************

let name: String = "John"
let age: Int = 40
let greeting: String = "Hello, my name is \(name) and I am \(age) years old."

// Arrays
// You can group values into a variable using arrays
// ****************************

let colors: [String] = ["red", "green", "blue"]
let numbers: [Int] = [1, 2, 3, 4, 5]
let readings: [Double] = [37.5, 38.0, 38.5]

// Access arrays values via its index
let firstColor: String = colors[0]      // returns red
let colorOne: String = colors.first!    // returns red
let secondNumber: Int = numbers[1]      // returns 2
let lastReadings: Double = readings[2]  // returns 38.5
let readingLast: Double = readings.last! // returns 38.5

// adding values to arrays must match the datatype you're adding
var teams = ["Dragons", "Sharks"]
teams.append("Lions")

// Functions in arrays
let colorCount: Int = colors.count
let checkNumber: Bool = numbers.contains(10)

// removing items from an array
teams.remove(at: 1)
teams.removeAll()

// creating empty array
var emptyArray = [String]()
emptyArray.append(contentsOf: colors)   // this will add all values of the colors array
emptyArray.append("yellow")             // this will add a single value to the array


//: [Next](@next)
