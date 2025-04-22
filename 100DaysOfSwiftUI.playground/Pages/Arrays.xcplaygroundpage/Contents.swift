//: [Previous](@previous)

import Foundation

// Swift only allows array of the same data type

// creating and initializing an array
var beatles = ["John", "Paul", "George", "Ringo"]

// adding a value in an array
beatles.append("Strawberry")

print("Beatles: \(beatles)")

// creating an empty array on integer
var scores = Array<Int>()
// adding values to an empty array
scores.append(10)
scores.append(50)
scores.append(30)
// prints the value of the array
print("Scores: \(scores[2])")

// shorthand and common way to create an array
var albums = [String]()

// another way to create and initialize an array
var names = ["Alice"]
names.append("Wonderland")
print("Names: \(names)")

// useful helper array functions

// count() prints number of values
print(beatles.count)

// remove(at: index) and removeAll()
var carMake: [String] = ["Toyota", "Honda", "Ford", "Kia", "Hyundai"]
print("Car Make: \(carMake)")

// remove at index
carMake.remove(at: 1)
carMake.remove(at: 3)
print("carMake: \(carMake)")

// remove all
carMake.removeAll()
print("Car Make: \(carMake)")

// contains() search for value in an array returns boolean value
let dogNames = ["Maya", "Max", "Crayon", "Kobi", "Curcur", "Maxim"]
print(dogNames.contains("Max"))
print(dogNames.contains("Daisy"))

// sorted() to sort array values
let countryNames = ["India", "USA", "China", "Brazil", "Australia"]
print(countryNames.sorted())

// reversed to reverse sort array values
let presidentsName = ["Bush", "Trump", "Obama", "Biden", "Clinton", "Reagan"]
let reversedPresidentsName = presidentsName.reversed()
print(reversedPresidentsName)


//: [Next](@next)
