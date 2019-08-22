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
            loadAvailableSKProducts()
            return
        }
        purchaseProduct(premiumProduct)
    }

    var isPremiumPurchased: Bool {
        return UserDefaults.standard.bool(forKey: premiumProductIdentifier)
    }

    func loadAvailableSKProducts() {
        guard !isPremiumPurchased else {
            return
        }
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
        completion?(.failed(with: nil))
    }

}

extension IAPService: SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        guard let premiumTransaction = transactions.filter({ $0.payment.productIdentifier == premiumProductIdentifier }).first else {
            return
        }
        switch premiumTransaction.transactionState {
        case .purchased, .restored:
            UserDefaults.standard.set(true, forKey: premiumProductIdentifier)
            SKPaymentQueue.default().finishTransaction(premiumTransaction)
            completion?(.success)
        case .failed:
            SKPaymentQueue.default().finishTransaction(premiumTransaction)
            completion?(.failed(with: premiumTransaction.error))
        case .deferred, .purchasing:
            completion?(.failed(with: nil))
            break
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        completion?(.failed(with: error))
    }


}
