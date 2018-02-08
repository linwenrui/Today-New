//
//  DefaultNotificationCenter.swift
//  Today-New
//
//  Created by XH-LWR on 2018/2/8.
//  Copyright © 2018年 XH-LWR. All rights reserved.
//

import UIKit

// MARK: protocol DefaultNotificationCenterDelegate

protocol DefaultNoticicationCenterDelegate: class {
    
    
    /// DefaultNotificationCenter's event.
    ///
    /// - Parameters:
    ///   - notificationName: Event name
    ///   - object:           Event object, maybe nil.
    func defaultNotificationCenter(_ notificationName: String, object: AnyObject?)
}

// MARK: protocol DefaultNotificationCenter

class DefaultNotificationCenter: NSObject {
    
    // MARK: Properties & funcs
    
    
    /// DefaultNotificationCenter's delegate
    weak var delegate: DefaultNoticicationCenterDelegate?
    
    
    /// Post message to specified notification name
    ///
    /// - Parameters:
    ///   - name:   Notification name
    ///   - object: Data
    class func PostMessageTo(_ name: String, object: AnyObject? = nil) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object)
    }
    
    
    /// Add notification name.
    ///
    /// - Parameter name: Notification name.
    func addNotificationName(_ name: String) {
        
        var haveTheSameName = false
        
        // Check have the same name or not
        for model in notificationModels {
            
            if model.name == name {
                
                haveTheSameName = true
                break
            }
        }
        
        // Add notification
        if haveTheSameName == false {
            
            let model       = DefaultNotificationCenterModel()
            model.name      = name
            notificationModels.append(model)
            
            NotificationCenter.default.addObserver(self, selector: #selector(DefaultNotificationCenter.notificationEvent), name: Notification.Name(rawValue: model.name), object: nil)
        }
    }
    
    
    func deleteNotificationName(_ name: String) {
        
        var haveTheSameName = false
        var index : Int     = 0
        var model : DefaultNotificationCenterModel!
        
        // Check have the same name or not.
        for tmpModel in notificationModels {
            
            if tmpModel.name == name {
                
                haveTheSameName = true
                model           = tmpModel
                break
            }
            
            index = index + 1
        }
        
        
        if haveTheSameName == true {
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: model.name), object: nil)
            notificationModels.remove(at: index)
        }
    }
    
    /// Remove all notificatios
    func removeAllNotifications() {
        
        for model in notificationModels {
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: model.name), object: nil)
        }
    }
    
    
    /// Get all the notification names
    ///
    /// - Returns: Notification names's array
    func notificationNames() -> [String] {
        
        var names = [String]()
        
        for model in notificationModels {
            
            names.append(model.name)
        }
        
        return names
    }
    
    /// Notification's event.
    ///
    /// - Parameter obj: The NSNotification object.
    @objc func notificationEvent(_ obj: AnyObject?) {
        
        let notification = obj as! Notification
        delegate?.defaultNotificationCenter(notification.name.rawValue, object: notification.object as AnyObject?)
    }
    
    // AMRK: Private properties & func
    
    
    /// Store the Notification's infomation
    fileprivate var notificationModels: [DefaultNotificationCenterModel] = [DefaultNotificationCenterModel]()
    
    deinit {
        
        removeAllNotifications()
    }
}

// MARK: private DefaultNotificationCenterModel

private class DefaultNotificationCenterModel: NSObject {
    
    var name: String!
    
}
