//
//  DinosaurComparison.swift
//  calculation
//
//  Created by Ari Guzzi on 10/16/24.
//

import SwiftUI

struct DinosaurComparison: View {
    @State public var selectedDinosaurIndex = 0
    @State public var feet: String = ""
    @State public var inches: String = ""
    @State public var centimeters: String = ""
    @State public var minutes: String = ""
    @State public var seconds: String = ""
    @State public var metric = true
    @State public var userHeight: Double = 0.0
    @State public var heightFraction: String = "0/1"
    @State public var speedFraction: String = "0/1"
    @State public var isCalculated: Bool = false
    @State public var speedKPH: Double = 0.0
    var dinosaurs: [Dinosaur] = [
        Dinosaur(name: "pterodactyl", height: 300.0, imageName: "pterodactyl", speed: 108),
        Dinosaur(name: "spinosaurus", height: 609.6, imageName: "spinosaurus", speed: 11.3),
        Dinosaur(name: "stegosaurus", height: 430, imageName: "stegosaurus", speed: 17.7),
        Dinosaur(name: "t-rex", height: 365.76, imageName: "t-rex", speed: 72),
        Dinosaur(name: "triceratops", height: 298.704, imageName: "triceratops", speed: 32.2),
        Dinosaur(name: "velociraptor", height: 48.8, imageName: "velociraptor", speed: 40.2)
    ]
    var scaleRatio: Double {
        Double(heightFraction.components(separatedBy: "/").reduce(0.0) { (userHeight, value) in
            guard let num = Double(value) else { return userHeight }
            return userHeight == 0.0 ? num : userHeight / num
        })
    }
    var body: some View {
        ZStack {
            LinearGradientView()
            VStack(alignment: .leading) {
                ScrollView {
                    TopTitlesView(metric: $metric)
                    HStack {
                        MetricView(metric: metric, feet: $feet, inches: $inches, centimeters: $centimeters)
                    }
                    PromptsView(minutes: $minutes, seconds: $seconds, metric: metric)
                    DropDownMenu(dinosaurs: dinosaurs, selectedDinosaurIndex: $selectedDinosaurIndex)
                        .padding(.bottom)
                    Button(action: handleButtonAction) {
                        Image(systemName: "arrowshape.forward.circle.fill")
                            .font(.largeTitle)
                    }
                    if isCalculated {
                        IsCalculatedView(
                            heightFraction: heightFraction,
                            dinosaurs: dinosaurs,
                            selectedDinosaurIndex: selectedDinosaurIndex,
                            speedFraction: speedFraction,
                            userHeight: userHeight)
                    }
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    } // body
    func handleButtonAction() {
            if metric {
                let feetValue = Double(feet) ?? 0.0
                let inchesValue = Double(inches) ?? 0.0
                if feetValue > 0 || inchesValue > 0 {
                    userHeight = convertToCM(feet: feet, inches: inches)
                }
            } else {
                userHeight = Double(centimeters) ?? 0.0
            }
            if dinosaurs[selectedDinosaurIndex].height != 0 && userHeight > 0 {
                let heightRatio = userHeight / dinosaurs[selectedDinosaurIndex].height
                heightFraction = simplifyFraction(value: heightRatio, asMixedNumber: true)
            } else {
                heightFraction = "0/1"
            }
            let minutesValue = Double(minutes) ?? 0.0
            let secondsValue = Double(seconds) ?? 0.0
            if minutesValue > 0 || secondsValue > 0 {
                speedKPH = convertToKPH(minutes: minutes, seconds: seconds, metric: metric)
            }
            if dinosaurs[selectedDinosaurIndex].speed != 0 {
                let speedRatio = speedKPH / dinosaurs[selectedDinosaurIndex].speed
                speedFraction = simplifyFraction(value: speedRatio, asMixedNumber: true)
            } else {
                speedFraction = "0/1"
            }
            isCalculated = true
        }
}
#Preview {
    DinosaurComparison()
}
struct Dinosaur {
    var name: String
    var height: Double
    var imageName: String
    var speed: Double
}
