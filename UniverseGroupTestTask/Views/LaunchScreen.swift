//
//  LaunchScreen.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import SwiftUI

struct LaunchScreen: View {
    @StateObject private var viewModel = PhotoInfoViewModel()
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            Image("Img_box_fill_light")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .foregroundStyle(.customBlue)
        }
        .preferredColorScheme(.light)
         
        .fullScreenCover(isPresented: $viewModel.initialDataLoaded) {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    LaunchScreen()
}
