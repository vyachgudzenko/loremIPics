//
//  FavoritesView.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var photoInfoViewModel: PhotoInfoViewModel
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack(spacing: 20){
                    Text("Favorites")
                        .standartFont(size: 30, weight: .bold)
                    let gridItems: [GridItem] = [
                        .init(.flexible()),
                        .init(.flexible())
                    ]
                    LazyVGrid(columns: gridItems, spacing: 30) {
                        ForEach(photoInfoViewModel.favorites, id: \.id) { photoInfo in
                            PhotoInfoCell(photoInfo: photoInfo)
                                .environmentObject(photoInfoViewModel)
                                .frame(height: (geo.size.width / 2) - 32 - 10)
                                .transition(.scale)
                                
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(PhotoInfoViewModel())
}
