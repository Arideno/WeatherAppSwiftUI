//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewModel = MainViewModel()
        let mainView = MainView(viewModel: mainViewModel)
        let controller = UIHostingController(rootView: mainView)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
    }


}

