//
//  DogAPIEndpoint.swift
//  DogAPI
//
//  Created by Wilson Desimini on 3/7/25.
//

import Foundation

enum DogAPIEndpoint {
    case allBreeds
    case allSubBreeds(DogBreed)
    case randomImage
    case randomImages(Int)
    case breedImages(DogBreed)
    case breedRandomImage(DogBreed)
    case breedRandomImages(DogBreed, Int)
    case subBreedImages(DogBreed, DogSubBreed)
    case subBreedRandomImage(DogBreed, DogSubBreed)
    case subBreedRandomImages(DogBreed, DogSubBreed, Int)

    var path: String {
        switch self {
        case .allBreeds:
            "breeds/list/all"
        case .allSubBreeds(let breed):
            "breeds/\(breed)/list"
        case .randomImage:
            "breeds/image/random"
        case .randomImages(let count):
            "breeds/image/random/\(count)"
        case .breedImages(let breed):
            "breed/\(breed)/images"
        case .breedRandomImage(let breed):
            "breed/\(breed)/images/random"
        case .breedRandomImages(let breed, let count):
            "breed/\(breed)/images/random/\(count)"
        case .subBreedImages(let breed, let subBreed):
            "breed/\(breed)/\(subBreed)/images"
        case .subBreedRandomImage(let breed, let subBreed):
            "breed/\(breed)/\(subBreed)/images/random"
        case .subBreedRandomImages(let breed, let subBreed, let count):
            "breed/\(breed)/\(subBreed)/images/random/\(count)"
        }
    }
}
