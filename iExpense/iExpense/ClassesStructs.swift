//
//  ClassesStructs.swift
//  iExpense
//
//  Created by @binoooh on 5/10/25.
//

import SwiftUI

// classes needs to be Observable if you want SwiftUI to watch
// its contents when it changes
@Observable
class User {
    var email = "bino@gmail.com"
}

// structs on the other hand, SwiftUI automatically watches
// any changes in a struct
struct Name {
    var name = "Bino"
}

struct ClassesStructs: View {
    
    // name here is a new Name struct
    @State private var name = Name()
    
    // user here is a new User class
    @State private var user = User()
    
    
    var body: some View {
        VStack {
            Text("Email: \(user.email)")
            TextField("New Email:", text: $user.email)
        }
        .padding()
    }
}

#Preview {
    ClassesStructs()
}
