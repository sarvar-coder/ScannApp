//
//  MainTabBarView.swift
//  PhotoStore
//
//  Created by Sarvar Boltaboyev on 09/06/25.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        TabView {
            
            Tab("S", systemImage: "heart", content: {
                ContentView()
            })
            
            Tab("S", systemImage: "heart", content: {
                ListView()
            })
                
        }
    }
}

#Preview {
    MainTabBarView()
}
