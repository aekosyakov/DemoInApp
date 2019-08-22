//
//  InAppPurchases.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import StoreKit

public
protocol InAppPurchasable {

    var canMakeInAppPurchases: Bool { get }

    func purchaseProduct(_ product: SKProduct)

    func restoreCompletedTransactions()

    func loadAvailableSKProducts()

}

public
protocol PremiumPurchasable {

    func purchasePremium()

    var isPremiumPurchased: Bool { get }

}

protocol IAPServiceProtocol: InAppPurchasable, PremiumPurchasable { }

extension IAPServiceProtocol {

    var canMakeInAppPurchases: Bool {
        return SKPaymentQueue.canMakePayments()
    }

    func purchaseProduct(_ product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    func restoreCompletedTransactions() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

}
