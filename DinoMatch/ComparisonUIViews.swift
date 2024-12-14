//
//  ComparisonUIViews.swift
//  calculation
//
//  Created by Ari Guzzi on 10/29/24.
//

import SwiftUI

struct ComparisonUIViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ComparisonUIViews()
}
struct MetricView: View {
    var metric: Bool
    @Binding var feet: String
    @Binding var inches: String
    @Binding var centimeters: String
    var body: some View {
        if metric == true { // logic to switch between metric and imperial
            TextField("Feet", text: $feet)
                .textFieldStyle(.roundedBorder)
            TextField("Inches", text: $inches)
                .textFieldStyle(.roundedBorder)
        } else {
            TextField("Centimeters", text: $centimeters)
                .textFieldStyle(.roundedBorder)
                .padding(4)
        }
    }
}
struct DropDownMenu: View {
    var dinosaurs: [Dinosaur]
    @Binding var selectedDinosaurIndex: Int
    var body: some View {
        VStack {
            Menu(dinosaurs[selectedDinosaurIndex].name) {
                ForEach(dinosaurs.indices, id: \.self) { index in
                    Button(dinosaurs[index].name) {
                        selectedDinosaurIndex = index
                    }
                }
            }
        }
        .padding()
        .background(Color.orange.opacity(0.8))
        .cornerRadius(10)
        .accentColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .shadow(color: .gray, radius: 5, x: 0, y: 2)
    }
}
struct IsCalculatedView: View {
    var heightFraction: String
    var dinosaurs: [Dinosaur]
    var selectedDinosaurIndex: Int
    var speedFraction: String
    var userHeight: Double
    var body: some View {
        if dinosaurs[selectedDinosaurIndex].height != 0 {
            Text("You are \(heightFraction) the height of a \(dinosaurs[selectedDinosaurIndex].name)!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
        } else {
            Text("Invalid input: Dinosaur height cannot be zero.")
                .font(.headline)
        }
        if dinosaurs[selectedDinosaurIndex].speed != 0 {
            let dinoIndexName = dinosaurs[selectedDinosaurIndex].name
            Text("You can run \(speedFraction) the speed of a \(dinoIndexName)!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            if isMixedNumber(fraction: speedFraction) {
                Text("You could outrun a \(dinosaurs[selectedDinosaurIndex].name) chasing you!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            } else {
                Text("You could not outrun a \(dinosaurs[selectedDinosaurIndex].name) chasing you :(")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
        } else {
            Text("Invalid input: Dinosaur speed cannot be zero.")
                .font(.headline)
        }
        ScaleComparison(dinosaurs: dinosaurs,
                        userHeight: userHeight,
                        selectedDinosaurIndex: selectedDinosaurIndex)
    }
}
struct PromptsView: View {
    @Binding var minutes: String
    @Binding var seconds: String
    var metric: Bool
    var body: some View {
        if metric == true {
            Text("What is your fastest mile?")
        } else {
            Text("What is your fastest kilometer?")
        }
        HStack {
            TextField("Minutes", text: $minutes)
                .textFieldStyle(.roundedBorder)
            TextField("Seconds", text: $seconds)
                .textFieldStyle(.roundedBorder)
        }
        Text("Select a dinosaur!")
    }
}
struct TopTitlesView: View {
    @Binding var metric: Bool
    var body: some View {
        Text("Dinosaur Height Calculator!")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding(.top, 100.0)
        IsMetric(metric: $metric)
            .padding(4)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .frame(width: 120)
        Text("What is your height?")
    }
}
struct LinearGradientView: View {
    var body: some View {
        LinearGradient(
            colors: [Color.green, Color.yellow],
            startPoint: .top, endPoint: .bottom)
    }
}
struct ResultView: View {
    var result: DinosaurResult
    var dinosaurPersonalities: [DinosaurPersona]
    var body: some View {
        VStack {
            Text("Congratulations!\nYou are most like a \(result.name)!!!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            Text(result.personality)
                .multilineTextAlignment(.center)
                .padding()
            Image(dinosaurPersonalities[result.index].name)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            NavigationLink("Compare yourself to some dinosaurs!") {
                DinosaurComparison()
            }
            .foregroundColor(.white)
            .font(.title2)
            .fontWeight(.medium)
            .frame(width: 140, height: 140)
            .background(
                Circle()
                    .fill(Color.teal))
        }
    }
}
