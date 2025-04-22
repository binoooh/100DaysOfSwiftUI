//: [Previous](@previous)

import Foundation

//
struct User {
    let name: String
    let age: Int? // here age is optional it may contain a value or nil
}

// We create a user with age = nil
let user = User(name: "John", age: nil)

// To unwrap optionals we can do the following

// Using if let conditions to unwrap optionals
// This will only run if user.age has a value inside the condition
if let age = user.age {
    print("User's age is \(age)")
} else {
    print("User's age is not provided")
}

// Using guard let else to unwrap optionals
// Guard let will exit the function if the check fails i.e. age is nil
func checkAge(age: Int?) {
    // Here if age is nil we exit the function
    guard let age = age else {
        print("No Age provided!")
        return
    }
    // Here if age above has a value we run the code below
    if age >= 18 {
        print("You are \(age) years old")
    }
}

// Here we declare a closure with optionals
// and unwrapped it with guard
let age1 = { (age: Int?) in
    guard let age = age else {
        return
    }
    
    print("You are \(age) years old")
}

// Using nil coalescing
// With nil coalescing, optionals will be given a value instead of nil
// Here age2 will have a value of 0 and age2 is now a non-optional property
let age2 = user.age ?? 0
print("User's age is \(age2)")

// We can use nil coalescing with random values like below
let tvShows = ["Game of Thrones", "The Wire", "Breaking Bad"]
let faveShow = tvShows.randomElement() ?? "No Favorite TV Show" // here instead of randomElement returning nil, we return a value


struct Book {
    let title: String
    let author: String
    let sold: Int?
}

let book = Book(title: "The Alchemist", author: "Paulo Coelho", sold: nil)
let sold = book.sold ?? 0 // we give sold 0 if nil

func first() -> String? {
    return nil
}

func second() -> String? {
    return nil
}
// We can also chain nil coalescing
var result = first() ?? second() ?? "Default"



//: [Next](@next)
