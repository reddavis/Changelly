//
//  TransactionTests.swift
//  QuidsTests
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Changelly


internal final class TransactionTests: XCTestCase
{
    // MARK: Setup
    
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: -
    
    internal func testInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "Transaction.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            let transaction = try decoder.decode(ChangellyAPIClient.Transaction.self, from: data)
            XCTAssertEqual(transaction.identifier, "2c6f46836128")
            XCTAssertEqual(transaction.apiExtraFeePercent, 0.5)
            XCTAssertEqual(transaction.changellyFeePercent, 0.5)
            XCTAssertEqual(transaction.refundAddress, "qrt4dpvyf20ufx4wzlncj3sq8h927z74augzy7g6hq")
            XCTAssertEqual(transaction.status, .new)
            XCTAssertNil(transaction.payinExtraID)
            XCTAssertEqual(transaction.fromCurrencyCode, "bch")
            XCTAssertEqual(transaction.toCurrencyCode, "btc")
            XCTAssertEqual(transaction.amountTo, 0.9877)
            XCTAssertEqual(transaction.payinAddress, "bitcoincash:qpehm8fkv4nyee55fs5av33nntaycw647scwnxulvj")
            XCTAssertEqual(transaction.payoutAddress, "3GeZgEQW9QEC7tfzW3SXKLEfQMk2egWfZB")
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
