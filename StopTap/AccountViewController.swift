//
//  AccountViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 5/29/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var signin: UIButton!
    @IBOutlet weak var createacc: UIButton!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var leader: UIButton!
    @IBOutlet weak var so: UIButton!
    @IBOutlet weak var leader1: UIButton!
    @IBOutlet weak var menu1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signin.layer.cornerRadius = 10
        signin.layer.borderWidth = 5
        menu.layer.cornerRadius = 10
        menu.layer.borderWidth = 5
        createacc.layer.cornerRadius = 10
        createacc.layer.borderWidth = 5
        leader.layer.cornerRadius = 10
        leader.layer.borderWidth = 5
        menu1.layer.cornerRadius = 10
        menu1.layer.borderWidth = 5
        so.layer.cornerRadius = 10
        so.layer.borderWidth = 5
        leader1.layer.cornerRadius = 10
        leader1.layer.borderWidth = 5
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signin.isExclusiveTouch = true
        createacc.isExclusiveTouch = true
        menu.isExclusiveTouch = true
        leader.isExclusiveTouch = true
        so.isExclusiveTouch = true
        menu1.isExclusiveTouch = true
        leader1.isExclusiveTouch = true
       /* if(ViewController.vars.signedin == 1){
            signin.isHidden = true
            createacc.isHidden = true
            leader.isHidden = true
            menu.isHidden = true
            so.isHidden = false
            menu1.isHidden = false
            leader1.isHidden = false
            signin.isEnabled = false
            createacc.isEnabled = false
            leader.isEnabled = false
            menu.isEnabled = false
            so.isEnabled = true
            menu1.isEnabled = true
            leader1.isEnabled = true
        }else{
            signin.isHidden = false
            createacc.isHidden = false
            leader.isHidden = false
            menu.isHidden = false
            so.isHidden = true
            menu1.isHidden = true
            leader1.isHidden = true
            signin.isEnabled = true
            createacc.isEnabled = true
            leader.isEnabled = true
            menu.isEnabled = true
            so.isEnabled = false
            menu1.isEnabled = false
            leader1.isEnabled = false
        }*/
        App42CacheManager.shared().setPolicy(APP42_NETWORK_FIRST)
        App42API.initialize(withAPIKey: "38ae8af214d06b5aadd7064f31bb329c0f80088b69aa25620407cae9a296612e", andSecretKey: "69d230877fded2ac9dd47e3d71daa8e601f00fe8d34a6f4d7e8279c93a6a93e1")
        if(KeychainWrapper.stringForKey("nm") == "0"){
            self.view.backgroundColor = UIColor.white
            signin.layer.borderColor = UIColor.black.cgColor
            createacc.layer.borderColor = UIColor.black.cgColor
            menu.layer.borderColor = UIColor.black.cgColor
            leader.layer.borderColor = UIColor.black.cgColor
            so.layer.borderColor = UIColor.black.cgColor
            menu1.layer.borderColor = UIColor.black.cgColor
            leader1.layer.borderColor = UIColor.black.cgColor
            createacc.setTitleColor(UIColor.black, for: UIControlState())
            menu.setTitleColor(UIColor.black, for: UIControlState())
            signin.setTitleColor(UIColor.black, for: UIControlState())
            leader.setTitleColor(UIColor.black, for: UIControlState())
            menu1.setTitleColor(UIColor.black, for: UIControlState())
            so.setTitleColor(UIColor.black, for: UIControlState())
            leader1.setTitleColor(UIColor.black, for: UIControlState())
        }else{
            self.view.backgroundColor = UIColor.black
            signin.layer.borderColor = UIColor.white.cgColor
            menu.layer.borderColor = UIColor.white.cgColor
            createacc.layer.borderColor = UIColor.white.cgColor
            leader.layer.borderColor = UIColor.white.cgColor
            menu1.layer.borderColor = UIColor.white.cgColor
            so.layer.borderColor = UIColor.white.cgColor
            leader1.layer.borderColor = UIColor.white.cgColor
            createacc.setTitleColor(UIColor.white, for: UIControlState())
            menu.setTitleColor(UIColor.white, for: UIControlState())
            signin.setTitleColor(UIColor.white, for: UIControlState())
            leader.setTitleColor(UIColor.white, for: UIControlState())
            menu1.setTitleColor(UIColor.white, for: UIControlState())
            so.setTitleColor(UIColor.white, for: UIControlState())
            leader1.setTitleColor(UIColor.white, for: UIControlState())
        }
    }
    
    @IBAction func sob(_ sender: AnyObject) {
       // ViewController.vars.signedin = 0
        KeychainWrapper.setString("0", forKey: "sign")
        signin.isHidden = false
        createacc.isHidden = false
        leader.isHidden = false
        menu.isHidden = false
        so.isHidden = true
        menu1.isHidden = true
        leader1.isHidden = true
        signin.isEnabled = true
        createacc.isEnabled = true
        leader.isEnabled = true
        menu.isEnabled = true
        so.isEnabled = false
        menu1.isEnabled = false
        leader1.isEnabled = false
    }
    @IBAction func leaderb(_ sender: AnyObject) {
        let leaderboard = App42Leaderboard.sharedInstance() as App42Leaderboard
        leaderboard.gameName = "StopTap"
        leaderboard.userName = ""
        leaderboard.numberOfRecords = 10000
        leaderboard.leaderboardType = kApp42_Social
        leaderboard.launch(self)
    }
    @IBAction func menub(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
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
