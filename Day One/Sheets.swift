//
//  Sheets.swift
//  Day One
//
//  Created by Aaron Thomas on 12/3/25.
//

import SwiftUI

struct Sheets: View {
    
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image("picicon") })
                    .sheet(isPresented: $showSheet, content: {
                        SecondScreen()
                    })
                }
            }
        }
    }
}

struct SecondScreen: View {

    var body: some View {
        ZStack {
                    
                    Button(action: {
                 
                    }, label: {
                        Image("picicon") })
                 
                }
            }
        }
    


                    
        
        
        
        
        
    struct Sheets_Previews: PreviewProvider {
        static var previews: some View {
            Sheets()
        }
    }

