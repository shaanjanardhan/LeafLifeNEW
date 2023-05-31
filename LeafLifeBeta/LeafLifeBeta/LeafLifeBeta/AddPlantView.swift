//
//  AddPlantView.swift
//  LeafLifeBeta
//
//  Created by Shaan Janardhan on 5/22/23.
//

import Foundation
import SwiftUI
import Combine
struct AddPlantView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var plantStore: PlantStore
    
    @State private var plantName = ""
    @State private var frequency = ""
    @State private var waterNeeded = ""
    @State private var sunlightRequired = ""
    @State private var temperatureRange = ""
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Plant Details")) {
                    TextField("Plant Name", text: $plantName)
                    
                    TextField("Frequency(Days)", text: $frequency)
                        .keyboardType(.numberPad)
                        .modifier(NumberTextFieldModifier(formatter: formatter, text: $frequency))
                    
                    TextField("Water Needed(Liters)", text: $waterNeeded)
                        .keyboardType(.decimalPad)
                        .modifier(NumberTextFieldModifier(formatter: formatter, text: $waterNeeded))
                    
                    TextField("Sunlight Required(Hours)", text: $sunlightRequired)
                        .keyboardType(.decimalPad)
                        .modifier(NumberTextFieldModifier(formatter: formatter, text: $sunlightRequired))
                    
                    
                }
                
                Section {
                    Button("Save Plant") {
                        savePlant()
                    }
                }
            }
            .navigationTitle("Add Plant")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func savePlant() {
        guard let frequencyValue = Int(frequency),
              let waterNeededValue = Double(waterNeeded),
              let sunlightRequiredValue = Double(sunlightRequired),
              !plantName.isEmpty else {
            return
        }
        
        let plant = Plant(name: plantName,
                          wateringFrequency: frequencyValue,
                          waterNeeded: waterNeededValue,
                          sunlightRequired: sunlightRequiredValue,
                          temperatureRange: temperatureRange)
        
        plantStore.addPlant(plant)
        presentationMode.wrappedValue.dismiss()
    }
}


struct NumberTextFieldModifier: ViewModifier {
    let formatter: NumberFormatter
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .onReceive(JustificationPublisher(text: text)) { newValue in
                let filtered = newValue.filter { $0.isNumber }
                if filtered != newValue {
                    withAnimation {
                        text = filtered
                    }
                }
            }
    }
}

struct JustificationPublisher: Publisher {
    typealias Output = String
    typealias Failure = Never
    
    private let subject: CurrentValueSubject<String, Never>
    
    init(text: String) {
        subject = CurrentValueSubject<String, Never>(text)
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        subject.receive(subscriber: subscriber)
    }
}
