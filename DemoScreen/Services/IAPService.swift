//
//  IAPService.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import StoreKit

private
let premiumProductIdentifier = "com.aekosyakov.DemoScreenApp.Premium"

public
enum PurchaseStatus {

    case success

    case failed(with: Error?)

}

enum IAPError: Error {

    case unknown

}



final
class IAPService: NSObject, IAPServiceProtocol  {

    var completion: ((PurchaseStatus) -> Void)?

    fileprivate
    var premiumSubscription: SKProduct?

    override
    init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }

    func purchasePremium() {
        guard let premiumProduct =  premiumSubscription else {
            return
        }
        purchaseProduct(premiumProduct)
    }

    func isPremiumPurchased() -> Bool {
        return UserDefaults.standard.bool(forKey: premiumProductIdentifier)
    }

    func loadAvailableSKProducts() {
        let request = SKProductsRequest(productIdentifiers: Set([premiumProductIdentifier]))
        request.delegate = self
        request.start()
    }

}

extension IAPService: SKProductsRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        premiumSubscription = response.products.first { $0.productIdentifier == premiumProductIdentifier }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        completion?(.failed(with: error))
    }

}

extension IAPService: SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchased, .restored:
                if $0.payment.productIdentifier == premiumProductIdentifier, isPremiumPurchased() == false {
                    UserDefaults.standard.set(true, forKey: premiumProductIdentifier)
                    completion?(.success)
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                SKPaymentQueue.default().finishTransaction($0)
                completion?(.failed(with: $0.error))
            case .deferred, .purchasing:
                completion?(.failed(with: $0.error))
                break
            }
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        completion?(.failed(with: error))
    }


}
