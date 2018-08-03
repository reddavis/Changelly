//
//  TransactionTemplateTests.swift
//  QuidsTests
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Changelly


internal final class TransactionTemplateTests: XCTestCase
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
    
    internal func testValidation()
    {
        var template = ChangellyAPIClient.TransactionTemplate()
        XCTAssertFalse(template.isValid)
        
        template.fromCurrencyCode = "btc"
        template.toCurrencyCode = "btc"
        template.amount = 123.0
        template.address = "btc"
        XCTAssert(template.isValid)
    }
    
    internal func testBuildingParams()
    {
        var template = ChangellyAPIClient.TransactionTemplate()
        template.fromCurrencyCode = "btc"
        template.toCurrencyCode = "btc"
        template.amount = 123.0
        template.address = "btc"
        template.refundAddress = "abc"
        template.refundExtraID = "abc"
        template.extraID = "abc"
        
        let params = template.buildParams()
        XCTAssertNotNil(params["from"])
        XCTAssertNotNil(params["to"])
        XCTAssertNotNil(params["address"])
        XCTAssertNotNil(params["extraId"])
        XCTAssertNotNil(params["amount"])
        XCTAssertNotNil(params["refundAddress"])
        XCTAssertNotNil(params["refundExtraId"])
    }
}
