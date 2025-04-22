//: [Previous](@previous)

import Foundation

// Create enums of error messages
enum PasswordError: Error {
    case weak, short
}

// Throwing error in a function using throws keyword
func checkPassword(_ password: String) throws -> String {
    if password.count < 4 {
        throw PasswordError.short
    } else if password == "12345" || password == "password" {
        throw PasswordError.weak
    } else if password.count == 8 {
        return "Password is good"
    } else {
        return "Password is excellent"
    }
}

// Error handling is done using do try catch statements
do {
    let isPasswordGood = try checkPassword("12345678") // this will NOT throw an error
    print(isPasswordGood)
} catch {
    print("Error: \(error)")
}

do {
    let isPasswordtWeak = try checkPassword("password") // this will throw PasswordError.weak
    print(isPasswordtWeak)
} catch {
    print("Error: \(error)")
}

//: [Next](@next)
