//: [Previous](@previous)

import Foundation

class Pizza {
    private var toppings = [String]()
    func add(topping: String) {
        self.toppings.append(topping)
    }
}
var pizza = Pizza()
pizza.add(topping: "Mushrooms")


//: [Next](@next)
