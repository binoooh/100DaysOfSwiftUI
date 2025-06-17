//
//  UserDetailsView.swift
//  SocialNetwork
//
//  Created by Vinz on 6/16/25.
//

import SwiftUI

struct UserDetailsView: View {
    
    @Binding var user: [User]
    
    var body: some View {
        List {
            ForEach(user, id: \.id) { user in
                Text(user.company)
            }
        }
    }
}

//#Preview {
//    UserDetailsView()
//}
