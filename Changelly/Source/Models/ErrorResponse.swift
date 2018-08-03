//
//  ErrorResponse.swift
//  Quids
//
//  Created by Red Davis on 20/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


internal extension ChangellyAPIClient
{
    internal struct ErrorResponse: Decodable
    {
        // Internal
        internal let identifier: String
        internal let jsonRPC: String
        internal let error: APIError
    }
}


// MARK: Coding keys

internal extension ChangellyAPIClient.ErrorResponse
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case jsonRPC = "jsonrpc"
        case error
    }
}
