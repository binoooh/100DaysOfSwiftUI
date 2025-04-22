//: [Previous](@previous)

import Foundation

// We can set default values in a function i.e. Int = 12 as an aditional argument
func printTimesTables(from number: Int, to: Int = 12) {
    for i in 1...to {
        print("\(number) times \(i) is \(number * i)")
    }
}

// We can now use this function passing both values to each parameters
printTimesTables(from: 12, to: 40)
// Or  just passing a value to the 1st parameter since the 2nd parameter has a default value
printTimesTables(from: 3)

func printAllCharacters(characters chars: [String], isSorted: Bool = false) {
//    let value = isSorted ? chars.sorted() : chars
    print(isSorted ? chars.sorted() : chars)
}

// We can call the function by just specifying values to the parameter without default values
printAllCharacters(characters: ["b","t","p","w","p"])
// Or we can call the function by passing values to paramters with default value
printAllCharacters(characters: ["b","t","p","w","p"], isSorted: true)

//: [Next](@next)
