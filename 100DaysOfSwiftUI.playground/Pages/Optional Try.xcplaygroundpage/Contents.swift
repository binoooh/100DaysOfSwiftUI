//: [Previous](@previous)

import Foundation

// If we want to check if a function has succeeded or failed
// We use optional try? to have the failed function return an optional value
// If the function ran without throwing any errors then the optional will contain the return value,
// but if any error was thrown the function will return nil.
enum UserError: Error {
    case badID, networkFailed
}

// here getUser always throw an error for testing purposes
func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

// We normally use do try catch for throwing an error if it a function fails
do {
    let oldUser = try getUser(id: 23)
    print(oldUser)
} catch {
//    print("Error: \(error)")
}

// But if we want to return an optional rather than throwing an error we use optional try
// here optional try? makes getUser return an optional an string which is nil if a function error was thrown
if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

// if we want to return a default value we can use nil coalescing
// which means “attempt to get the return value from this function,
// but if it fails use this default value instead.”

// here we try getUser, if it throws an error, we assign Anonymous to newUser
let newUser = (try? getUser(id: 23)) ?? "Anonymous"
print("New User: \(newUser)")

//: [Next](@next)
