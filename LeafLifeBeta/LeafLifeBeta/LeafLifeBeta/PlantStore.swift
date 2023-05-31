//
//  PlantStore.swift
//  LeafLifeBeta
//
//  Created by Shaan Janardhan on 5/22/23.
//

import Foundation
import SwiftUI

class PlantStore: ObservableObject {
    @Published var plants: [Plant] = []
    
    func addPlant(_ plant: Plant) {
        plants.append(plant)
    }
    
    func removePlant(withID id: UUID) {
        plants.removeAll { $0.id == id }
    }
}
