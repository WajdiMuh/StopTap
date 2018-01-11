//
//  HtpViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 4/1/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//
import UIKit
import AVFoundation
class HtpViewController: UIViewController,AVAudioPlayerDelegate {
    @IBOutlet weak var wrong: UIImageView!
    @IBOutlet weak var wrong2: UIImageView!
    @IBOutlet weak var wrong3: UIImageView!
    @IBOutlet weak var base: UIImageView!
    @IBOutlet weak var movel: NSLayoutConstraint!
    @IBOutlet weak var move: UIImageView!
    var countdown:Foundation.Timer = Foundation.Timer()
    var canclick:Bool = false
    var score:Int = 0
    var coins:Int = 0
    var audioPlayer: AVAudioPlayer!
    @IBOutlet weak var timecount: UILabel!
    @IBOutlet weak var scoreval: UILabel!
    @IBOutlet weak var viewclick: UIButton!
    @IBOutlet weak var baseanim: UIImageView!
    @IBOutlet weak var basew: NSLayoutConstraint!
    @IBOutlet weak var baseh: NSLayoutConstraint!
    @IBOutlet weak var movew: NSLayoutConstraint!
    @IBOutlet weak var moveh: NSLayoutConstraint!
    @IBOutlet weak var baseanimh: NSLayoutConstraint!
    @IBOutlet weak var baseanimw: NSLayoutConstraint!
    @IBOutlet weak var x2l: NSLayoutConstraint!
    @IBOutlet weak var x2h: NSLayoutConstraint!
    @IBOutlet weak var x2t: NSLayoutConstraint!
    @IBOutlet weak var x2w: NSLayoutConstraint!
    @IBOutlet weak var doublescore: UIButton!
    @IBOutlet weak var coinval: UILabel!
    
    @IBOutlet weak var back: UIButton!
    
    let layerfixbase:CALayer = CALayer()
    var doubleon:Bool = false
    @IBOutlet weak var dir: UIImageView!
    @IBOutlet weak var dirw: NSLayoutConstraint!
    @IBOutlet weak var dirh: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        wrong.image = wrong.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        wrong2.image = wrong2.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        wrong3.image = wrong3.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "correct", ofType: "mp3")!))
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.delegate = self
        } catch {
        }
        movew.constant = ((35 * self.view.bounds.width) / 411)
        moveh.constant = ((35 * self.view.bounds.width) / 411)
        basew.constant = ((50 * self.view.bounds.width) / 411)
        baseh.constant = ((50 * self.view.bounds.width) / 411)
        baseanimh.constant = ((63 * self.view.bounds.width) / 411)
        baseanimw.constant = ((63 * self.view.bounds.width) / 411)
        x2h.constant = ((35 * self.view.bounds.width) / 411)
        x2w.constant = ((35 * self.view.bounds.width) / 411)
        dirw.constant = ((40 * self.view.bounds.width) / 411)
        dirh.constant = ((40 * self.view.bounds.width) / 411)
        layerfixbase.frame = CGRect(x: -1, y: -1, width: basew.constant + 2, height: baseh.constant + 2)
        layerfixbase.cornerRadius = ((5 * self.view.bounds.width) / 411)
        layerfixbase.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        layerfixbase.masksToBounds = true
        layerfixbase.allowsEdgeAntialiasing = true
        base.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        base.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        move.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        move.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        base.layer.addSublayer(layerfixbase)
        baseanim.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        baseanim.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        base.layer.allowsEdgeAntialiasing = true
        move.layer.allowsEdgeAntialiasing = true
        baseanim.layer.allowsEdgeAntialiasing = true
        doublescore.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        dir.image = dir.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.back.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            timecount.textColor = UIColor.black
            scoreval.textColor = UIColor.black
            base.layer.borderColor = UIColor.black.cgColor
            move.layer.borderColor = UIColor.black.cgColor
            baseanim.layer.borderColor = UIColor.black.cgColor
            baseanim.backgroundColor = UIColor.black
            layerfixbase.borderColor = UIColor.black.cgColor
            doublescore.backgroundColor = UIColor.black
            doublescore.setTitleColor(UIColor.white, for: UIControlState())
            coinval.textColor = UIColor.black
            dir.tintColor = UIColor.black
            back.tintColor = UIColor.black
            
        }else{
            self.view.backgroundColor = UIColor.black
            timecount.textColor = UIColor.white
            scoreval.textColor = UIColor.white
            baseanim.backgroundColor = UIColor.white
            base.layer.borderColor = UIColor.white.cgColor
            move.layer.borderColor = UIColor.white.cgColor
            baseanim.layer.borderColor = UIColor.white.cgColor
            layerfixbase.borderColor = UIColor.white.cgColor
            doublescore.backgroundColor = UIColor.white
            doublescore.setTitleColor(UIColor.black, for: UIControlState())
            coinval.textColor = UIColor.white
            dir.tintColor = UIColor.white
            back.tintColor = UIColor.black
        }
        switch provider.getInt(forKey: "shopselect", defaultValue: 1) {
        case 1:
            move.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            base.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            break;
        case 2:
            move.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)
            break;
        case 3:
            move.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            break;
        case 4:
            move.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            break;
        case 5:
            move.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            break;
        case 6:
            move.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            break;
        case 7:
            move.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            break;
        case 8:
            move.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            break;
        case 9:
            move.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            break;
        case 10:
            move.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            break;
        case 11:
            move.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            base.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            break;
        case 12:
            move.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0)
            base.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            break;
        case 15:
            move.backgroundColor = UIColor(hexString: provider.getString(forKey: "cpsc", defaultValue: "#004cff"))
            base.backgroundColor = UIColor(hexString:  provider.getString(forKey: "cpbc", defaultValue: "#ff0000"))
            break;
        default:
            move.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            base.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            break;
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        countdown = Foundation.Timer(timeInterval: 0.5, target: self, selector: #selector(HtpViewController.time), userInfo: nil, repeats: false)
         RunLoop.current.add(countdown, forMode: RunLoopMode.commonModes)
        x2t.constant = ((((base.frame.origin.y - (timecount.frame.origin.y + timecount.frame.size.height)) / 2) + timecount.frame.origin.y + timecount.frame.size.height) - (x2h.constant / 2))
        print("x2t" + String(describing: x2t.constant))
        x2l.constant = -1 * x2w.constant
        doublescore.titleLabel!.adjustsFontSizeToFitWidth = true
        doublescore.titleLabel!.numberOfLines = 1
        doublescore.titleLabel!.minimumScaleFactor = 0.05
        //doublescore.clipsToBounds = true
        doublescore.titleLabel?.baselineAdjustment = .alignCenters
        doublescore.titleLabel?.textAlignment  = .center
        timecount.adjustsFontSizeToFitWidth = true
        timecount.numberOfLines = 3
        timecount.minimumScaleFactor = 0.5
        //timecount.clipsToBounds = true
     //   doublescore.titleLabel?.baselineAdjustment = .alignCenters
       // doublescore.titleLabel?.textAlignment  = .center
    }
    @IBAction func viewcl(_ sender: AnyObject) {
        if(canclick == true){
            if(move.tag == 1){
                timecount.text = ""
                wrong.alpha = 1.0
             //   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                move.tag = 2
                canclick = false
                movel.constant = (self.view.bounds.width/2) - (self.move.bounds.width/2)
                move.setNeedsLayout()
                UIView.animate(withDuration: 1, delay: 0, options:[], animations: {
                    self.move.superview?.layoutIfNeeded()
                    }, completion: {(finished: Bool) -> Void in
                        self.timecount.text = "Tap On The Screen While The Small Box Is Inside The Big Box To Gain Score. Tap Now ▼"
                        self.move.tag = 2
                        self.canclick = true
                })
            }else if(move.tag == 2){
                self.baseanim.layer.removeAllAnimations()
                UIView.commitAnimations()
                if(score == 0){
                    audioPlayer.pause()
                    audioPlayer.currentTime = 0
                    audioPlayer.play()
                    baseanim.isHidden = false
                    self.baseanim.transform = CGAffineTransform(scaleX: 1, y: 1)
                    UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                        self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
                        }, completion:
                        {(finished: Bool) -> Void in
                            if (finished == true){
                                self.baseanim.isHidden = true
                            }
                        }
                    )
                        timecount.text = ""
                        doublescore.isHidden = false
                        doublescore.isEnabled = true
                        doublescore.isUserInteractionEnabled = true
                        self.x2l.constant = (self.view.bounds.width/2) - (self.x2w.constant/2)
                        doublescore.setNeedsLayout()
                        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                            self.doublescore.superview?.layoutIfNeeded()
                        }, completion: {(finished: Bool) -> Void in
                            if(finished == true){
                                self.timecount.text = "If You Tap On The Double Score Sign You Will Gain Double The Score This Lasts For 10 Seconds. Tap Now ▼"
                            }
                        })
                    score = score + 1
                    scoreval.text = "Score : " + String(score)
                    coins = coins + 1
                    coinval.text = String(coins)
                }else if (score == 1){
                    if(doubleon == true){
                        audioPlayer.pause()
                        audioPlayer.currentTime = 0
                        audioPlayer.play()
                        baseanim.isHidden = false
                        self.baseanim.transform = CGAffineTransform(scaleX: 1, y: 1)
                        UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                            self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
                        }, completion:
                            {(finished: Bool) -> Void in
                                if (finished == true){
                                    self.baseanim.isHidden = true
                                }
                        }
                        )
                        score = score + 2
                        scoreval.text = "Score : " + String(score)
                        coins = coins + 1
                        coinval.text = String(coins)
                        timecount.text = "Swipe In The Direction Of The Arrow To Gain 4 Extra Coins. Swipe Now ▼"
                    }
                }
                }
        }
    }
    @IBAction func x2touchdown(_ sender: Any) {
        doubleon = true
        timecount.text = "Tap On The Screen While The Small Box Is Inside The Big Box And The Double Score Is Active To Gain Double The Score. Tap Now ▼"
        doublescore.isEnabled = false
        doublescore.isHidden = true
        doublescore.isUserInteractionEnabled = false
    }
    @objc func time(){
        countdown.invalidate()
        movel.constant = (self.view.bounds.width/4) - (self.move.bounds.width/2)
        move.setNeedsLayout()
        UIView.animate(withDuration: 1, delay: 0, options:[], animations: {
            self.move.superview?.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
            self.timecount.text = "If You Tap The Screen While The Small Box Is Outside The Big Box You Will Lose A Life. Tap Now ▼"
            self.move.tag = 1
            self.canclick = true
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func swiperight(){
        self.viewclick.gestureRecognizers?.removeAll()
        self.dir.isHidden = true
        coins = coins + 5
        coinval.text = String(coins)
        audioPlayer.pause()
        audioPlayer.currentTime = 0
        audioPlayer.play()
        baseanim.isHidden = false
        self.baseanim.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
            self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
        }, completion:
            {(finished: Bool) -> Void in
                if (finished == true){
                    self.baseanim.isHidden = true
                }
        }
        )
        score = score + 1
        scoreval.text = "Score : " + String(score)
        timecount.text = ""
        countdown = Foundation.Timer(timeInterval: 0.75, target: self, selector: #selector(HtpViewController.finish), userInfo: nil, repeats: false)
        RunLoop.current.add(countdown, forMode: RunLoopMode.commonModes)
    }
    @objc func finish(){
        countdown.invalidate()
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func touchcancel(_ sender: Any) {
        self.dir.isHidden = true
        self.viewclick.gestureRecognizers?.removeAll()
    }
    @IBAction func touchout(_ sender: Any) {
        self.dir.isHidden = true
        self.viewclick.gestureRecognizers?.removeAll()
    }
    @IBAction func touchin(_ sender: Any) {
        if(coins == 2){
        dir.isHidden = false
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(HtpViewController.swiperight))
        swiperight.direction = UISwipeGestureRecognizerDirection.right
        self.viewclick.addGestureRecognizer(swiperight)
        }
    }
    @IBAction func backclick(_ sender: Any) {
        countdown.invalidate()
        self.navigationController?.popToRootViewController(animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
