//
//  Response.swift
//  Quids
//
//  Created by Red Davis on 20/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


internal extension ChangellyAPIClient
{
    internal struct Response<T: Decodable>: Decodable
    {
        // Internal
        internal let identifier: String
        internal let jsonRPC: String
        internal let result: T
    }
}


// MARK: Coding keys

internal extension ChangellyAPIClient.Response
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case jsonRPC = "jsonrpc"
        case result
    }
}
