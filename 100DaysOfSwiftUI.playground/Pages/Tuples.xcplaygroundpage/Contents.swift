//: [Previous](@previous)

import Foundation

// Tuples specifying variable names
func getUser() -> (name: String, age: Int) {
    (name: "John", age: 30)
}

let user = getUser()
print("User Name: \(user.name) is \(user.age) years old")

// Tuples without specifying variable names
func getRole() -> (name: String, role: String) {
    ("Joe", "iOS Developer")
}

let role = getRole()
print("\(role.name) is a \(role.role)")

// Tupes without variable name parameters
func getBooks() -> (String, String) {
    ("J.K. Rowling", "Harry Potter")
}

let books = getBooks()
print("\(books.0) wrote \(books.1)")

// Pulling Tuple data directly
func getMovie() -> (title: String, year: Int) {
    (title: "Inception", year: 2010)
}

// Destructuring tuples
let (title, year) = getMovie()
print("\(title) was released in \(year)")

// This is also okay if you don't need the 2nd returned value from a Tuple
let (title1, _) = getMovie()
print("My favorite movies is \(title1)")


//: [Next](@next)
