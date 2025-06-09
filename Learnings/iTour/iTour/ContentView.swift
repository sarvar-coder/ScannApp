//
//  ContentView.swift
//  iTour
//
//  Created by Sarvar Boltaboyev on 08/06/25.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State var path = [Destination]()
    @State var sortOrder = SortDescriptor(\Destination.name)
    @State var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListView(sortOrder, searchText)
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self) { destination in
                EditDestinationView(destination: destination)
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem() {
                    Button("", systemImage: "plus", action: addDestination)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority))
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date, order: .reverse))

                        }
                        .pickerStyle(.inline)
                    }
                }

            }
        }
    }
    
    private func addSamples() {
        let xiva = Destination(name: "Xiva")
        let hazorasp = Destination(name: "Hazorasp")
        let qir = Destination(name: "Qir")
        
        modelContext.insert(xiva)
        modelContext.insert(hazorasp)
        modelContext.insert(qir)
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
    
}

#Preview {
    ContentView()
}
