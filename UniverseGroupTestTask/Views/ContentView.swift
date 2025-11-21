//
//  ContentView.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 19.11.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject private var viewModel: PhotoInfoViewModel

    var body: some View {
        ZStack{
            
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(PhotoInfoViewModel())
}
