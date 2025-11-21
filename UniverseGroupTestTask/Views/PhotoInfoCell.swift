//
//  PhotoInfoCell.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import SwiftUI

struct PhotoInfoCell: View {
    @EnvironmentObject private var viewModel: PhotoInfoViewModel
    let photoInfo: PhotoInfoCellProtocol
    @State private var uiImage: UIImage?
    
    var body: some View {
        ZStack{
            Color.red
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            viewModel.manageFavoriteStateByID(id: photoInfo.id)
                        } label: {
                            let isFavorite = viewModel.isFavorite(id: photoInfo.id)
                            Image( "Bookmark_fill")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundStyle(isFavorite ? .customLightBlue : .customLightGray)
                            
                                .padding(.all, 10)
                        }

                    }
                    
            } else {
               Rectangle()
                    .fill(.customLightBlue.opacity(0.2))
                Image("images_fill")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.customLightBlue)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .task {
            uiImage = try? await viewModel.getImageByID(photoInfo.id)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PhotoInfoViewModel())
}
