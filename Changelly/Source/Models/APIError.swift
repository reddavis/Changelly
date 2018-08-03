//
//  APIError.swift
//  Quids
//
//  Created by Red Davis on 20/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension ChangellyAPIClient
{
    public struct APIError: Error, Decodable
    {
        // Static
        public static let unknown = APIError(code: -9999, message: "Unknown error")
        
        // Public
        public let code: Int
        public let message: String
    }
}


// MARK: Coding keys

internal extension ChangellyAPIClient.APIError
{
    internal enum CodingKeys: String, CodingKey
    {
        case code
        case message
    }
}
