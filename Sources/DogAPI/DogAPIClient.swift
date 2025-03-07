//
//  DogAPIClient.swift
//  DogAPI
//
//  Created by Wilson Desimini on 3/7/25.
//

import Foundation

struct DogAPIClient {
    private let session: URLSession
    private let baseURL: URL
    private let decoder = JSONDecoder()

    init(
        session: URLSession,
        baseURL: URL = URL(string: "https://dog.ceo/api/")!
    ) {
        self.session = session
        self.baseURL = baseURL
    }

    func fetch<T: Decodable>(_ endpoint: DogAPIEndpoint) async throws -> T {
        guard let url = URL(string: endpoint.path, relativeTo: baseURL) else {
            throw DogAPIError.invalidURL
        }
        let (data, _) = try await session.data(from: url)
        if let response = try? decoder.decode(DogAPIResponse<T>.self, from: data),
           response.status == "success" {
            return response.message
        } else if let response = try? decoder.decode(DogAPIErrorResponse.self, from: data) {
            throw DogAPIError.apiError(response)
        } else {
            throw DogAPIError.invalidResponse
        }
    }
}
