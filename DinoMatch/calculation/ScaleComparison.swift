//
//  ScaleComparison.swift
//  calculation
//
//  Created by Ari Guzzi on 10/29/24.
//

import SwiftUI
import Foundation

struct ScaleComparison: View {
    var dinosaurs: [Dinosaur]
    var userHeight: Double
    var selectedDinosaurIndex: Int
    let maxFrameHeight: CGFloat = 200
    var body: some View {
            let dinosaurHeight = dinosaurs[selectedDinosaurIndex].height
            let isDinosaurTaller = dinosaurHeight >= userHeight
            let maxDinosaurHeight = max(dinosaurHeight, userHeight)
            let dinosaurScaleFactor = dinosaurHeight / maxDinosaurHeight
            let userScaleFactor = userHeight / maxDinosaurHeight
            let scaleForDinosaur = isDinosaurTaller ? maxFrameHeight : maxFrameHeight * dinosaurScaleFactor
            let scaleForUser = isDinosaurTaller ? maxFrameHeight * userScaleFactor : maxFrameHeight
            return ZStack(alignment: .bottom) {
                Image(dinosaurs[selectedDinosaurIndex].imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: scaleForDinosaur, alignment: .bottom)
                Image("whiteboy")
                    .resizable()
                    .scaledToFit()
                    .frame(height: scaleForUser, alignment: .bottom)
                    .background(Color.gray.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
}
func simplifyFraction(value: Double, precision: Double = 0.01, asMixedNumber: Bool = false) -> String {
    let sign = value.sign == .minus ? -1 : 1
    let absValue = abs(value)
    var numerator = Int(absValue)
    var denominator = 1
    var approx = Double(numerator) / Double(denominator)

    while abs(approx - absValue) > precision {

        denominator += 1
        numerator = Int(absValue * Double(denominator))
        approx = Double(numerator) / Double(denominator)
        // Adjust the denominator until the approximate fraction meets the precision requirement
    }
    // Find the greatest common divisor
    func gcd(firstNumber: Int, secondNumber: Int) -> Int {
        if secondNumber == 0 {
            return firstNumber
        } else {
            return gcd(firstNumber: secondNumber, secondNumber: firstNumber % secondNumber)
        }
    }
    let divisor = gcd(firstNumber: numerator, secondNumber: denominator)
    numerator /= divisor
    denominator /= divisor
    numerator *= sign
    if asMixedNumber && abs(numerator) >= denominator {
        let wholePart = numerator / denominator
        let remainder = abs(numerator) % denominator
        if remainder == 0 {
            return "\(wholePart)" // If the remainder is zero, return the whole part only
        } else {
            return "\(wholePart) \(remainder)/\(denominator)" // Return as a mixed number
        }
    } else {
        return "\(numerator)/\(denominator)" // Return as a simple fraction
    }
}

func isMixedNumber(fraction: String) -> Bool {
    return fraction.contains(" ")
    // Check if the fraction contains a space, aka if its a mixed number
}
func convertToCM(feet: String, inches: String) -> Double {
    let dFeet = Double(feet) ?? 0.0  // ?? 0.0 = Default to 0.0 if no input
        let dInches = Double(inches) ?? 0.0
        return (dFeet * 30.48) + (dInches * 2.54)
    }
func convertToKPH(minutes: String, seconds: String, metric: Bool) -> Double {
    let dMinutes = Double(minutes) ?? 0.0
        let dSeconds = Double(seconds) ?? 0.0
        let totalHours = (dMinutes + dSeconds / 60.0) / 60.0
        if metric {
            return 1.0 / totalHours  // Speed in KPH from kpm
        } else {
            return (1.0 / totalHours) * 1.60934  // Convert speed from MPH to KPH
        }
}
