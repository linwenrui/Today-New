//
//  WRNotificationEvent.swift
//  Today-New
//
//  Created by XH-LWR on 2018/2/8.
//  Copyright © 2018年 XH-LWR. All rights reserved.
//

import Foundation

enum WRNotificationEvent: Int {

    case dayOrNightButtonClicked
    
    func Message() -> String {
        
        switch self {
            
        case .dayOrNightButtonClicked:
            return "dayOrNightButtonClicked"
        }
    }
}
