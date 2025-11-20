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
    let networkActor = NetworkManagerActor()
    @State private var loadingIds: Set<String> = [] // чтобы не дергать повторно

    var body: some View {
        ScrollView {
            
        }
        .onAppear {
            fetchImagesFromServer()
        }
    }

    private func fetchImagesFromServer() {
        Task {
            do {
                let request = try URLRequestBuilder()
                    .setBaseURLString(APILink.host.rawValue)
                    .addPathComponents(["v2","list"])
                    .addQueryParameters(
                        [
                            "page":"1",
                            "limit": "5"
                        ]
                    )
                    .build()

                let results = try await networkActor.sendRequest(request, decodeTo: [PhotoInfo].self)
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
