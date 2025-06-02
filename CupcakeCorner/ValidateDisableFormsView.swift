//
//  ValidateDisableFormsView.swift
//  CupcakeCorner
//
//  Created by Vinz on 6/1/25.
//

import SwiftUI

struct ValidateDisableFormsView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    var disabledForm: Bool {
        username.count < 5 || password.count < 8
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username:", text: $username)
                TextField("Password:", text: $password)
            }
            Section {
                Button("Login") {
                    print("Login")
                }
            }
            .disabled(disabledForm)
        }
    }
}

#Preview {
    ValidateDisableFormsView()
}
