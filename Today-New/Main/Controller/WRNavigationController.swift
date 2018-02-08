//
//  WRNavigationController.swift
//  Today-New
//
//  Created by XH-LWR on 2018/2/8.
//  Copyright © 2018年 XH-LWR. All rights reserved.
//

import UIKit
import SwiftTheme

class WRNavigationController: UINavigationController {

    fileprivate let notification: DefaultNotificationCenter = DefaultNotificationCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar.appearance()
        navigationBar.theme_tintColor = "colors.balck"
        navigationBar.setBackgroundImage(UIImage(named: "navigation_background" + (UserDefaults.standard.bool(forKey: isNight) ? "_night" : "")), for: .default)
        // 添加通知
        notification.delegate = self
        notification.addNotificationName(WRNotificationEvent.dayOrNightButtonClicked.Message())
    }
    
    // 拦截 push 操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigatiionBack))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // 返回上一个控制器
    @objc private func navigatiionBack() {
        
        popViewController(animated: true)
    }

    deinit {
        notification.deleteNotificationName(WRNotificationEvent.dayOrNightButtonClicked.Message())
    }
}

extension WRNavigationController: DefaultNoticicationCenterDelegate {
    
    // 接收到按钮点击的通知
    func defaultNotificationCenter(_ notificationName: String, object: AnyObject?) {
        
        // 设置为夜间/日间
        navigationBar.setBackgroundImage(UIImage(named: "navigation_background" + (object as! Bool ? "_night" : "")), for: .default)
    }
}
