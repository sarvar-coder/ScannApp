//
//  EditDestinationView.swift
//  iTour
//
//  Created by Sarvar Boltaboyev on 08/06/25.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    
    @Bindable var destination: Destination
    @State private var newSigght = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("", selection: $destination.priority) {
                    Text("Low").tag(0)
                        
                    
                    Text("Medium").tag(1)
                    Text("High").tag(2)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { Text($0.name) }
                
                HStack {
                    TextField("New Sight Name", text: $newSigght)
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addSight() {
        guard !newSigght.isEmpty else { return }
        
        let sight = Sight(name: newSigght)
        destination.sights.append(sight)
        newSigght = ""
        
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destination", details: "Example Deatils are expanded as they are vertically edited.")
        
        return
//        NavigationStack {
            EditDestinationView(destination: example)
                .modelContainer(container)
//        }
    } catch {
        fatalError(error.localizedDescription)
    }
}
