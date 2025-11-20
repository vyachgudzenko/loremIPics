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

    var body: some View {
        ScrollView {
            
            Button {
                fetchImagesFromServer()
            } label: {
                Text("Fetch")
            }

            ForEach(results, id: \.id){
                item in
                Text("\(item.id) \(item.author)")
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

    private func fetchOneImage(id: String) async -> Data? {
        do {
            let request = try URLRequestBuilder()
                .setBaseURLString(APILink.host.rawValue)
                .addPathComponents(["id","\(id)","300","200"])
                .build()

            let data = await networkActor.sendRawRequest(request)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

#Preview {
    ContentView()
}
