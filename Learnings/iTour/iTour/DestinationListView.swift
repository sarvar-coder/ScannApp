//
//  DestinationListView.swift
//  iTour
//
//  Created by Sarvar Boltaboyev on 08/06/25.
//
import SwiftData
import SwiftUI

struct DestinationListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var destinations: [Destination]
    
    init(_ sort: SortDescriptor<Destination>, _ searchString: String) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        },
                              sort: [sort])
    }
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestination)
        }
    }
    private func deleteDestination(_ indeSet: IndexSet) {
        indeSet.forEach {
            let destination = destinations[$0]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListView(SortDescriptor(\Destination.name), "Qir")
}
