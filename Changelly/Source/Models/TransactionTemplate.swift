//
//  TransactionTemplate.swift
//  Quids
//
//  Created by Red Davis on 21/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension ChangellyAPIClient
{
    public struct TransactionTemplate
    {
        // Public
        public var fromCurrencyCode: String?
        public var toCurrencyCode: String?
        public var address: String?
        public var extraID: String?
        public var amount: Double?
        public var refundAddress: String?
        public var refundExtraID: String?
        
        public var isValid: Bool {
            guard let _ = self.fromCurrencyCode,
                  let _ = self.toCurrencyCode,
                  let _ = self.address,
                  let amount = self.amount,
                  amount > 0.0 else
            {
                return false
            }
            
            return true
        }
        
        // Internal
        
        internal func buildParams() -> [String : AnyEncodable]
        {
            var params = [String : AnyEncodable]()
            
            if let fromCurrencyCode = self.fromCurrencyCode
            {
                params["from"] = AnyEncodable(fromCurrencyCode)
            }
            
            if let toCurrencyCode = self.toCurrencyCode
            {
                params["to"] = AnyEncodable(toCurrencyCode)
            }
            
            if let address = self.address
            {
                params["address"] = AnyEncodable(address)
            }
            
            if let extraID = self.extraID
            {
                params["extraId"] = AnyEncodable(extraID)
            }
            
            if let amount = self.amount
            {
                params["amount"] = AnyEncodable(amount)
            }
            
            if let refundAddress = self.refundAddress
            {
                params["refundAddress"] = AnyEncodable(refundAddress)
            }
            
            if let refundExtraID = self.refundExtraID
            {
                params["refundExtraId"] = AnyEncodable(refundExtraID)
            }
            
            return params
        }
    }
}
