//
//  LoadingViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 3/27/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var left: UIImageView!
    @IBOutlet weak var center: UIImageView!
    @IBOutlet weak var right: UIImageView!
    @IBOutlet weak var cw: NSLayoutConstraint!
    @IBOutlet weak var ch: NSLayoutConstraint!
    @IBOutlet weak var rh: NSLayoutConstraint!
    @IBOutlet weak var rw: NSLayoutConstraint!
    @IBOutlet weak var lh: NSLayoutConstraint!
    @IBOutlet weak var lw: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        lw.constant = 50
        lh.constant = 50
        left.setNeedsLayout()
        UIView.animateWithDuration(0.5, delay: 0, options:[.Autoreverse], animations: {
            self.left.layoutIfNeeded()
            }, completion: {(finished: Bool) -> Void in
                self.lw.constant = 40
                self.lh.constant = 40
                if (finished == true){
                }else{
                }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
