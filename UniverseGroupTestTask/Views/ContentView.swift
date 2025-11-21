//
//  ContentView.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 19.11.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var results: [PhotoInfo] = []
    @State private var uiImage: UIImage?
    @StateObject private var viewModel = PhotoInfoViewModel()

    var body: some View {
        ScrollView {
            
            if let uiImage{
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            }

            ForEach(viewModel.photoInfos, id: \.id){
                item in
                Text("\(item.id) \(item.author)")
                    .onTapGesture {
                        Task{
                            do {
                                
                                if let uiImage = try await viewModel.getImageByID(item.id){
                                    self.uiImage = uiImage
                                }
                                
                            } catch {
                                
                            }
                        }
                    }
            }
        }
        
    }

    private func fetchImagesFromServer() {
        Task {
            do {
                let apiService = await APIServiceActor()
                let results = try await apiService.fetchPhotoInfos()
                self.results = results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
