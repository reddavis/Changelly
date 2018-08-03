//
//  Currency.swift
//  Quids
//
//  Created by Red Davis on 20/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension ChangellyAPIClient
{
    public struct Currency: Decodable
    {
        // Public
        public let enabled: Bool
        public let extraIDName: String?
        public let fullName: String
        public let currencyCode: String
        public let imageURL: URL
        
        public var requiresExtraID: Bool {
            return self.extraIDName != nil
        }
    }
}

// MARK: Equatable

extension ChangellyAPIClient.Currency: Equatable
{
    public static func ==(lhs: ChangellyAPIClient.Currency, rhs: ChangellyAPIClient.Currency) -> Bool
    {
        return lhs.currencyCode == rhs.currencyCode
    }
}


// MARK: Coding keys

internal extension ChangellyAPIClient.Currency
{
    internal enum CodingKeys: String, CodingKey
    {
        case enabled
        case extraIDName = "extraIdName"
        case fullName
        case currencyCode = "name"
        case imageURL = "image"
    }
}
