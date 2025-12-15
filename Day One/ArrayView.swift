//
//  ArrayView.swift
//  Day One
//
//  Created by Aaron Thomas on 12/3/25.
//

import SwiftUI
import PhotosUI


struct ArrayView: View {
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
//    @State private var selectedTab: PageShow = .Artwork
    @State private var ispressed: Bool = false
    
    var body: some View {
        
        NavigationStack {

            
            
            
            
//            Picker("", selection: $selectedTab) {
//                ForEach(PageShow.allCases, id: \.self) {
//                    PageShown in Text(PageShown.rawValue)
//                }
//                
//              
//            }
//            .padding()
//            .pickerStyle(.segmented)
//            .frame(width: 300)
            
            NavigationLink(destination: SettingsView()) {
                Text("")
                    .navigationTitle("")
                    .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            // Todo
                            ispressed=true
                        }, label: {
                            Image(.defaultAvatar)
                                .resizable()
                                .frame(width: 45, height: 45)
                        })
                        NavigationLink(
                            destination: SettingsView(),
                            isActive: $ispressed
                        ) {
                            EmptyView()
                        }
                    }
                }
                }
//            
//            if selectedTab == .Artwork {
                VStack {
                    
                    Text (" Welome Back, Jimbo! ")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.tealone)
                        .position(x: 150, y: 100)
                    
                    
                    
                    
                    
                    
                    PhotosPicker(selection: $photosPickerItems, maxSelectionCount: 5, selectionBehavior: .ordered) {
                        Image("picicon")
                            .font(.system(size: 28))
                    }
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 20) {
                            ForEach(0..<images.count, id: \.self) { i in
                                Image(uiImage: images[i])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                //    .clipShape(.circle)
                            }
                        }
                    }
                }
                .padding(30)
                .onChange(of: photosPickerItems) { _, _ in
                    Task {
                        for item in photosPickerItems {
                            if let data = try? await item.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    images.append(image)
                                }
                            }
                        }
                        
                        photosPickerItems.removeAll()
                    }
                }
            }
//            else {
//                Text("Progress")
            }
            
            
        }
        
    
    
//    enum PageShow: String, Identifiable, CaseIterable, Hashable {
//        case Artwork
//        case Progress
//        
//        var id: UUID { UUID() }
//    }

    #Preview
    { ArrayView()  .preferredColorScheme(.dark) }
    
