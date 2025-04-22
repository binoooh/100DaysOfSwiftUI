//: [Previous](@previous)

import Foundation

// for loop
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Platform: \(os)")
}

// number ranges
for i in 1...5 {
    print("Number: \(i)")
}

for i in 1..<5 {
    print("Number: \(i)")
}

var quote = "I am wealthy"

// using _
for _ in 1...5 {
    quote += " !"
}

print("Quote: \(quote)")

// looping arrays
let names = ["John", "Tom", "Mary", "Jane"]
print(names[1...])

// while loops

var countdown = 10

while countdown > 0 {
    print("Countdown: \(countdown)")
    countdown -= 1
}

print("Blast off!")

var roll = 0

while roll != 20  {
    roll = Int.random(in: 0...20)
    print("I rolled a \(roll)")
}

print("Critical Hit!!")

// Break and Continue
let fileNames = ["notes.txt", "doc.doc", "pic.jpg"]

for fileName in fileNames {
   if fileName.hasSuffix(".jpg") == false {
        continue
    }
    print("Found picture: \(fileName)")
}

let num1 = 4
let num2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: num1) && i.isMultiple(of: num2) {
        multiples.append(i)
    }
    if multiples.count == 10 {
        break
    }
}

print("Multiples: \(multiples)")
//: [Next](@next)
