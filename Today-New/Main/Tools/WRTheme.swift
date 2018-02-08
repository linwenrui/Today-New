//
//  WRTheme.swift
//  Today-New
//
//  Created by XH-LWR on 2018/2/8.
//  Copyright © 2018年 XH-LWR. All rights reserved.
//

import UIKit
import SwiftTheme

enum WRTheme: Int {
    case day = 0
    case night = 1
    
    static var before = WRTheme.day
    static var current = WRTheme.day
    
    /// 选择主题
    static func switchTo(_ theme: WRTheme) {
        
        before = current
        current = theme
        
        switch theme {
        case .day:
            ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        case .night:
            ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    /// 选择了夜间主题
    static func switchNight(_ isTonight: Bool) {
        
        switchTo(isTonight ? .night : .day)
    }
    
    /// 判断当前是否是夜间主题
    static func isNight() -> Bool {
        
        return current == .night
    }
}

struct WRThemeStyle {
    
    /// 设置导航样式 (日间, 夜间)
    static func setupNavigationBarStyle(_ viewController: UIViewController, _ isNight: Bool) {
        
        if isNight { // 设置夜间主题
         
            viewController.navigationController?.navigationBar.barStyle = .black
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white_night"), for: .default)
            viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.grayColor113()]
        } else {
            
            viewController.navigationController?.navigationBar.barStyle = .default
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white"), for: .default)
        }
    }
}
