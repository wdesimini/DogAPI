//
//  DogAPIError.swift
//  DogAPI
//
//  Created by Wilson Desimini on 3/7/25.
//

import Foundation

enum DogAPIError: LocalizedError {
    case invalidURL
    case apiError(DogAPIErrorResponse)
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case let .apiError(response):
            response.message
        case .invalidResponse:
            "Invalid response"
        }
    }
}
