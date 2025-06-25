//
//  Photo.swift
//  PhotoStore
//
//  Created by Sarvar Boltaboyev on 09/06/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Photo {
//    var name: String
    var data: Data
    
    var image: Image? {
        guard let uiImage = UIImage(data: data) else { return nil}
        let image = Image(uiImage: uiImage)
        return image
    }
    
    init(data: Data) {
        self.data = data
    }
}
