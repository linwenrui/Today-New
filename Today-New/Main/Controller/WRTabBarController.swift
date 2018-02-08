//
//  WRTabBarController.swift
//  Today-New
//
//  Created by XH-LWR on 2018/2/8.
//  Copyright © 2018年 XH-LWR. All rights reserved.
//

import UIKit

class WRTabBarController: UITabBarController {

    fileprivate let notification: DefaultNotificationCenter = DefaultNotificationCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        /// 添加子控制器
        addChildViewControllers()
        notification.delegate = self
        notification.addNotificationName(WRNotificationEvent.dayOrNightButtonClicked.Message())
    }
    
    func addChildViewControllers() {
        
        setChildViewController(WRHomeViewController(), title: "首页", imageName: "home")
        setChildViewController(WRVideoViewController(), title: "西瓜视频", imageName: "video")
        setChildViewController(WRRedPackageViewController(), title: "", imageName: "redpackage")
        setChildViewController(WRWeitoutiaoViewController(), title: "微头条", imageName: "weitoutiao")
        setChildViewController(WRHuoshanViewController(), title: "小视频", imageName: "huoshan")
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
        //        setValue(MyTabBar(), forKey: "tabBar")
    }
    
    /// 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        
        // 设置 tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        } else {
            setDayChildController(controller: childController, imageName: imageName)
        }
        childController.title = title
        childController.view.backgroundColor = UIColor.white
        // 添加导航控制器为 TabBarController 的子控制器
        let navVc = WRNavigationController(rootViewController: childController)
        addChildViewController(navVc)
    }
    
    deinit {
        
        notification.deleteNotificationName(WRNotificationEvent.dayOrNightButtonClicked.Message())
    }
}

extension WRTabBarController: DefaultNoticicationCenterDelegate {
    
    func defaultNotificationCenter(_ notificationName: String, object: AnyObject?) {
        /// 接收到了按钮点击的通知
        guard notificationName != WRNotificationEvent.dayOrNightButtonClicked.Message() else {
            
            let selected = object as! Bool
            if selected {
                
                for childController in childViewControllers {
                    
                    switch childController.title! {
                    case "首页":
                        setNightChildController(controller: childController, imageName: "home")
                    case "西瓜视频":
                        setNightChildController(controller: childController, imageName: "video")
                    case "小视频":
                        setNightChildController(controller: childController, imageName: "huoshan")
                    case "微头条":
                        setNightChildController(controller: childController, imageName: "weitoutiao")
                    case "":
                        setNightChildController(controller: childController, imageName: "redpackage")
                    default:
                        break
                    }
                }
            } else { /// 设置为日间
                
                for childController in childViewControllers {
                    
                    switch childController.title! {
                    case "首页":
                        setDayChildController(controller: childController, imageName: "home")
                    case "西瓜视频":
                        setDayChildController(controller: childController, imageName: "video")
                    case "小视频":
                        setDayChildController(controller: childController, imageName: "huoshan")
                    case "微头条":
                        setDayChildController(controller: childController, imageName: "weitoutiao")
                    case "":
                        setDayChildController(controller: childController, imageName: "redpackage")
                    default:
                        break
                    }
                }
            }
            return
        }
    }
    
    /// 设置夜间控制器
    private func setNightChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    /// 设置日间控制器起
    private func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
}
