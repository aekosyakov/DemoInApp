//
//  DemoModule.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit
import Firebase

final
class DemoModule {
    
    var handleAction:((DemoAction?) -> Void)?
    
    var viewController: UIViewController {
        return tableViewController
    }
    
    private lazy
    var tableViewController = TableViewController().with {
        $0.didPress = { [weak self] variant in self?.showDemoScreen(variant: variant) }
    }

    init() {
        FirebaseApp.configure()
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { status, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            remoteConfig.activate(completionHandler: nil)
            let keys = remoteConfig.keys(withPrefix: "variant")
            self.tableViewController.variants = Array(keys)
        }
    }
    
    private
    func showDemoScreen(variant: String) {
        let jsonDict = RemoteConfig.remoteConfig().configValue(forKey: variant).jsonValue as? [String: Any]
        guard let uiConfig = UIConfig(jsonDict: jsonDict) else {
            return
        }
        
        let demoViewController = DemoViewController(uiConfig: uiConfig)
        demoViewController.action = self.handleAction
        self.viewController.present(demoViewController, animated: true, completion: nil)
    }

}
