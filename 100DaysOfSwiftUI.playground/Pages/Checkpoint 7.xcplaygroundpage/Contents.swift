//: [Previous](@previous)

import Foundation

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    
    func speak() -> String {
        return "Woof! I am a dog!"
    }
}

final class Corgi: Dog {
    
    override func speak() -> String {
        return "Yap! I am a corgi!"
    }
}

final class Poodle: Dog {
    
    override func speak() -> String {
        return "Yip! I am a poodle!"
    }
}

class Cat: Animal {
    let isTame: Bool
    
    func speak() -> String {
        return "Meow! I am a cat!"
    }
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
}

final class Persian: Cat {
    
    override func speak() -> String {
        return "Meeeoooooww! I am a persian cat!"
    }
}

final class Lion: Cat {
    
    override func speak() -> String {
        return "Rooaarr!! I am a Lion!"
    }
}

let corgi = Corgi(legs: 4)
print(corgi.speak())

let poodle = Poodle(legs: 4)
print(poodle.speak())

let persian = Persian(isTame: true)
print(persian.speak())

let lion = Lion(isTame: false)
print(lion.speak())
//: [Next](@next)
