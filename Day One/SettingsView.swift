//
//  SettingsView.swift
//  Day One
//
//  Created by Aaron Thomas on 12/2/25.
//

import SwiftUI
import PhotosUI


struct SettingsView: View {
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    Image(uiImage: avatarImage ?? UIImage(resource: .defaultAvatar))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                }
                
                VStack(alignment: .leading) {
                    Text("Jimbo")
                        .font(.largeTitle.bold())
                    
                    Text("Artist, iOS Developer")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(30)
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem,
                    let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        avatarImage = image
                    }
                }
                
                photosPickerItem = nil
            }
        }
    }
}
    #Preview
    { SettingsView()  .preferredColorScheme(.dark) }
    

 
