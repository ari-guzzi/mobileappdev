//
//  IsMetric.swift
//  calculation
//
//  Created by Ari Guzzi on 12/13/24.
//

import SwiftUI

struct IsMetric: View {
    @Binding var metric: Bool
    var body: some View {
        Button(metric ? "Imperial" : "Metric") {
                    metric.toggle()
                }
        .padding(8)
        .background(Color.blue.opacity(0.8))
        .cornerRadius(10)
        .accentColor(.white)
        .shadow(color: .gray, radius: 5, x: 0, y: 1)
    }
}
