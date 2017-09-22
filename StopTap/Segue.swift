//
//  SecondCustomSegue.swift
//  CustomSegues
//
//  Created by Gabriel Theodoropoulos on 20/12/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import UIKit

class SecondCustomSegue: UIStoryboardSegue {
    override func perform() {
        let firstVCView = sourceViewController.view as UIView!
        let thirdVCView = destinationViewController.view as UIView!
        let firstvc = self.sourceViewController as UIViewController
        let window = UIApplication.sharedApplication().keyWindow

        window?.insertSubview(thirdVCView, belowSubview: firstVCView)
        //thirdVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            firstVCView.center.x = (3 * firstVCView.center.x)
            //firstVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
            //firstVCView.layoutIfNeeded()
            //print(firstVCView.center.x)
        }) { (Finished) -> Void in
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    thirdVCView.transform = CGAffineTransformIdentity
                    
                    }, completion: { (Finished) -> Void in
                        firstVCView.transform = CGAffineTransformIdentity
                        firstvc.navigationController!.pushViewController(self.destinationViewController as UIViewController, animated: false)
                        //self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
                })
        }
        
    }
    
}
