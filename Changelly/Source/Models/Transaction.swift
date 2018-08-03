//
//  Transaction.swift
//  Quids
//
//  Created by Red Davis on 21/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension ChangellyAPIClient
{
    public struct Transaction: Decodable
    {
        // Public
        public let identifier: String
        public let amountTo: Double
        public let apiExtraFeePercent: Double
        public let changellyFeePercent: Double
        public let createdAt: Date
        public let fromCurrencyCode: String
        public let toCurrencyCode: String
        public let payinAddress: String
        public let payinExtraID: String?
        public let payoutAddress: String
        public let refundAddress: String?
        public let status: TransactionStatus
        
        public var url: URL {
            return URL(string: "https://changelly.com/transaction/\(self.identifier)")!
        }
        
        // MARK: Initialization
        
        public init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.identifier = try container.decode(String.self, forKey: .identifier)
            self.amountTo = try container.decode(Double.self, forKey: .amountTo)
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.fromCurrencyCode = try container.decode(String.self, forKey: .fromCurrencyCode)
            self.toCurrencyCode = try container.decode(String.self, forKey: .toCurrencyCode)
            self.payinAddress = try container.decode(String.self, forKey: .payinAddress)
            self.payinExtraID = try? container.decode(String.self, forKey: .payinExtraID)
            self.payoutAddress = try container.decode(String.self, forKey: .payoutAddress)
            self.status = try container.decode(TransactionStatus.self, forKey: .status)
            self.refundAddress = try container.decode(String.self, forKey: .refundAddress)
            
            // API Extra fee
            let apiExtraFeePercentString = try container.decode(String.self, forKey: .apiExtraFeePercent)
            guard let apiExtraFeePercent = Double(apiExtraFeePercentString) else
            {
                throw DecodingError.dataCorruptedError(forKey: .apiExtraFeePercent, in: container, debugDescription: "API extra fee incorrect format")
            }
            
            self.apiExtraFeePercent = apiExtraFeePercent
            
            // Changelly fee
            let changellyFeePercentString = try container.decode(String.self, forKey: .changellyFeePercent)
            guard let changellyFeePercent = Double(changellyFeePercentString) else
            {
                throw DecodingError.dataCorruptedError(forKey: .changellyFeePercent, in: container, debugDescription: "Changelly fee incorrect format")
            }
            
            self.changellyFeePercent = changellyFeePercent
        }
    }
}


// MARK: Coding keys

internal extension ChangellyAPIClient.Transaction
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case amountTo
        case apiExtraFeePercent = "apiExtraFee"
        case changellyFeePercent = "changellyFee"
        case createdAt
        case fromCurrencyCode = "currencyFrom"
        case toCurrencyCode = "currencyTo"
        case payinAddress
        case payinExtraID = "payinExtraId"
        case payoutAddress
        case status
        case refundAddress
    }
}
