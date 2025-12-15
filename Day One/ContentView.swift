//
//  ContentView.swift
//  Day One
//
//  Created by Aaron Thomas on 11/24/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedSegment = 0
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                // Segmented Control
                Picker("Options", selection: $selectedSegment) {
                    Text("Artwork").tag(1)
                    Text("Progress").tag(0)
                }
                    .pickerStyle(.segmented)
                    .padding()
                
                if selectedSegment == 1{
                    ArrayView()
                } else if selectedSegment == 0{
                    
                    ProgressViewPage()
                }
                
            }
        }
    }
}


#Preview {
    ContentView() .preferredColorScheme(.dark) }

