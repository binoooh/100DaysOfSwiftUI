//: [Previous](@previous)

import Foundation

// Closures are anonymous functions

func greetUser() {
    print("Hello from the playground!")
}

// To copy a function you don't need parenthesis
// If you put parenthesis it would be executing the function
// And assigning the value to the variable
var greetCopy = greetUser

// Or with function types
// Here greetCopy2 has no parameter and returns Void
var greetCopy2: () -> Void = greetUser

// Creating a closure as anonymous functions
let sayHello = {
    print("Hello from a closure!")
}

// Closure uses the "in" keyword to mark the end of the parameter list
// and start of the closure's body itself
// Below is a closure that accepts a String parameter and returns a String and assign to a constant
let greetMe = { (name: String) -> String in
    "Hi \(name)!"
}
// We can now use the constant like this..
//print(greetMe("Alice"))

// In Swift you can pass functions as parameters using "by" parameter
let teams = ["Lakers", "Bulls", "Nuggets", "Wizards", "Warriors"]

// This is a standard function
func getTeamSorted(name1: String, name2: String) -> Bool {
    if name1 == "Lakers" {
        return true
    } else if name2 == "Lakers" {
        return false
    }
    return name1 < name2
}

// Some functions as above that accepts other functions using "by" parameter i.e. sorted()
let getLeadingTeam = teams.sorted(by: getTeamSorted)    // we sort the team array using getTeamSorted function then assign the value to a constant
//print("Without closure: \(getLeadingTeam)")

// If we are to use Closures, we can perform the sorting inside the Closure
let getTopTeam = teams.sorted { (name1: String, name2: String) -> Bool in
    if name1 == "Lakers" {
        return true
    } else if name2 == "Lakers" {
        return false
    }
    return name1 < name2
}
//print("With closure: \(getTopTeam)")

// Here's a standard function that accepts a String and an Double
func pay(user: String, amount: Double) {
    // code here
}

// Here's a Closure that's exactly the same as above
// Closure parameters are inside the curly braces to avoid confusing Swift
let pay = { (user: String, amount: Double) in
    // code here
}

// Returning values from a Closure
// Here's a closure that accepts a single parameter and returns nothing
let sleep = { (name: String) in
    print("Sleep \(name)")
}

// Here's a closure that accepts a single parameter and returns a Boolean value
let walk = { (name: String) -> Bool in
    return name == "Joe" ? true : false
}

// Closure without parameter and returns nothing
let blink = { () in
}

// This is a Closure same as above no parameter returns nothing
let readBooks = {
//    print("Read books")
}

// Closure with no parameter and returns a value
let jump = { () -> String in
    return "Jump"
}

let work = { (hours: Int) -> Int in
    var work: Int = 0
    for i in hours...8 {
        work = i * i
    }
    return work
}
//print("I worked \(work(2)) hours")

// With Trailing Closures we can ommit parameter names and return types

// This closure is same as above but without parameter names and return types
// Swift automatically knows what parameter type and return type
// depending on the operation defined in a Closure
let work2 = { hours in
    var work: Int = 0
    for i in hours...8 {
        work = i * i
    }
    return work
}
//print("I worked \(work2(2)) hours")

let sortedTrailing = { a, b in
    if a == "Bulls" {
        return true
    } else if b == "Bulls" {
        return false
    }
    
    return a < b
}

// With Short-Hand sytax we use $0 $1 and so-fort
// But this is not recommended specially if you have
// more than two parameters i.e. $0, $1, $2, $3
let sortedShortHand = {
    if $0 == "Bulls" {
        return true
    } else if $1 == "Bulls" {
        return false
    }
    return $0 < $1
}

// The best place to use short-hand closures is when passing
// the clossure to another functions
// Below is read as paramA < paramB which returns true
let reverseSort = teams.sorted{ $0 > $1 }

// This will return values string starting with W
let wTeam = teams.filter{ $0.hasPrefix("W") }

// This will return uppercased values
let uppercasedTeam = teams.map{ $0.uppercased()}

// A Dictionary of payers
let payer = [
    "Joe": true,
    "Mary": false,
    "Sam": true
]

// This will return dictionaries having true values
let trueOnly = payer.filter { $0.value == true }
//print(trueOnly)

/****************************
    Closure function parameters
***********************************************/

// Here’s a function that generates an array of integers
// by repeating a function a certain number of times:

// makeArray is a function, that has two parameters and returns an array of Integers
// size is the 1st parameter that accepts an Integer
// generator() is the 2nd parameter accepts no parameter and returns and Integer
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var nums = [Int]()              // create a new array of Integer variable
    for i in 0..<size {             // loop up to the value of size parameter
        let newNum = generator()    // call generator() function and return the value to a constant
        nums.append(newNum)         // appendrail the value returned by generator() function to the array of Integer variable
    }
    return nums                     // return the values of the array of Integers
}


// We can call makeArray like below
let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}
//print(rolls)

// We can also use makeArray with dedicated functions
func generateNumber() -> Int {
    Int.random(in: 1...20)
}
let newRolls = makeArray(size: 50, using: generateNumber)   // This calls generateNumber to fill the makeArray nums array 50x
//print(newRolls)

// Closures can be delcared with multiple trailing closures
// Here's a function that accepts 3 functions as parameters
func learnStuffs(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("Learn SwiftUI")
    first()
    print("Learn Python")
    second()
    print("Learn Pentesting")
    third()
}

// This calls the function above passing multiple trailing Closures
learnStuffs{
    print("I know SwiftUI")     // this is passed to the first() function parameter
} second: {
    print("I know Python")      // this is passed to the second() function parameter
} third: {
    print("I know Pentesting")  // this is passed to the third() function parameter
}


let awesomeTalk = {
    print("Here's a great talk!")
//    return true
}
func deliverTalk(name: String, type: () -> Void) {
    print("My talk is called \(name)")
    type() // type is a function parameter that accepts no parameter and returns nothing
}
deliverTalk(name: "My Awesome Talk", type: awesomeTalk)

let learnSwift = {
    print("Closures are like functions")
}
learnSwift()

//: [Next](@next)
