//: [Previous](@previous)

import Foundation

// enums solves the problem for data inconsistencies such as in array below
// where variable is initially days but then the value changes to month etc.
var day = "Monday"
day = "Tuesday"
day = "February"
day = "June 21"

// creating an enum
enum Day {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

print("Day today is \(Day.Monday)")
print("Day tomorrow is \(Day.Tuesday)")

// short hand way to create and initialize enums
enum Month {
    case January, February, March, April, May, June, July, August, September, October, November, December
}

var month = Month.April
// we can also use dot notation on enums
month = .December
month = .January


//: [Next](@next)
