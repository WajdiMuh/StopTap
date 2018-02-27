//
//  ScoreViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 5/7/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//
import AudioToolbox
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


class ScoreViewController: UIViewController,STABannerDelegateProtocol {
    @IBOutlet weak var playag: UIButton!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var leaderb: UIButton!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var hscore: UILabel!
    @IBOutlet weak var gameo: UILabel!
    var adview: STABannerView?
    @IBOutlet weak var scoreon: NSLayoutConstraint!
    @IBOutlet weak var menucon: NSLayoutConstraint!
    var scoreval:Int = Int()
    var newhighscoresc:Bool = Bool()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //App42API.enableApp42Trace(true)
       // App42CacheManager.shared().setPolicy(APP42_NETWORK_FIRST)
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
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch (provider.getInt(forKey: "lang", defaultValue: 1)) {
        case 0:
            gameo.text = "انتهت اللعبة"
            gameo.arabic(size: 28, diffinsize: 14)
            hscore.arabic(size: 24, diffinsize: 14)
            score.arabic(size: 24, diffinsize: 14)
            playag.setTitle("العب مرة أخرى", for: UIControlState())
            playag.arabic(size: 20, diffinsize: 10)
            menu.setTitle("القائمة", for: UIControlState())
            menu.arabic(size: 20, diffinsize: 10)
            leaderb.setTitle("المتصدرين", for: UIControlState())
            leaderb.arabic(size: 20, diffinsize: 10)
            break
        case 1:
            gameo.text = "Game Over"
            gameo.english(size: 28, diffinsize: 14)
            hscore.english(size: 24, diffinsize: 14)
            score.english(size: 24, diffinsize: 14)
            menu.setTitle("Menu", for: UIControlState())
            menu.english(size: 20, diffinsize: 10,left: 3,top: 2)
            playag.setTitle("Play Again", for: UIControlState())
            playag.english(size: 20, diffinsize: 10,left: 3,top: 2)
            leaderb.setTitle("Leaderboard", for: UIControlState())
            leaderb.english(size: 20, diffinsize: 10,left: 3,top: 2)
            break
        default:
            gameo.text = "Game Over"
            gameo.english(size: 28, diffinsize: 14)
            hscore.english(size: 24, diffinsize: 14)
            score.english(size: 24, diffinsize: 14)
            menu.setTitle("Menu", for: UIControlState())
            menu.english(size: 20, diffinsize: 10,left: 3,top: 2)
            playag.setTitle("Play Again", for: UIControlState())
            playag.english(size: 20, diffinsize: 10,left: 3,top: 2)
            leaderb.setTitle("Leaderboard", for: UIControlState())
            leaderb.english(size: 20, diffinsize: 10,left: 3,top: 2)
            break
        }
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            playag.layer.borderColor = UIColor.black.cgColor
            menu.layer.borderColor = UIColor.black.cgColor
            leaderb.layer.borderColor = UIColor.black.cgColor
            playag.backgroundColor = UIColor.white
            menu.backgroundColor = UIColor.white
            leaderb.backgroundColor = UIColor.white
            playag.setTitleColor(UIColor.black, for: UIControlState())
            menu.setTitleColor(UIColor.black, for: UIControlState())
            leaderb.setTitleColor(UIColor.black, for: UIControlState())
            score.textColor = UIColor.black
            hscore.textColor = UIColor.black
            gameo.textColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.black
            playag.backgroundColor = UIColor.black
            menu.backgroundColor = UIColor.black
            leaderb.backgroundColor = UIColor.black
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
        if (adview == nil) {
            adview = STABannerView(size: STA_PortraitAdSize_320x50, autoOrigin: STAAdOrigin_Top, with: self.view, withDelegate: self);
            adview?.isHidden = true
            self.view.addSubview(adview!)
        }
    }
    
    func failedLoadBannerAd(_ banner: STABannerView!, withError error: Error!) {
    }
    func didDisplayBannerAd(_ banner: STABannerView!) {
        banner.isHidden = false
        scoreon.constant = 60
        if(UIDevice.current.userInterfaceIdiom == .phone){
            menucon.constant = 32
            menu.setNeedsLayout()
        }
        self.score.setNeedsLayout()
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {() -> Void in
            self.score.superview?.layoutIfNeeded()
            self.score.superview?.layoutIfNeeded()
        }, completion: {(_ finished: Bool) -> Void in
        })
    }
    func didClickBannerAd(_ banner: STABannerView!) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (newhighscoresc == true){
            confettistartstop(startstop: false)
        }
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     App42API.initialize(withAPIKey: "38ae8af214d06b5aadd7064f31bb329c0f80088b69aa25620407cae9a296612e", andSecretKey: "69d230877fded2ac9dd47e3d71daa8e601f00fe8d34a6f4d7e8279c93a6a93e1")
     //   App42API.enableApp42Trace(false)
        playag.layer.cornerRadius = 10
        playag.layer.borderWidth = 5
        menu.layer.cornerRadius = 10
        menu.layer.borderWidth = 5
        leaderb.layer.cornerRadius = 10
        leaderb.layer.borderWidth = 5
        playag.isExclusiveTouch = true
        leaderb.isExclusiveTouch = true
        menu.isExclusiveTouch = true
        //bannerView.adSize = kGADAdSizeBanner
        //bannerView.adUnitID = "ca-app-pub-2696736592488105/3092838566"
        //bannerView.rootViewController = self
        //let request = GADRequest()
       // bannerView.load(request)
       /* if (ViewController.vars.signedin == 1){
            hscore.text = "HighScore : " + ViewController.vars.hscore
        }else{
   
        } */
        
        //adfalcon
        
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch (provider.getInt(forKey: "lang", defaultValue: 1)) {
        case 0:
            score.text = "النتيجة : " + convertEngNumToPersianNum(num: String(scoreval))
            break
        case 1:
            score.text = "Score : " + String(scoreval)
            break
        default:
            score.text = "Score : " + String(scoreval)
            break
        }
        if (provider.exists(forKey: "hscore") == false){
            self.hscore.isHidden = true
        }else{
            switch (provider.getInt(forKey: "lang", defaultValue: 1)) {
            case 0:
                hscore.text = "أعلى نتيجة : " + convertEngNumToPersianNum(num: String(provider.getInt(forKey: "hscore")))
                break
            case 1:
                 hscore.text = "HighScore : " + String(provider.getInt(forKey: "hscore"))
                break
            default:
                 hscore.text = "HighScore : " + String(provider.getInt(forKey: "hscore"))
                break
            }
            self.hscore.isHidden = false
        }
    }
    @IBAction func playagain(_ sender: AnyObject) {
        if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menubutton(_ sender: AnyObject) {
        if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func leadertouch(_ sender: Any) {
        if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    }
    func confettistartstop(startstop : Bool){
        let confettiView = SAConfettiView(frame: self.view.bounds)
        self.view.insertSubview(confettiView, at: 0)
        confettiView.isUserInteractionEnabled = false
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch provider.getInt(forKey: "shopselect", defaultValue: 1) {
        case 1:
            confettiView.colors =  [UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0),UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)]
            break;
        case 2:
            confettiView.colors =  [UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0),UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)]
            break;
        case 3:
            confettiView.colors =  [UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0),UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)]
            break;
        case 4:
            confettiView.colors =  [UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0),UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)]
            break;
        case 5:
            confettiView.colors =  [UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0),UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)]
            break;
        case 6:
            confettiView.colors =  [UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0),UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)]
            break;
        case 7:
               confettiView.colors =  [UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)]
            break;
        case 8:
            confettiView.colors =  [UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0),UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)]
            break;
        case 9:
            confettiView.colors =  [UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0),UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)]
            break;
        case 10:
            confettiView.colors =  [UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0),UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)]
            break;
        case 11:
            confettiView.colors =  [UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0),UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)]
            break;
        case 12:
            confettiView.colors =  [UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0),UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)]
            break;
        case 15:
             confettiView.colors =  [UIColor(hexString: provider.getString(forKey: "cpsc", defaultValue: "#004cff")),UIColor(hexString:  provider.getString(forKey: "cpbc", defaultValue: "#ff0000"))]
            break;
        default:
            confettiView.colors =  [UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0),UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)]
            break;
        }
        
        if(startstop == true){
            //start confetti
                confettiView.startConfetti()
        }else{
            //stop confetti
                confettiView.stopConfetti()
        }
    }
    @IBAction func leaderb(_ sender: AnyObject) {
        //let leaderboard = App42Leaderboard.sharedInstance() as App42Leaderboard
       // leaderboard.gameName = "StopTap"
      //  leaderboard.userName = ""
       // leaderboard.numberOfRecords = 10000
       // leaderboard.leaderboardType = kApp42_Social
      //  leaderboard.launch(self)
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
        return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func convertEngNumToPersianNum(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ar_JO")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        return faNumber!
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
 
}
