//
//  nm.swift
//  StopTap
//
//  Created by wajdi muhtadi on 5/14/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import Foundation
@objc open class nightmode:NSObject{
    let nm:Int = Int(KeychainWrapper.stringForKey("nm")!)!
}
