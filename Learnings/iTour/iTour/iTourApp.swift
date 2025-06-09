//
//  iTourApp.swift
//  iTour
//
//  Created by Sarvar Boltaboyev on 08/06/25.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
                }
        }
        .modelContainer(for: Destination.self)
    }
}
