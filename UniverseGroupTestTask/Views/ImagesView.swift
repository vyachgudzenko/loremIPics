//
//  ImagesView.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import SwiftUI

struct ImagesView: View {
    @EnvironmentObject var photoInfoViewModel: PhotoInfoViewModel
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack(spacing: 20){
                    Text("Lorem Picsum Images")
                        .standartFont(size: 30, weight: .bold)
                    let gridItems: [GridItem] = [
                        .init(.flexible()),
                        .init(.flexible())
                    ]
                    LazyVGrid(columns: gridItems, spacing: 30) {
                        ForEach(photoInfoViewModel.photoInfos, id: \.id) { photoInfo in
                            PhotoInfoCell(photoInfo: photoInfo)
                                .environmentObject(photoInfoViewModel)
                                .frame(height: (geo.size.width / 2) - 32 - 10)
                                
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
    ImagesView()
        .environmentObject(PhotoInfoViewModel())
}
