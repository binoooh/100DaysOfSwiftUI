//: [Previous](@previous)

import Foundation

struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printAlbumDetails() {
        print("Album: \(title)")
        print("Artist: \(artist)")
        print("Year: \(year)")
    }
}

// When we use a Struct and set values to the struct it's called an initializer
// We are initializing the Struct and assigning the values to a variable or constant
let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printAlbumDetails()
wings.printAlbumDetails()

// If we are to modify the property in a Structs using a function inside it,
// We need to declare a mutating function

struct Employee {
    let name: String
    var vacationRemaining: Int
    
    // With mutating functions you can update the value of vacationRemaining
    // otherwise Swift will throw an error
    mutating func daysRemaining(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("\(name) still has \(vacationRemaining) vacation days")
        } else {
            print("\(name) can't go on a vacation for \(days) days")
        }
    }
}

// When using a mutating function in a Struct, we cannot assign the Struct to a constant
// Instead we assign the Struct to a variable
var pedro = Employee(name: "Pedro", vacationRemaining: 10)
pedro.daysRemaining(days: 5)
print(pedro.vacationRemaining)


// Struct with default values
struct allowedKids {
    var name: String
    var allowedAge = 18
    // checkAge is a method of allowedKids Struct
    func checkAge(age: Int) {
        if age >= allowedAge {
            print("\(name) is allowed because he is \(age) years old")
        } else {
            print("\(name) is not allowed because he is not \(allowedAge) or older")
        }
    }
}

// We can initialize Struct without the allowedAge because it already has an initialized value
let sam = allowedKids(name: "Sam")
//sam.allowedAge = 25
sam.checkAge(age: 25)
// We also iniitalize both overriding the initialized value in allowedAge
let bro = allowedKids(name: "Bro", allowedAge: 4)
bro.checkAge(age: 4)

// Structs getter and setter to update property values without memory storage
struct BankAccount {
    let name: String
    var availableBalance = 1000.0
    var withdrawnBalance = 0.0
        
    // This property auto calculates and returns a value
    var remainingBalance: Double {
        get {
            // getter here returns the available balance
            availableBalance - withdrawnBalance
        }
        set {
            // setter sets the value of available balance with a newValue.
            // newValue is a special Swift keyword for setters
            availableBalance = withdrawnBalance + newValue
        }
    }
}

var withdrawalAmount : Double = 0
var bob = BankAccount(name: "Bob", availableBalance: 100.0)
print("Bob's remaining balance is \(bob.remainingBalance) dollars")

withdrawalAmount = 10
bob.withdrawnBalance = withdrawalAmount
print("Bob withdraws \(withdrawalAmount) dollars")
print("Bob's remaining balance is \(bob.remainingBalance) dollars")

withdrawalAmount = withdrawalAmount + 20
bob.withdrawnBalance = withdrawalAmount
print("Bob withdaws \(withdrawalAmount) dollars")
print("Bob's remaining balance is \(bob.remainingBalance) dollars")

// Structs property observers
// We use property observers if we want Swift run something whenever we change it's property
struct Counter {
    var count = 0 {
        willSet {
            print("Current value: \(count)")
            print("About to set count to \(newValue)") // newValue is a special Swift variable
        }
        didSet {
            print("Just set count to \(count)")
            print("Old value: \(oldValue)") // oldValue is a special Swift variable
        }
    }
}

var counter = Counter()
counter.count = 10
counter.count = 20

// Custom initializers in Structs are set using init() { }
// Always make sure that properties have initialized values
struct Book {
    let author: String
    let title: String
    let sold: Int
    
    // initializer does not have a return type but it does return property values
    // If we are to initialize propoerties inside our custom initializer
    // memberwise initilizer is not allowed.
    // In the case below, we set sold to have a value hence Swift does not allow
    // let book = Book(author: "Ted", title: "Cats", sold: 20) -> memberwise initializer for sold is not allowed
    init(author: String, title: String) {
        self.author = author
        self.title = title
        sold = Int.random(in: 1...1000)
    }
}

let book1 = Book(author: "John", title: "The Alchemist")
print("The book \(book1.title) has sold \(book1.sold) copies")

// If we still want to use memberwise initializer even if we have custom initializer
// we use the extension keyword example below
struct Phones {
    var model: String
//    var price: Double = 0.0
}

extension Phones {
    init() {
        self.model = "Unknown" // here we initialize the property with a value
        print("Your phone is \(model)")
    }
}

// with extension we can still set the model value
let androidPhone = Phones(model: "Google Pixel")
print(androidPhone.model)

// we can also do this
let applePhone = Phones()
print(applePhone.model)

//: [Next](@next)
