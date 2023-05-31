//
//  PlantDetailView.swift
//  LeafLifeBeta
//
//  Created by Shaan Janardhan on 5/22/23.
//

import Foundation
import SwiftUI

struct PlantDetailsView: View {
    var plant: Plant
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image(systemName: "leaf.fill")
                .font(.system(size: 200))
                .foregroundColor(.green)
                .rotationEffect(.degrees(isAnimating ? -10 : 10))
                .animation(Animation.easeInOut(duration: 0.2).repeatCount(3))
            
            Text(plant.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Text("Days until watering(days): \(plant.daysUntilWatering)")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(String(format: "Water needed(L): %.2fL", plant.waterNeeded))
                .font(.headline)
                .foregroundColor(.green)
            
            Text(String(format: "Sunlight required: %.0f hours", plant.sunlightRequired))
                .font(.headline)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
        .onAppear {
            isAnimating = true
        }
        .onDisappear {
            isAnimating = false
        }
        .contextMenu {
            Button(action: {
                // Remove the plant
                removePlant(withID: plant.id)
            }) {
                Label("Remove", systemImage: "trash")
            }
        }
    }
    
    private func removePlant(withID id: UUID) {
        // Remove the plant from the store or perform any other necessary action
    }
}
