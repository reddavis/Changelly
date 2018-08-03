//
//  TransactionStatus.swift
//  Quids
//
//  Created by Red Davis on 22/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension ChangellyAPIClient
{
    public enum TransactionStatus: String, Decodable
    {
        case new
        case waiting
        case confirming
        case exchanging
        case sending
        case finished
        case failed
        case refunded
        case overdue
    }
}
