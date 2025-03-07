//
//  URLSession+Mock.swift
//  DogAPI
//
//  Created by Wilson Desimini on 3/7/25.
//

import Foundation

extension URLSession {
    static var mock: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}

final class MockURLProtocol: URLProtocol {
    struct Stub {
        let data: Data?
        let response: HTTPURLResponse?
        let error: Error?

        init(data: Data? = nil, response: HTTPURLResponse? = nil, error: Error? = nil) {
            self.data = data
            self.response = response
            self.error = error
        }
    }

    enum StubError: Error {
        case requestNotStubbed
    }

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    nonisolated(unsafe) private static var stubs = [URL: Stub]()

    static func expect(_ stub: Stub, for url: URL) {
        stubs[url] = stub
    }

    static func reset() {
        stubs.removeAll()
    }

    override func startLoading() {
        guard let url = request.url, let stub = Self.stubs[url] else {
            client?.urlProtocol(self, didFailWithError: StubError.requestNotStubbed)
            return
        }
        if let response = stub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let data = stub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let error = stub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
    }
}
