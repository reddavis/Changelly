//
//  AnyEncodable.swift
//  Quids
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


internal struct AnyEncodable: Encodable
{
    // Internal
    let value: Encodable
    
    // MARK: Initialization
    
    internal init(_ value: Encodable)
    {
        self.value = value
    }
    
    // MARK: Encodable
    
    func encode(to encoder: Encoder) throws
    {
        try self.value.encode(to: encoder)
    }
}
