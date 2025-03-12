# DogAPI

DogAPI is a Swift package that provides an interface for fetching info and images of different dog breeds using the [Dog CEO API](https://dog.ceo/dog-api/). This package supports retrieving breed lists, random images, and images for specific breeds and sub-breeds.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Error Handling](#error-handling)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

## Installation

### Swift Package Manager
To use DogAPI in your Swift project, add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/wilsondesimini/DogAPI.git", from: "1.0.0")
]
```

## Usage

### Initialize DogAPI
```swift
import DogAPI

let dogAPI = DogAPI()
```

### Fetch All Breeds
```swift
do {
    // fetch list of all breeds and sub-breeds
    let breeds = try await dogAPI.fetchAllBreeds()
    print(breeds)
} catch {
    print("Error fetching breeds: \(error)")
}
```

### Fetch Random Images
```swift
do {
    // fetch a random image from all dogs collection
    let imageURL = try await dogAPI.fetchRandomImage()
    print(imageURL)
    // fetch multiple random images from all dogs collection
    let imageURLs = try await dogAPI.fetchRandomImages(count: 3)
    print(imageURLs)
} catch {
    print("Error fetching random images: \(error)")
}
```

### Fetch Breed Images
```swift
do {
    // fetch all images from a breed collection
    let allBreedImages = try await dogAPI.fetchImages(breed: "retriever")
    print(allBreedImages)
    // fetch a random image from a breed collection
    let breedImage = try await dogAPI.fetchRandomImage(breed: "retriever")
    print(breedImage)
    // fetch multiple random images from a breed collection
    let breedImages = try await dogAPI.fetchRandomImages(breed: "retriever", count: 3)
    print(breedImages)
} catch {
    print("Error fetching breed images: \(error)")
}
```

### Fetch Sub-Breed Images
```swift
do {
    // fetch all images from a sub-breed collection
    let allSubBreedImages = try await dogAPI.fetchImages(breed: "retriever", subBreed: "golden")
    print(allSubBreedImages)
    // fetch a random image from a sub-breed collection
    let subBreedImage = try await dogAPI.fetchRandomImage(breed: "retriever", subBreed: "golden")
    print(subBreedImage)
    // fetch multiple random images from a sub-breed collection
    let subBreedImages = try await dogAPI.fetchRandomImages(breed: "retriever", subBreed: "golden", count: 3)
    print(subBreedImages)
} catch {
    print("Error fetching sub-breed images: \(error)")
}
```

## Error Handling
DogAPI throws errors conforming to `DogAPIError`, which includes:
- `invalidURL`: When the request URL is malformed
- `apiError`: When the API returns an error response
- `invalidResponse`: When the response data does not match expected format

## Contributing
Contributions are welcome! Feel free to submit a pull request or open an issue.

## License
This package is available under the MIT license.

## Credits
DogAPI is powered by the [Dog CEO API](https://dog.ceo/dog-api/).
