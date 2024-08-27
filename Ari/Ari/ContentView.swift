//
//  ContentView.swift
//  Ari
//
//  Created by Ari Guzzi on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "airplane")
                .padding([.top, .leading])
                .imageScale(.large)
                .foregroundStyle(.mint)
            Text("Hello, world!")
                .background{
                    Color.blue
                }
                .padding(70)
                .background{
                    Color.mint
                }
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 5)
                })
                .underline(true, color: .blue)
                .foregroundStyle(.red)
                .font(.largeTitle)
                .fontWeight(.medium)
                .onAppear{
                    print("hello")
                }
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
