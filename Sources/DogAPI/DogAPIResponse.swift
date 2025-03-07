//
//  DogAPIResponse.swift
//  DogAPI
//
//  Created by Wilson Desimini on 3/7/25.
//

import Foundation

struct DogAPIResponse<Body: Decodable>: Decodable {
    let message: Body
    let status: String
}

struct DogAPIErrorResponse: Decodable {
    let message: String
    let status: String
    let code: Int
}
