//: [Previous](@previous)

import Foundation

/**
 Challenge 01 - Basic Closure Variable & Execution
 Goal: Understand basic closure syntax and assignment.
 1. Declare a Swift variable named greeter.
 2. Assign a closure to greeter that takes no parameters and returns Void.
 3. Inside the closure, print the string "Hello, Closure!".
 4,. Call the greeter closure to execute its code.
 */
var greeter : () -> Void = {
    print("Hello, Closure!")
}

/**
 Challenge 02 - Sorting with Closures
 Goal: Practice using closures with standard library functions like sorted().
 1. Create an array of integers: [5, 1, 9, 2, 8, 3].
 2. Use the sorted(by:) method to sort the array in descending order (largest to smallest).
 3. Provide the sorting logic using a closure. Try implementing it using:
    Full closure syntax with explicit types.
    Type inference.
    Shorthand argument names ($0, $1).
    Trailing closure syntax.
    Print the sorted array.
 */
var numbers: [Int] = [5, 1, 9, 2, 8, 3]
var sortNumberDescending: (Int, Int) -> Bool = {
    return $0 > $1
}

numbers.sort(by: sortNumberDescending)
print(numbers)

// Using shorthand argument names
let sortNum1 = numbers.sorted(by: { $0 > $1 })
print("Sorted (Shorthand): \(sortNum1)")

// Using trailing closure syntax (most common for the last closure argument)
let sortNum2 = numbers.sorted() { $0 > $1 }
print("Sorted (Trailing Closure): \(sortNum2)")

/**
 Challenge 03 - Mapping Values with Closures
 Goal: Use closures with the map function to transform array elements.
 1. Create an array of strings: ["apple", "banana", "cherry"].
 2. Use the map function to create a new array containing the lengths of each string in the original array.
 3. Provide the transformation logic using a closure (trailing closure syntax is common here).
 4. Print the resulting array of integers (e.g., [5, 6, 6]).
 */
let fruits = ["apple", "banana", "cherry"]
let fruitLengths = fruits.map { $0.count } // count the chars in each array values
print(fruitLengths) // prints [5, 6, 6]

/**
 Challenge 04 - Filtering with Closures
 Goal: Use closures with the filter function.
 1. Create an array of optional integers: [1, nil, 3, nil, 5, 6, nil, 8].
 2. Use the filter function to create a new array containing only the non-nil, even numbers from the original array.
 3. Provide the filtering logic using a closure. You might need to safely unwrap the optionals within the closure or use compactMap first.
 4. Print the resulting filtered array (e.g., [6, 8]).
 */
let optionalNumbers: [Int?] = [1, nil, 3, nil, 5, 6, nil, 8]

// Option #1
let nonNilEvenNumbers1 = optionalNumbers.compactMap { $0 }.filter { $0.isMultiple(of: 2) }

// Option #2
let nonNilEvenNumbers2 = optionalNumbers
    .compactMap { $0 }      // removes nil values
    .filter { $0 % 2 == 0 } // returns even numbers

// Option #3
let nonNilNumbers = optionalNumbers.compactMap { $0 }           // this returns non nil items from the array
let evenNumbersOnly = nonNilNumbers.filter { $0.isMultiple(of: 2) } // returns even numbers from the array
print(evenNumbersOnly) // prints [6, 8]

/**
 Challenge 06 - Capturing Values in Closures
 Goal: Understand how closures capture variables from their surrounding scope.
 1. Write a Swift function makeIncrementer(incrementAmount: Int) -> () -> Int.
 2. This function should define an inner variable total initialized to 0.
 3. The function should return a closure. This returned closure takes no arguments and returns an Int.
 4. Inside the returned closure, add incrementAmount (captured from the outer function) to total (also captured) and return the new total.
 5. Call makeIncrementer twice with different amounts (e.g., makeIncrementer(incrementAmount: 1) and makeIncrementer(incrementAmount: 5)) to create two different incrementer closures.
 6. Call each returned closure multiple times and print the results to observe that they maintain their own separate total state.
 */
func makeIncrementer(incrementAmount: Int) -> () -> Int {
    var total = 0   // This variable is captured by the returned closure
    let incrementClosure: () -> Int = {
        total += incrementAmount    // Captures both total and incrementAmount
        return total
    }
    return incrementClosure
}

// Create two incrementers with different step amounts
let incrementByOne = makeIncrementer(incrementAmount: 1)
let incrementByFive = makeIncrementer(incrementAmount: 5)

// Call them multiple times to see they maintain separate state
print("Increment by One:")
print(incrementByOne()) // Output: 1
print(incrementByOne()) // Output: 2
print(incrementByOne()) // Output: 3

print("\nIncrement by Five:")
print(incrementByFive()) // Output: 5
print(incrementByFive()) // Output: 10

// Calling incrementByOne again shows its state is independent
print("\nIncrement by One again:")
print(incrementByOne()) // Output: 4

//: [Next](@next)
