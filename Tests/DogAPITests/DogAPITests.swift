import XCTest
@testable import DogAPI

final class DogAPITests: XCTestCase {
    private var api: DogAPI!

    override func setUp() {
        api = DogAPI(session: .mock)
    }

    override func tearDown() {
        MockURLProtocol.reset()
        api = nil
    }

    func test_fetchAllBreeds_success_allBreeds() async throws {
        // given the all breeds request will succeed
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":{"affenpinscher":[],"african":[],"airedale":[],"akita":[],"appenzeller":[],"australian":["kelpie","shepherd"]},"status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests all breeds
        let breeds = try await api.fetchAllBreeds()
        // then all breeds (and their subBreeds) are returned
        XCTAssertEqual(breeds, ["affenpinscher":[],"african":[],"airedale":[],"akita":[],"appenzeller":[],"australian":["kelpie","shepherd"]])
    }

    func test_fetchAllSubBreeds_success_allSubBreeds() async throws {
        // given the all sub-breeds request will succeed
        let url = URL(string: "https://dog.ceo/api/breed/hound/list")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":["afghan","basset","blood","english","ibizan","plott","walker"],"status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests all sub-breeds for a breed
        let subBreeds = try await api.fetchAllSubBreeds(breed: "hound")
        // then all sub-breeds are returned
        XCTAssertEqual(subBreeds, ["afghan","basset","blood","english","ibizan","plott","walker"])
    }

    func test_fetchRandomImage_success_randomImage() async throws {
        // given random image request will succeed
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":"https://images.dog.ceo/breeds/pembroke/n02113023_219.jpg","status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests random image from all dogs
        let randomImage = try await api.fetchRandomImage()
        // then random image is returned
        XCTAssertEqual(randomImage, URL(string: "https://images.dog.ceo/breeds/pembroke/n02113023_219.jpg"))
    }

    func test_fetchRandomImages_success_randomImages() async throws {
        // given random images request will succeed
        let url = URL(string: "https://dog.ceo/api/breeds/image/random/3")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":["https://images.dog.ceo/breeds/pembroke/n02113023_219.jpg","https://images.dog.ceo/breeds/pembroke/n02113023_220.jpg","https://images.dog.ceo/breeds/pembroke/n02113023_221.jpg"],"status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests random images from all dogs
        let randomImages = try await api.fetchRandomImages(count: 3)
        // then random images are returned
        XCTAssertEqual(randomImages, [URL(string: "https://images.dog.ceo/breeds/pembroke/n02113023_219.jpg")!, URL(string: "https://images.dog.ceo/breeds/pembroke/n02113023_220.jpg")!, URL(string: "https://images.dog.ceo/breeds/pembroke/n02113023_221.jpg")!])
    }

    func test_fetchBreedImages_success_breedImages() async throws {
        // given breed images request will succeed
        let url = URL(string: "https://dog.ceo/api/breed/hound/images")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":["https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg"],"status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests images for a breed
        let images = try await api.fetchImages(breed: "hound")
        // then breed images are returned
        XCTAssertEqual(images, [URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg")!])
    }

    func test_fetchSubBreedImages_success_subBreedImages() async throws {
        // given subBreed images request will succeed
        let url = URL(string: "https://dog.ceo/api/breed/hound/afghan/images")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":["https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg"],"status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests images for a subBreed
        let images = try await api.fetchImages(breed: "hound", subBreed: "afghan")
        // then subBreed images are returned
        XCTAssertEqual(images, [URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg")!])
    }

    func test_fetchRandomImageBreed_success_randomImageBreed() async throws {
        // given random image breed request will succeed
        let url = URL(string: "https://dog.ceo/api/breed/hound/images/random")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":"https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg","status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests random image for a breed
        let randomImage = try await api.fetchRandomImage(breed: "hound")
        // then random image for a breed is returned
        XCTAssertEqual(randomImage, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg"))
    }

    func test_fetchRandomImageSubBreed_success_randomImageSubBreed() async throws {
        // given random image subBreed request will succeed
        let url = URL(string: "https://dog.ceo/api/breed/hound/afghan/images/random")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":"https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg","status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests random image for a subBreed
        let randomImage = try await api.fetchRandomImage(breed: "hound", subBreed: "afghan")
        // then random image for a subBreed is returned
        XCTAssertEqual(randomImage, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg"))
    }

    func test_fetchRandomImagesBreed_success_randomImagesBreed() async throws {
        // given random images breed request will succeed
        let url = URL(string: "https://dog.ceo/api/breed/hound/images/random/3")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":["https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg"],"status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests random images for a breed
        let randomImages = try await api.fetchRandomImages(breed: "hound", count: 3)
        // then random images for a breed are returned
        XCTAssertEqual(randomImages, [URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg")!])
    }

    func test_fetchRandomImagesSubBreed_success_randomImagesSubBreed() async throws {
        // given random images subBreed request will succeed
        let url = URL(string: "https://dog.ceo/api/breed/hound/afghan/images/random/3")!
        let expectedResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expectedData = #"{"message":["https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg","https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg"],"status":"success"}"#.data(using: .utf8)!
        MockURLProtocol.expect(.init(data: expectedData, response: expectedResponse), for: url)
        // when user requests random images for a subBreed
        let randomImages = try await api.fetchRandomImages(breed: "hound", subBreed: "afghan", count: 3)
        // then random images for a subBreed are returned
        XCTAssertEqual(randomImages, [URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg")!, URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg")!])
    }
}
