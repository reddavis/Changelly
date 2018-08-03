# Changelly

This library is still under heavy development as it is being built alongside the macOS app [Quids](http://producthunt.com/upcoming/quids). Expect breaking changes!

## Install

```
github "reddavis/Changelly"
```

## Usage

```
let apiClient = ChangellyAPIClient(key: "yourKey", secret: "yourSecret")

// Fetch currency list
apiClient.fetchFullCurrencyList { (currencies, error) in
    // ...
}

// Create transaction
var template = ChangellyAPIClient.TransactionTemplate()
template.fromCurrencyCode = "eth"
template.toCurrencyCode = "btc"
template.amount = 123.0
template.address = "3FWKTEGJRy6DCeydrEcJ7rd9K9vMH5QwJf"

apiClient.create(transaction: template, completionHandler: { (transaction, error) in {
    // ...
}

```

### Requests

Only a few requests are currently supported, more will be added as we add features to [Quids](http://producthunt.com/upcoming/quids).

```
public func fetchFullCurrencyList(_ completionHandler: @escaping (_ currencies: [Currency]?, _ error: Error?) -> Void)
public func fetchMinimumExchangeableAmount(from: String, to: String, completionHandler: @escaping (_ amount: Double?, _ error: Error?) -> Void)
public func fetchEstimatedExchangeAmount(from: String, to: String, amount: Double, completionHandler: @escaping (_ amount: Double?, _ error: Error?) -> Void)
public func create(transaction: TransactionTemplate, completionHandler: @escaping (_ transaction: Transaction?, _ error: Error?) -> Void)
public func fetchStatus(for transactionID: String, completionHandler: @escaping (_ status: TransactionStatus?, _ error: Error?) -> Void)
```

## License

[MIT License](http://www.opensource.org/licenses/MIT).
