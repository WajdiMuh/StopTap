//
//  ScoreViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 5/7/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import GoogleMobileAds
import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ScoreViewController: UIViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var playag: UIButton!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var leaderb: UIButton!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var hscore: UILabel!
    @IBOutlet weak var gameo: UILabel!
    var scoreval:Int = Int()
    var newhighscoresc:Bool = Bool()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        App42API.enableApp42Trace(true)
        App42CacheManager.shared().setPolicy(APP42_NETWORK_FIRST)
    /*    if(ViewController.vars.signedin == 1){
        if(scoreval > Int(ViewController.vars.hscore)){
            print("hi")
        let gameName = "StopTap"
        let userName = KeychainWrapper.stringForKey("usern")
        let gameScore:Double = Double(scoreval)
        App42API.initialize(withAPIKey: "38ae8af214d06b5aadd7064f31bb329c0f80088b69aa25620407cae9a296612e", andSecretKey: "69d230877fded2ac9dd47e3d71daa8e601f00fe8d34a6f4d7e8279c93a6a93e1")
        App42API.setOfflineStorage(true)
        let scoreBoardService = App42API.buildScoreBoardService() as? ScoreBoardService
        scoreBoardService?.saveUserScore(gameName, gameUserName:userName, gameScore:gameScore, completionBlock: { (success, response, exception) -> Void in
            if(success)
            {
                let game = response as! Game
                if(game.isOfflineSync){
                    ViewController.vars.hscore = String(self.scoreval)
                    self.hscore.text = "HighScore : " + ViewController.vars.hscore
                }else{
                    ViewController.vars.hscore = String(self.scoreval)
                    self.hscore.text = "HighScore : " + ViewController.vars.hscore
                }
            }
            else
            {
                    
                    }
                })
            }
        } */
        if(KeychainWrapper.stringForKey("nm") == "0"){
            self.view.backgroundColor = UIColor.white
            playag.layer.borderColor = UIColor.black.cgColor
            menu.layer.borderColor = UIColor.black.cgColor
            leaderb.layer.borderColor = UIColor.black.cgColor
            playag.setTitleColor(UIColor.black, for: UIControlState())
            menu.setTitleColor(UIColor.black, for: UIControlState())
            leaderb.setTitleColor(UIColor.black, for: UIControlState())
            score.textColor = UIColor.black
            hscore.textColor = UIColor.black
            gameo.textColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.black
            playag.layer.borderColor = UIColor.white.cgColor
            menu.layer.borderColor = UIColor.white.cgColor
            leaderb.layer.borderColor = UIColor.white.cgColor
            playag.setTitleColor(UIColor.white, for: UIControlState())
            menu.setTitleColor(UIColor.white, for: UIControlState())
            leaderb.setTitleColor(UIColor.white, for: UIControlState())
            score.textColor = UIColor.white
            hscore.textColor = UIColor.white
            gameo.textColor = UIColor.white
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (newhighscoresc == true){
            confettistartstop(startstop: true)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (newhighscoresc == true){
            confettistartstop(startstop: false)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        App42API.initialize(withAPIKey: "38ae8af214d06b5aadd7064f31bb329c0f80088b69aa25620407cae9a296612e", andSecretKey: "69d230877fded2ac9dd47e3d71daa8e601f00fe8d34a6f4d7e8279c93a6a93e1")
        App42API.enableApp42Trace(false)
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = ["b22eef2b60b22ba7c7789438a3b61ae7"]
        bannerView.load(request)
        playag.layer.cornerRadius = 10
        playag.layer.borderWidth = 5
        menu.layer.cornerRadius = 10
        menu.layer.borderWidth = 5
        leaderb.layer.cornerRadius = 10
        leaderb.layer.borderWidth = 5
        score.text = "Score : " + String(scoreval)
       /* if (ViewController.vars.signedin == 1){
            hscore.text = "HighScore : " + ViewController.vars.hscore
        }else{
   
        } */
        if (KeychainWrapper.stringForKey("hscore") == nil){
            hscore.text = "HighScore : 0"
        }else{
            hscore.text = "HighScore : " + KeychainWrapper.stringForKey("hscore")!
        }
    }
    @IBAction func playagain(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menubutton(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func confettistartstop(startstop : Bool){
        let confettiView = SAConfettiView(frame: self.view.bounds)
        self.view.insertSubview(confettiView, at: 0)
        confettiView.isUserInteractionEnabled = false
        confettiView.colors = [UIColor.red, UIColor.blue]
        if(startstop == true){
            //start confetti
                confettiView.startConfetti()
        }else{
            //stop confetti
                confettiView.stopConfetti()
        }
    }
    @IBAction func leaderb(_ sender: AnyObject) {
        let leaderboard = App42Leaderboard.sharedInstance() as App42Leaderboard
        leaderboard.gameName = "StopTap"
        leaderboard.userName = ""
        leaderboard.numberOfRecords = 10000
        leaderboard.leaderboardType = kApp42_Social
        leaderboard.launch(self)
        //leaderboard.fetchLeaderboard({(success: Bool, error: NSError!) -> Void in
       //     if success {
         //       print("sucess")
         //   }
       //     else {
            //    print("fail")
            //    NSLog("Error = %@", error)
         //   }
      //  })
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return [UIInterfaceOrientationMask.portrait]
        case .pad:
            return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
        case .unspecified:
            return [UIInterfaceOrientationMask.portrait]
        default:
            return [UIInterfaceOrientationMask.portrait]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
 
}
