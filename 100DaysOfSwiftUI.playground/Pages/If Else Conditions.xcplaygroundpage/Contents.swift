//: [Previous](@previous)

import Foundation

let age : Int = 18
let temp : Int = 25
let gameScore : Int =  104
let gameOver : Bool = true

// if else
if age >= 18
{
    print("You are an adult.")
}
else
{
    print("You are a minor.")
}

// if else if else
if temp < 30
{
    print("It is cold.")
} else if temp > 30 {
    print("It is hot")
} else {
    print("It's neutral")
}

// logical and oper in if else conditions
if temp > 20 && temp < 40
{
    print("It's a nice day")
}

// logical or oper
if gameScore > 100 || gameOver == true
{
    print("Game Over")
}

// Enums
enum Weather {
    case sunny, cloudy, rainy, snowy, windy
}

let weather =  Weather.cloudy

if weather == .sunny && weather == .windy
{
    print("It's happy day")
} else if weather == .cloudy || weather == .rainy {
    print( "It's a gloomy day")
} else {
    print("It's shovel day")
}

//: [Next](@next)
