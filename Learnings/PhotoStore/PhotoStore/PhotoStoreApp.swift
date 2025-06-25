//
//  PhotoStoreApp.swift
//  PhotoStore
//
//  Created by Sarvar Boltaboyev on 08/06/25.
//

import SwiftUI
import SwiftData

@main
struct PhotoStoreApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
        .modelContainer(for: Photo.self)
    }
}
