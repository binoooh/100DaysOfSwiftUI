//
//  ReadAndWriteExampleView.swift
//  BucketList
//
//  Created by Vinz on 6/21/25.
//

import SwiftUI

struct ReadAndWriteExampleView: View {
    var body: some View {
        Button("Read and Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")

            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url, encoding: .utf8)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ReadAndWriteExampleView()
}
