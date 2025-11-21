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
    @State private var selectedTabScreen: TabScreen = .images

    var body: some View {
        ZStack{
            TabView(selection: $selectedTabScreen) {
                ImagesView()
                    .tag(TabScreen.images)
                FavoritesView()
                    .tag(TabScreen.favorites)
            }
            
            VStack{
                Spacer()
                
                CustomTabbar(selectedTab: $selectedTabScreen)
            }
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(PhotoInfoViewModel())
}
