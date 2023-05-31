//
//  ContentView.swift
//  LeafLifeBeta
//
//  Created by Shaan Janardhan on 5/16/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var plantStore = PlantStore()
    @State private var isPresentingAddPlantView = false
    @State private var selectedPlant: Plant?
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                    .padding(.bottom, 20)
                
                Text("LeafLife")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                Button(action: {
                    isPresentingAddPlantView = true
                }) {
                    Text("Add Plant")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isPresentingAddPlantView) {
                    AddPlantView(plantStore: plantStore)
                }
                
                List {
                    ForEach(plantStore.plants) { plant in
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "leaf.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.green)
                                Text(plant.name)
                                    .font(.headline)
                                    .foregroundColor(plant.isWateringDue ? .red : .primary)
                            }
                            .onTapGesture {
                                selectedPlant = plant
                            }
                            .contextMenu {
                                Button(action: {
                                    removePlant(withID: plant.id)
                                }) {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(action: {
                                    removePlant(withID: plant.id)
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                            
                            if plant.isWateringDue {
                                Text("Water this plant⚠️⚠️⚠️")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            } else {
                                Text("Days until watering: \(plant.daysUntilWatering)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(item: $selectedPlant) { plant in
                PlantDetailsView(plant: plant)
            }
        }
    }
    
    private func removePlant(withID id: UUID) {
        plantStore.removePlant(withID: id)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
