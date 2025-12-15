//
//  Photos.swift
//  Day One
//
//  Created by Aaron Thomas on 12/2/25.
//

import SwiftUI
import PhotosUI

struct PhotosView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            // Display selected image
            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
            // Photo picker button
            PhotosPicker(selection: $selectedItem,
                        matching: .images) {
                Label("Select Photo", systemImage: "photo")
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}
#Preview {
    PhotosView()
}
