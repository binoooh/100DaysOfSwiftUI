//: [Previous](@previous)

import Foundation

class Monster {
    let count: Int
    
    init(count: Int) {
        self.count = count
        print("Monster \(count) is created!")
    }
    // Here deinit is called automatically
    // when there are no more instance of the class
    deinit {
        print("Monster \(count) is dead!")
    }
}

for i in 1...3 {
    let monster = Monster(count: i)
    print("Monster \(i) is alive!")
    // here deinit is called since we are creating a new instance above
}

//: [Next](@next)
