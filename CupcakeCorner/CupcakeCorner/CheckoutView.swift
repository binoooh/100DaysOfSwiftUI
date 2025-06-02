//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Vinz on 6/1/25.
//

import SwiftUI

struct CheckoutView: View {
    
    var order = Order()
    
    @State private var confirmationMessage = ""
    @State private var isShowingConfirmation = false
     
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank You!", isPresented: $isShowingConfirmation) {
            Button("Ok") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order!")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // Day 52 - Coding Challenge
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                
                if statusCode == 200 {
                    let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                    
                    confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                    isShowingConfirmation = true
                } else {
                    print("Unable to connect to server (status code: \(statusCode))")
                }
            }
            
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
