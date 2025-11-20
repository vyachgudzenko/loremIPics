//
//  APIServiceActor.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 20.11.2025.
//

import Foundation

actor APIServiceActor {
    private let networkActor: NetworkActorProtocol

    init() async {
        self.networkActor = await NetworkManagerActor()
    }
    
    func fetchPhotoInfos() async throws -> [PhotoInfo] {
        let request = try await URLRequestBuilder()
            .setBaseURLString(APILink.host.rawValue)
            .addPathComponents(["v2","list"])
            .addQueryParameters(
                [
                    "page":"1",
                    "limit": "20"
                ]
            )
            .build()

        let results: [PhotoInfo] = try await networkActor.sendRequest(request, decodeTo: [PhotoInfo].self)
        return results
    }
}
