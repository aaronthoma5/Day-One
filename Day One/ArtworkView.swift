//
//  ArtworkView.swift
//  Day One
//
//  Created by Aaron Thomas on 11/30/25.
//

import SwiftUI
import PhotosUI

struct ArtworkView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
   
    
    
    
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {

                    
                
                      
                        Button {
                            
                            
                        }
                    label:{
                        VStack{
                            if let selectedImage {
                                selectedImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .border(.green, width: 5)
                                
                            }
                            
                            PhotosPicker(selection: $selectedItem,
                                         matching: .images) {
                                
                                
                                
                                
//                                Image("picicon")
//                                    .font(.system(size: 40))
//                                    .padding(.bottom, 4)
//                                    .foregroundStyle(.greenone)
                                
                                Image("picicon")
                                    .font(.system(size: 28))
                            }
                                         .foregroundColor(.greenone)
                                         .frame(maxWidth: .infinity)
                                         .padding(.vertical, 40)
                     }
                        }
                        .onChange(of: selectedItem) { oldValue, newValue in
                            Task {
                                if let data = try? await newValue?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    selectedImage = Image(uiImage: uiImage)
                                }
                            }
                        }

                    
                    Text("This week")
                        .font(.headline)
                        .foregroundColor(.white)

                    artworkCard(
                        imageName: "apple_example",
                        caption: "the little note about the image"
                    )

                    artworkCard(
                        imageName: "cat_example",
                        caption: "the little note about the image"
                    )

                    
                    Text("November 2025")
                        .font(.headline)
                        .foregroundColor(.white)

                    artworkCard(
                        imageName: "laundry_example",
                        caption: "the little note about the image"
                    )

                    Spacer().frame(height: 30)
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    segmentedHeader
                }
            }
        }
    }

    
    private var segmentedHeader: some View {
        Picker("", selection: $selectedTab) {
            Text("Artwork").tag(0)
            Text("Progress").tag(1)
        }
        .pickerStyle(.segmented)
        .frame(width: 300)
        
    }

    
    private func artworkCard(imageName: String, caption: String) -> some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .shadow(radius: 4)

            Text(caption)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 4)
        }
    }
}

struct ArtworkView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkView()
            .preferredColorScheme(.dark)
    }
}

