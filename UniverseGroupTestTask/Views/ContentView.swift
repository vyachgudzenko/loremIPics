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

    var body: some View {
        ScrollView {
            
            Button {
                fetchImagesFromServer()
            } label: {
                Text("Fetch")
            }
            
            if let uiImage{
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            }

            ForEach(results, id: \.id){
                item in
                Text("\(item.id) \(item.author)")
                    .onTapGesture {
                        Task{
                            do {
                                let apiService = await APIServiceActor()
                                if let data = try await apiService.getImageDataByID(item.id){
                                    uiImage = UIImage(data: data)
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
