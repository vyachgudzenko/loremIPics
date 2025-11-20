//
//  NetworkActor.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 19.11.2025.
//

import Foundation

actor NetworkManagerActor: NetworkActorProtocol {

    private let decoder = JSONDecoder()

    // MARK: - JSON request
    func sendRequest<T: Decodable>(
        _ request: URLRequest,
        decodeTo type: T.Type
    ) async throws -> T {

        // Try to perform the request
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw NSError(
                domain: "Network",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Connection error occurred."]
            )
        }
        
        print(String(data: data, encoding: .utf8))

        // Validate HTTP response
        guard let http = response as? HTTPURLResponse else {
            throw NSError(
                domain: "Network",
                code: -2,
                userInfo: [NSLocalizedDescriptionKey: "Invalid server response."]
            )
        }

        // Check HTTP status code
        guard (200...299).contains(http.statusCode) else {
            throw NSError(
                domain: "Network",
                code: http.statusCode,
                userInfo: [NSLocalizedDescriptionKey: "Server returned status code: \(http.statusCode)"]
            )
        }

        // Decode JSON
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NSError(
                domain: "Network",
                code: -3,
                userInfo: [NSLocalizedDescriptionKey: "Failed to decode response."]
            )
        }
    }

    // MARK: - Raw Data request (non-throwing)
        func sendRawRequest(_ request: URLRequest) async -> Data? {

            // Try to load data
            let (data, _): (Data, URLResponse)
            do {
                (data, _) = try await URLSession.shared.data(for: request)
            } catch {
                // Network error
                return nil
            }

            return data
        }}

