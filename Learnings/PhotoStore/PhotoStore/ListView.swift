//
//  ListView.swift
//  PhotoStore
//
//  Created by Sarvar Boltaboyev on 09/06/25.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query var photos: [Photo]
    var body: some View {
        List {
            ForEach(photos) { ph in
                
                if let image = ph.image {
                    image
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(.circle)
                } else {
                    Circle()
                        .fill(.red)
                        .frame(width: 48, height: 48)
                }
            }
        }
    }
}

#Preview {
    ListView()
}
