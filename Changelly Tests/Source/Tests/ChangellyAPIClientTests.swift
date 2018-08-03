//
//  ChangellyAPIClientTests.swift
//  QuidsTests
//
//  Created by Red Davis on 02/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Changelly


internal final class ChangellyAPIClientTests: XCTestCase
{
    // Private
    private var mockSession: MockSession!
    private var apiClient: ChangellyAPIClient!
    
    // MARK: Setup
    
    override func setUp()
    {
        super.setUp()
        
        self.mockSession = MockSession()
        self.apiClient = ChangellyAPIClient(key: "a", secret: "b", session: self.mockSession)
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: -
    
    internal func testFetchingFullCurrencyList()
    {
        let expectation = self.expectation(description: "api")
        
        let data = self.loadMockData(filename: "GetCurrenciesFull.json")
        let response = MockSession.Response(urlPattern: "/", data: data, statusCode: 200, headers: nil)
        self.mockSession.mockResponses.append(response)
        
        // Make request
        self.apiClient.fetchFullCurrencyList { (currencies, error) in
            XCTAssertNotNil(currencies)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    internal func testFetchingMinimumExchangeAmount()
    {
        let expectation = self.expectation(description: "api")
        
        let data = self.loadMockData(filename: "GetMinAmount.json")
        let response = MockSession.Response(urlPattern: "/", data: data, statusCode: 200, headers: nil)
        self.mockSession.mockResponses.append(response)
        
        // Make request
        self.apiClient.fetchMinimumExchangeableAmount(from: "btc", to: "eth") { (amount, error) in
            XCTAssertEqual(amount, 123.123)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    internal func testFetchingEstimatedExchangeAmount()
    {
        let expectation = self.expectation(description: "api")
        
        let data = self.loadMockData(filename: "GetExchangeAmount.json")
        let response = MockSession.Response(urlPattern: "/", data: data, statusCode: 200, headers: nil)
        self.mockSession.mockResponses.append(response)
        
        // Make request
        self.apiClient.fetchEstimatedExchangeAmount(from: "btc", to: "eth", amount: 123.00) { (amount, error) in
            XCTAssertEqual(amount, 456.456)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    internal func testFetchingStatus()
    {
        let expectation = self.expectation(description: "api")
        
        let data = self.loadMockData(filename: "GetStatus.json")
        let response = MockSession.Response(urlPattern: "/", data: data, statusCode: 200, headers: nil)
        self.mockSession.mockResponses.append(response)
        
        // Make request
        self.apiClient.fetchStatus(for: "123") { (status, error) in
            XCTAssertNotNil(status)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    internal func testCreatingTransaction()
    {
        let expectation = self.expectation(description: "api")
        
        let data = self.loadMockData(filename: "CreateTransaction.json")
        let response = MockSession.Response(urlPattern: "/", data: data, statusCode: 200, headers: nil)
        self.mockSession.mockResponses.append(response)
        
        // Make request
        let template = ChangellyAPIClient.TransactionTemplate()
        
        self.apiClient.create(transaction: template) { (transaction, error) in
            XCTAssertNotNil(transaction)
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}
