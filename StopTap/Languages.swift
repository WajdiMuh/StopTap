//
//  File.swift
//  StopTap
//
//  Created by wajdi muhtadi on 1/30/18.
//  Copyright © 2018 wajdi muhtadi. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func arabic(size:Int,diffinsize:Int){
        self.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
        self.titleLabel?.arabic(size: size, diffinsize: diffinsize)
    }
    func english(size:Int,diffinsize:Int,left:Int,top:Int){
        self.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(top),CGFloat(left),0,0)
        self.titleLabel?.english(size: size, diffinsize: diffinsize)
    }
}
extension UILabel {
    
    func arabic(size:Int,diffinsize:Int){
        if(UIDevice.current.userInterfaceIdiom == .phone){
            font = UIFont.systemFont(ofSize: CGFloat(size))
        }else{
             font = UIFont.systemFont(ofSize: CGFloat(size + diffinsize))
        }
    }
    func english(size:Int,diffinsize:Int){
        if(UIDevice.current.userInterfaceIdiom == .phone){
            font = UIFont(name:"DotsAllForNowJL", size:CGFloat(size))
        }else{
            font = UIFont(name:"DotsAllForNowJL", size:CGFloat(size + diffinsize))
        }
    
    }
}
