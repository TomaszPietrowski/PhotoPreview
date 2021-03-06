//
//  AppDelegate.swift
//  PhotoPreview
//
//  Created by Tomasz Pietrowski on 25.02.2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootConnector: RootConnector!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        connectRoot()
        return true
    }
    
    private func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
    private func connectRoot() {
        guard let window = window else {
            assertionFailure("No window available")
            return
        }
        rootConnector = RootConnector(in: window)
    }
}

