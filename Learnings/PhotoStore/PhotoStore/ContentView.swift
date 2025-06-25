//
//  ContentView.swift
//  PhotoStore
//
//  Created by Sarvar Boltaboyev on 08/06/25.
//

import SwiftUI
import PhotosUI
import SwiftData
import UIKit

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    
    @Environment(\.modelContext) var modelContext
    @Query var photos: [Photo]
    
    // button title Change
    @State private var buttonState = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 30) {
                if let processedImage {
                    processedImage
                        .resizable()
                        .frame(width: 380, height: 300)
                        .clipShape(.rect(cornerRadius: 15))
                        .scaledToFit()
                    
                } else {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 380, height: 300)
                }
                
                Button {
                    //                    buttonState.toggle()
                    //                    if buttonState {
                    //                        print("Save")
                    //                    } else {
                    //                        print("Unsave")
                    //                    }
                    save()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                
            }
            .padding()
            .navigationTitle("Photo")
            .toolbar {
                ToolbarItem {
                    
                    PhotosPicker(selection: $selectedItem) {
                        Image(systemName: "plus")
                        
                        
                    }
                    .onChange(of: selectedItem, loadImage)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    NavigationLink {
                        CameraView(image: $processedImage)
                    } label: {
                        Image(systemName: "camera")
                    }
                }
            }
        }
    }
    
    func changeFilter() {
        
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            let photo = Photo(data: imageData)
            modelContext.insert(photo)
            
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            self.processedImage = Image(uiImage: inputImage)
        }
    }
    
    func save() {
        
        let image = UIImage(named: "photo")
        guard let data = image?.pngData() else { return }
        let photo = Photo(data: data)
        modelContext.insert(photo)
        
    }
}

#Preview {
    ContentView()
}

//PhotosPicker(selection: $selectedItem) {
//    if let processedImage {
//        processedImage
//            .resizable()
//            .scaledToFit()
//    } else {
//        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a image"))
//    }
//}
//.buttonStyle(.plain)
//.onChange(of: selectedItem, loadImage)
