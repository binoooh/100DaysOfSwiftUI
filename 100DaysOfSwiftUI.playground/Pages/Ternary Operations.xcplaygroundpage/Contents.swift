//: [Previous](@previous)

import Foundation

let jumps = 12


// ternary oper  (What)        (True)       (False)
let finished = jumps >= 12 ? "You win!" : "You lose!"
print("Finished: \(finished)")

enum Theme {
    case light
    case dark
}

let theme = Theme.light

let themColor = (theme == .light) ? "white" : "black"
print("Theme color: \(themColor)")

// you can use ternary ops inside print function
let phone = "iPhone"
print(phone == "Android" ? "Not an iPhone" : "iPhone")

//: [Next](@next)
