//
//  ContentView.swift
//  Calculation
//
//  Created by Ari Guzzi on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    var bio = "Learn about how you compare to dinosaurs and what your dinosaur personality is!"
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradientView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    Text("DinoMatch!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("🦖🦕")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    Text(bio)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        NavigationLink("Dino Personality?") {
                            DinosaurPersonality(questions: quizQuestions)
                        }
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(width: 140, height: 140)
                        .background(
                            Circle()
                                .fill(Color.teal))
                        NavigationLink("Dino Comparison!") {
                            DinosaurComparison()
                        }
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(width: 140, height: 140)
                        .background(
                            Circle()
                                .fill(Color.indigo))
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
