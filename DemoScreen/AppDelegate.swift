//
//  AppDelegate.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit
import Appodeal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy
    var demoModule = DemoModule()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = demoModule.viewController
        window!.makeKeyAndVisible()

        configureAppodeal()

        return true
    }

    private
    func configureAppodeal() {
        Appodeal.setLogLevel(.debug)
        Appodeal.setAutocache(true, types: [.banner, .rewardedVideo])
        Appodeal.initialize(withApiKey: appodealApiKey,
                            types: [.banner, .rewardedVideo],
                            hasConsent: true)
    }


}

private
let appodealApiKey =  "e9c252aeb7fc1da8b0358eaac6f171e3e48cb5b0d5342d9d"

