//: [Previous](@previous)

import Foundation

enum carMake {
    case toyota, honda, nissan, mazda, volkswagen,  kia, ford, chevy, bmw, audi, unknown
}

var car = carMake.toyota

switch car {
case .toyota:
    print("Toyota is a good car")
    fallthrough
case .honda:
    print("Honda is a good car")
    fallthrough
case .audi:
    print("Audi is a good car")
case .ford:
    print("Ford is a good car")
case .bmw:
    print("BMW is a good car")
default:
    print("Not a good car")
}

//: [Next](@next)
