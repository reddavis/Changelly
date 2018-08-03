//
//  Body.swift
//  Quids
//
//  Created by Red Davis on 20/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import CommonCrypto
import Foundation


internal extension ChangellyAPIClient
{
    internal struct Body: Encodable
    {
        // Internal
        internal let method: String
        internal let params: [String : AnyEncodable]
        internal let identifier: String
        internal let jsonRPC = "2.0"
        
        // MARK: Initialization
        
        internal init(method: String, params: [String : AnyEncodable])
        {
            self.method = method
            self.params = params
            self.identifier = UUID().uuidString
        }
        
        internal init(method: String, params: [String : AnyEncodable], identifier: String)
        {
            self.method = method
            self.params = params
            self.identifier = identifier
        }
        
        // MARK: Sign
        
        internal func sign(with secret: String, encoder: JSONEncoder) throws -> String
        {
            guard let secretData = secret.data(using: .utf8) else
            {
                throw SigningError.invalidSecret
            }
            
            let bodyData = try encoder.encode(self)
            let hmacAlgorithm = CCHmacAlgorithm(kCCHmacAlgSHA512)
            let signatureCapacity = Int(CC_SHA512_DIGEST_LENGTH)
            let signature = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: signatureCapacity)
            
            defer
            {
                signature.deallocate()
            }
            
            secretData.withUnsafeBytes({ (secretBytes: UnsafePointer<UInt8>) -> Void in
                bodyData.withUnsafeBytes({ (bodyBytes: UnsafePointer<UInt8>) -> Void in
                    CCHmac(hmacAlgorithm, secretBytes, secretData.count, bodyBytes, bodyData.count, signature)
                })
            })
            
            let data = Data(bytes: signature, count: signatureCapacity)
            
            return data.map { (value) -> String in
                return String(format: "%02hhx", value)
            }.joined()
        }
    }
}


// MARK: Encodable

extension ChangellyAPIClient.Body
{
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.method, forKey: .method)
        try container.encode(self.identifier, forKey: .identifier)
        try container.encode(self.jsonRPC, forKey: .jsonRPC)
        try container.encode(self.params, forKey: .params)
    }
}


// MARK: Coding keys

internal extension ChangellyAPIClient.Body
{
    internal enum CodingKeys: String, CodingKey
    {
        case method
        case params
        case identifier = "id"
        case jsonRPC = "jsonrpc"
    }
}


// MARK: Errors

internal extension ChangellyAPIClient.Body
{
    internal enum SigningError: Error
    {
        case invalidSecret
    }
}
