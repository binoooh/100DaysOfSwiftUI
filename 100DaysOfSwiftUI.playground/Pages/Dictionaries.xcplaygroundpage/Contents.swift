//: [Previous](@previous)

import Foundation

// creating and initializing a dictionary
let employeeNames = ["name": "Joe", "title": "QA", "location": "Canada"]

// accessing dictionaries by key
print("Name: \(employeeNames["name"] ?? "Not Found")")
print("Title: \(employeeNames["title"] ?? "Not Found")")
print("Location: \(employeeNames["location"] ?? "Not Found")")

let birthDays = [
    "Joe": "1980-01-01",
    "Alice": "1990-02-02",
    "Bob": "1970-03-03",
    "David": "1960-04-04"
]
// setting default value if not found
print("Birthday of Joe: \(birthDays["Joe", default: "Not Found"])")

// creating an empty dictionary with explicit string key and integer value
var nbaStars = [String: Int]()
nbaStars["Kobe Bryant"] = 24
nbaStars["Michael Jordan"] = 23
nbaStars["Lebron James"] = 23
print(nbaStars["Kobe Bryant"] ?? 0)

// assigning a new value to a key in a dictionary
var dogs = [String: String]()
dogs["Maya"] = "Jack Russell Terrier"
dogs["Max"] = "Labrador"
dogs["Max"] = "Golden Retriever"
print("Max is a \(dogs["Max"] ?? "Not Found")")
print("Maya is a \(dogs["Maya"] ?? "Unknown")")

// dictionaries helper functions are same as with arrays i.e. count(), removeAll()
// remove a value of a key
dogs.removeValue(forKey: "Maya")
print("Maya is a \(dogs["Maya", default: "Unknown"])")


//: [Next](@next)

