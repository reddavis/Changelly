//
//  CurrencyTests.swift
//  QuidsTests
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Changelly


internal final class CurrencyTests: XCTestCase
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
            let data = self.loadMockData(filename: "Currency.json")
            let decoder = JSONDecoder()
            
            let currency = try decoder.decode(ChangellyAPIClient.Currency.self, from: data)
            XCTAssertEqual(currency.currencyCode, "btc")
            XCTAssertEqual(currency.fullName, "Bitcoin")
            XCTAssert(currency.enabled)
            XCTAssertFalse(currency.requiresExtraID)
            XCTAssertEqual(currency.imageURL, URL(string: "https://changelly.com/api/coins/btc.png")!)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
