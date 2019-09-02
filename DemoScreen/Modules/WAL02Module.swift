//
//  WAL02Module.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit
import Firebase

final
class WAL02Module {
    
    var handleAction:((Int?) -> Void)?
    
    var viewController: UIViewController {
        return tableViewController
    }
    
    private lazy
    var tableViewController = WAL02TableViewController().with {
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
        guard let uiConfig = WAL02UIConfig(jsonDict: jsonDict) else {
            return
        }
        
        let demoViewController = WAL02ViewController(uiConfig: uiConfig)
        demoViewController.action = { [weak self] action in
            self?.handleAction?(action?.rawValue)
        }
        self.viewController.present(demoViewController, animated: true, completion: nil)
    }

}
