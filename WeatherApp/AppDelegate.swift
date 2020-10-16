//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Triet Le on 16.10.2020.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    var bag = Set<AnyCancellable>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        // Make sure we have time to prepare for DARK MODE
        window?.overrideUserInterfaceStyle = .light

        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()

        return true
    }
}

