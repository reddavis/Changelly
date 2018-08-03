//
//  ResponseTests.swift
//  QuidsTests
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Changelly


internal final class ResponseTests: XCTestCase
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
            let data = self.loadMockData(filename: "GetCurrenciesFull.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            let response = try decoder.decode(ChangellyAPIClient.Response<[ChangellyAPIClient.Currency]>.self, from: data)
            XCTAssertEqual(response.identifier, "F885B2B4-8422-4BB6-A97A-A8D5C1E8B217")
            XCTAssertEqual(response.jsonRPC, "2.0")
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
