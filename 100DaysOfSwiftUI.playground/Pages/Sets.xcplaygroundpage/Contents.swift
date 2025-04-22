//: [Previous](@previous)

import Foundation

// sets are collection of unique data that are not duplicates
// it does not remember the position of the values

let dogos = Set([
    "Max",
    "Daisy",
    "Charlie",
    "Cooper",
    "Maya"])

print("Dogs: \(dogos)")

// we cannot append a value to a set but you can insert a value
var cats = Set<String>()
cats.insert("Kuting")
cats.insert("Muning")
cats.insert("Minging")
print("Cats: \(cats)")

// helper functions
print("No. of cats: \(cats.count)")
print("Sorted dogs: \(dogos.sorted())")




//: [Next](@next)
