//
//  ContentView.swift
//  PhotoStore
//
//  Created by Sarvar Boltaboyev on 08/06/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    
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
                    buttonState.toggle()
                    if buttonState {
                        print("Save")
                    } else {
                        print("Unsave")
                    }
                } label: {
                    Text(buttonState ? "UnSave" : "Save")
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
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            self.processedImage = Image(uiImage: inputImage)
        }
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
