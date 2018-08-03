//
//  BodyTests.swift
//  QuidsTests
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Changelly


internal final class BodyTests: XCTestCase
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
    
    internal func testSigning()
    {
        do
        {
            let encoder = JSONEncoder()
            let body = ChangellyAPIClient.Body(method: "getCurrencies", params: ["a" : AnyEncodable("b")], identifier: "identifier")
            let signature = try body.sign(with: "secret", encoder: encoder)
            
            XCTAssertEqual(signature, "e3097ec099ccf40a835241fc447b92d03fc99a25d9bf2c1e30d8a79a89c129073843639a59e1940eb6a0b9a3a93ae49eb360864bbf1e837ed5d0eb6b164a6a90")
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
