//
//  ChangellyAPIClient.swift
//  Quids
//
//  Created by Red Davis on 20/07/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public final class ChangellyAPIClient
{
    // Private
    private let key: String
    private let secret: String
    private let session: URLSession
    
    private let baseURL = URL(string: "https://api.changelly.com")!
    
    private var defaultHeaders: [String : String] {
        let headers = [
            "Content-Type" : "application/json",
            "api-key" : self.key
        ]
        
        return headers
    }
    
    // MARK: Initialization
    
    public required init(key: String, secret: String, session: URLSession = URLSession(configuration: .default))
    {
        self.key = key
        self.secret = secret
        self.session = session
    }
    
    // MARK: Request
    
    private func perform(method: String, params: [String : AnyEncodable], completionHandler: @escaping (_ json: Any?, _ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void)
    {
        do
        {
            var request = URLRequest(url: self.baseURL)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = self.defaultHeaders
            
            // Body
            let body = Body(method: method, params: params)
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(body)
            
            // Signed header
            let signedHeader = try body.sign(with: self.secret, encoder: jsonEncoder)
            request.addValue(signedHeader, forHTTPHeaderField: "sign")
            
            // Perform request
            let task = self.session.dataTask(with: request) { (data, response, error) in
                let httpResponse = response as? HTTPURLResponse
                let json: Any?
                
                if let unwrappedData = data
                {
                    json = try? JSONSerialization.jsonObject(with: unwrappedData, options: [])
                }
                else
                {
                    json = nil
                }
                
                completionHandler(json, data, httpResponse, error)
            }
            
            task.resume()
        }
        catch
        {
            completionHandler(nil, nil, nil, error)
        }
    }
}

// MARK: Error

private extension ChangellyAPIClient
{
    private func buildError(data: Data?) -> APIError
    {
        let decoder = JSONDecoder()

        guard let unwrappedData = data,
              let response = try? decoder.decode(ErrorResponse.self, from: unwrappedData) else
        {
            return APIError.unknown
        }

        return response.error
    }
}

// MARK: Currency list

public extension ChangellyAPIClient
{
    public func fetchFullCurrencyList(_ completionHandler: @escaping (_ currencies: [Currency]?, _ error: Error?) -> Void)
    {
        self.perform(method: "getCurrenciesFull", params: [:]) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response<[Currency]>.self, from: unwrappedData)
                completionHandler(response.result, nil)
            }
            catch
            {
                let error = self?.buildError(data: data)
                completionHandler(nil, error)
            }
        }
    }
}

// MARK: Minimum amount

public extension ChangellyAPIClient
{
    public func fetchMinimumExchangeableAmount(from: String, to: String, completionHandler: @escaping (_ amount: Double?, _ error: Error?) -> Void)
    {
        let params: [String : AnyEncodable] = [
            "from" : AnyEncodable(from),
            "to" : AnyEncodable(to)
        ]
        
        self.perform(method: "getMinAmount", params: params) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response<String>.self, from: unwrappedData)
                completionHandler(Double(response.result), nil)
            }
            catch
            {
                let error = self?.buildError(data: data)
                completionHandler(nil, error)
            }
        }
    }
}

// MARK: Estimated exchange amount8

public extension ChangellyAPIClient
{
    public func fetchEstimatedExchangeAmount(from: String, to: String, amount: Double, completionHandler: @escaping (_ amount: Double?, _ error: Error?) -> Void)
    {
        let params: [String : AnyEncodable] = [
            "from" : AnyEncodable(from),
            "to" : AnyEncodable(to),
            "amount" : AnyEncodable(amount)
        ]
        
        self.perform(method: "getExchangeAmount", params: params) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response<String>.self, from: unwrappedData)
                completionHandler(Double(response.result), nil)
            }
            catch
            {
                let error = self?.buildError(data: data)
                completionHandler(nil, error)
            }
        }
    }
}

// MARK: Create transaction

public extension ChangellyAPIClient
{
    public func create(transaction: TransactionTemplate, completionHandler: @escaping (_ transaction: Transaction?, _ error: Error?) -> Void)
    {
        self.perform(method: "createTransaction", params: transaction.buildParams()) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                
                let response = try decoder.decode(Response<Transaction>.self, from: unwrappedData)
                completionHandler(response.result, nil)
            }
            catch
            {
                let error = self?.buildError(data: data)
                completionHandler(nil, error)
            }
        }
    }
}

// MARK: Get transaction status

public extension ChangellyAPIClient
{
    public func fetchStatus(for transactionID: String, completionHandler: @escaping (_ status: TransactionStatus?, _ error: Error?) -> Void)
    {
        let params = [
            "id" : AnyEncodable(transactionID)
        ]
        
        self.perform(method: "getStatus", params: params) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response<TransactionStatus>.self, from: unwrappedData)
                completionHandler(response.result, nil)
            }
            catch
            {
                let error = self?.buildError(data: data)
                completionHandler(nil, error)
            }
        }
    }
}
