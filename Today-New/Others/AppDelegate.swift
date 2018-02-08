//
//  AppDelegate.swift
//  Today-New
//
//  Created by XH-LWR on 2018/2/8.
//  Copyright © 2018年 XH-LWR. All rights reserved.
//

import UIKit
import SwiftTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        /// 设置主题颜色
        ThemeManager.setTheme(plistName: UserDefaults.standard.bool(forKey: isNight) ? "night_theme" : "default_theme", path: .mainBundle)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = WRTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}

