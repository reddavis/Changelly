//
//  APIErrorTests.swift
//  QuidsTests
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Changelly


internal final class APIErrorTests: XCTestCase
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
            let data = self.loadMockData(filename: "APIError.json")
            let decoder = JSONDecoder()
            
            let error = try decoder.decode(ChangellyAPIClient.APIError.self, from: data)
            XCTAssertEqual(error.code, -32601)
            XCTAssertEqual(error.message, "Method not found")
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
