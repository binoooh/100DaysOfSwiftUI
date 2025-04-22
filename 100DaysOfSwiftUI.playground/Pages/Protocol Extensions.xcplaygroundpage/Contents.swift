//: [Previous](@previous)

import Foundation

// Protocol extension allows you to provide default
// implementation for protocol methods. Reduces biolerplate
// and reduces repitive implementations
//
protocol Gadget {
    var gadgetType: String { get }
    func on()
    func off()
}

// With extension we create default implementation for protocol methods
extension Gadget {
    func on() {
        print("\(gadgetType) is on")
    }
    
    func off() {
        print("\(gadgetType) is off")
    }
}

// Without extension we need to write implementatio for protocol methods
// in every type such as Structs, Classes and Enums that conforms the protocol
// With protocol extension we can simply call it from an instance that conforms it

struct Phone: Gadget {
    let gadgetType: String
}

let iphone = Phone(gadgetType: "iPhone")
iphone.on()
iphone.off()

class Tablet: Gadget {
    let gadgetType: String
    
    init(gadgetType: String) {
        self.gadgetType = gadgetType
    }
}

let ipad = Tablet(gadgetType: "iPad")
ipad.on()
ipad.off()

//: [Next](@next)
