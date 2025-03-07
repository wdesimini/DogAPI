//
//  DogAPI.swift
//  DogAPI
//
//  Created by Wilson Desimini on 3/6/25.
//

import Foundation

public struct DogAPI {
    private let client: DogAPIClient

    public init(session: URLSession = .shared) {
        self.client = .init(session: session)
    }

    /// Fetch list of all breeds
    /// - Returns: list of breeds and their sub-breeds
    public func fetchAllBreeds() async throws -> [DogBreed: [DogSubBreed]] {
        try await client.fetch(.allBreeds)
    }

    /// Fetch single random image from all dogs collection
    /// - Returns: URL of random dog image
    public func fetchRandomImage() async throws -> DogURL {
        try await client.fetch(.randomImage)
    }

    /// Fetch multiple random images from all dogs collection
    /// - Parameter count: number of random dog images to fetch
    /// - Returns: array of URLs of random dog images
    public func fetchRandomImages(count: Int) async throws -> [DogURL] {
        try await client.fetch(.randomImages(count))
    }

    /// Fetches all dog images from a breed
    /// - Parameters:
    ///   - breed: breed to fetch images for
    ///   - subBreed: optional sub-breed to fetch images for
    /// - Returns: array of URLs of dog images
    public func fetchImages(breed: DogBreed, subBreed: DogSubBreed? = nil) async throws -> [DogURL] {
        if let subBreed {
            try await client.fetch(.subBreedImages(breed, subBreed))
        } else {
            try await client.fetch(.breedImages(breed))
        }
    }

    /// Fetches a random dog image from a breed
    /// - Parameters:
    ///   - breed: breed to fetch images for
    ///   - subBreed: optional sub-breed to fetch images for
    /// - Returns: URL of random dog image
    public func fetchRandomImage(breed: DogBreed, subBreed: DogSubBreed? = nil) async throws -> DogURL {
        if let subBreed {
            try await client.fetch(.subBreedRandomImage(breed, subBreed))
        } else {
            try await client.fetch(.breedRandomImage(breed))
        }
    }

    /// Fetches multiple random dog images from a breed
    /// - Parameters:
    ///   - breed: breed to fetch images for
    ///   - subBreed: optional sub-breed to fetch images for
    ///   - count: number of random dog images to fetch
    /// - Returns: array of URLs of random dog images
    public func fetchRandomImages(breed: DogBreed, subBreed: DogSubBreed? = nil, count: Int) async throws -> [DogURL] {
        if let subBreed {
            try await client.fetch(.subBreedRandomImages(breed, subBreed, count))
        } else {
            try await client.fetch(.breedRandomImages(breed, count))
        }
    }
}
