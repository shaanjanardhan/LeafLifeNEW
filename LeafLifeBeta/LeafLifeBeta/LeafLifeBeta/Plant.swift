//
//  File.swift
//  LeafLifeBeta
//
//  Created by Shaan Janardhan on 5/22/23.
//

import Foundation
import SwiftUI

struct Plant: Identifiable {
    let id = UUID()
    var name: String
    var wateringFrequency: Int
    var waterNeeded: Double
    var sunlightRequired: Double
    var temperatureRange: String
    
    var daysUntilWatering: Int {
        let calendar = Calendar.current
        let nextWateringDate = calendar.date(byAdding: .day, value: wateringFrequency, to: Date())
        let daysLeft = calendar.dateComponents([.day], from: Date(), to: nextWateringDate!).day
        return daysLeft ?? 0
    }
    
    var isWateringDue: Bool {
        return daysUntilWatering == 0
    }
}

