//
//  AppDelegate.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit
import Appodeal
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy
    var demoModule = DemoModule()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = ViewController()
        window!.makeKeyAndVisible()

//        configureAppodeal()
        FirebaseApp.configure()

        return true
    }

    private
    func configureAppodeal() {
        Appodeal.setLogLevel(.debug)
        Appodeal.setAutocache(true, types: [.rewardedVideo])
        Appodeal.initialize(withApiKey: appodealApiKey,
                            types: [.rewardedVideo],
                            hasConsent: true)
    }


}

private
let appodealApiKey =  "e9c252aeb7fc1da8b0358eaac6f171e3e48cb5b0d5342d9d"

private
let appDefaults: [String: Any?] = [
    "first_button_title" : "WATCH VIDEO",
    "second_button_title" : "FREE PREMIUM",
    "first_button_color" : "FFDB57",
    "second_button_color" : "F7434C",
    "background_image" : "black.pdf"
]
