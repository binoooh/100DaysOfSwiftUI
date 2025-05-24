//
//  MoonItemView.swift
//  Planets
//
//  Created by Vinz on 5/24/25.
//

import SwiftUI

struct MoonItemView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let moon: Moon
    
    //@Binding var isShowingMoonItemView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    gradient:
                        Gradient(colors: [.black, .black, .white]), startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()
            
                    VStack {
                        
                        Text(moon.name)
                            .font(.title.bold())
                            .fontDesign(.monospaced)
                            .foregroundStyle(.white)
                            .shadow(radius: 20)
                            .padding(.bottom)
                        
                        Image(moon.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                        
                        Text(moon.description)
                            .font(.title2)
                            .textScale(.default)
                            .foregroundStyle(.white)
                            .frame(width: 300)
                            .padding(.top)
                    }
                }
                .frame(height: .infinity)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .imageScale(.large)
                            .frame(width: 44, height: 44)
                            //.padding([.horizontal, .vertical])
                            .onTapGesture {
                                dismiss()
                            }
                        
                    }
                })
            }
        }
        
    
}

#Preview {
    
    let moons: [String: Moon] = Bundle.main.decode("moons.json")
    
    MoonItemView(moon: moons["io"]!)
        .preferredColorScheme(.dark)
}
