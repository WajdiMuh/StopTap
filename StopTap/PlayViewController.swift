//
//  PlayViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 3/19/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
class PlayViewController: UIViewController {
    @IBOutlet weak var move: UIImageView!
    @IBOutlet weak var base: UIImageView!
    var time:Double = 3
    var score:Int = 0
    var gright:Bool = true
    var pausetf:Bool = false
    var wrongnum:Int = 0
    var gameovercheck:Int = 0
    var extrascorerandom:Int = Int(arc4random_uniform(9) + 2)
    var audioPlayer: AVAudioPlayer!
    let coinmulti:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop14", defaultValue: 1)
    var coinv:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "cv", defaultValue: 0)
    var newhighscore:Bool = false
    var doubletimer:Timerp = Timerp()
    var doubletimerlast:Timerp = Timerp()
    var doubleon:Bool = false
    var pausedtime:CFTimeInterval = CFTimeInterval()
    var pausedmovetime:CFTimeInterval = CFTimeInterval()
    var randromdoubletime:Double = Double(arc4random_uniform(5) + 5)
    let layerfixbase:CALayer = CALayer()
    @IBOutlet weak var x2top: NSLayoutConstraint!
    @IBOutlet weak var doublescore: UIButton!
    @IBOutlet weak var x2l: NSLayoutConstraint!
    @IBOutlet weak var x2h: NSLayoutConstraint!
    @IBOutlet weak var x2w: NSLayoutConstraint!
    @IBOutlet weak var dir: UIImageView!
    @IBOutlet weak var wrong2: UIImageView!
    @IBOutlet weak var wrong3: UIImageView!
    @IBOutlet weak var wrong4: UIImageView!
    @IBOutlet weak var scoreval: UILabel!
    @IBOutlet weak var coinvalue: UILabel!
    @IBOutlet weak var coin: UIImageView!
    @IBOutlet weak var wrong: UIImageView!
    @IBOutlet weak var pr: UIButton!
    @IBOutlet weak var pret: UIButton!
    @IBOutlet weak var pm: UIButton!
    @IBOutlet weak var movel: NSLayoutConstraint!
    @IBOutlet weak var gameover: UILabel!
    @IBOutlet weak var gameoverc: NSLayoutConstraint!
    @IBOutlet weak var baseanim: UIImageView!
    @IBOutlet weak var baseanimh: NSLayoutConstraint!
    @IBOutlet weak var baseanimw: NSLayoutConstraint!
    @IBOutlet weak var kill1: UIImageView!
    @IBOutlet weak var kill2: UIImageView!
    @IBOutlet weak var kill1c: NSLayoutConstraint!
    @IBOutlet weak var kill2c: NSLayoutConstraint!
    @IBOutlet weak var kill3: UIImageView!
    @IBOutlet weak var kill3c: NSLayoutConstraint!
    @IBOutlet weak var movew: NSLayoutConstraint!
    @IBOutlet weak var moveh: NSLayoutConstraint!
    @IBOutlet weak var baseh: NSLayoutConstraint!
    @IBOutlet weak var basew: NSLayoutConstraint!
    @IBOutlet weak var viewclickb: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var dirw: NSLayoutConstraint!
    @IBOutlet weak var dirh: NSLayoutConstraint!
    @IBAction func viewclickcancel(_ sender: AnyObject) {
        self.dir.isHidden = true
        self.viewclickb.gestureRecognizers?.removeAll()
    }
    @IBAction func viewclickout(_ sender: AnyObject) {
        self.dir.isHidden = true
        self.viewclickb.gestureRecognizers?.removeAll()
    }
    @IBAction func viewclickin(_ sender: AnyObject) {
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swiperight))
        swiperight.direction = UISwipeGestureRecognizerDirection.right
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swipeleft))
        swipeleft.direction = UISwipeGestureRecognizerDirection.left
        let swipeup = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swipeup))
        swipeup.direction = UISwipeGestureRecognizerDirection.up
        let swipedown = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swipedown))
        swipedown.direction = UISwipeGestureRecognizerDirection.down
        self.dir.isHidden = true
        self.viewclickb.gestureRecognizers?.removeAll()
        print("finished click in")
        if(score >= extrascorerandom){
            extrascorerandom = Int(arc4random_uniform(9) + 2) + score
            switch (Int(arc4random_uniform(4))) {
            case 0:
                print("right")
                self.viewclickb.addGestureRecognizer(swiperight)
                self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
                break
            case 1:
                print("left")
                self.viewclickb.addGestureRecognizer(swipeleft)
                self.dir.transform = CGAffineTransform(rotationAngle: (0))
                break
            case 2:
                print("up")
                self.viewclickb.addGestureRecognizer(swipeup)
                self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
                break
            case 3:
                print("down")
                self.viewclickb.addGestureRecognizer(swipedown)
                 self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi * 1.5))
                break
            default:
                self.viewclickb.addGestureRecognizer(swiperight)
             self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
                break
            }
            self.dir.isHidden = false
            print(extrascorerandom)
            print("random work")
        }
    }
    @IBAction func viewclick(_ sender: Any, forEvent event: UIEvent) {
        if(doublescore.isHidden){
            print("not visible")
        }else{
            print("visible")
        }
        let myButton:UIButton = sender as! UIButton
        let touches: Set<UITouch>? = event.touches(for: myButton)
        let touch: UITouch? = touches?.first
        let touchPoint: CGPoint? = touch?.location(in: myButton)
        print("ouch" + String(describing: touchPoint))
        if  doublescore.layer.presentation()?.hitTest(touchPoint!) != nil {
            doubleon = true
            doublescore.layer.removeAllAnimations()
            self.doubletimerlast =  Timerp(interval: 10, callback: doubletimerlasting, repeats: false)
            doubletimerlast.play()
        }else{
        let projectileFrame: CGRect = move.layer.presentation()!.frame
        if (projectileFrame.intersects(base.frame))
        {
            if(doubleon == true){
            score = score + 2
            }else{
            score = score + 1
            }
            scoreval.text = "Score : " + String(score)
            coinv = coinv + (1 * coinmulti)
            coinvalue.text = String(coinv)
            self.audioPlayer.pause()
            self.audioPlayer.currentTime = 0
            self.audioPlayer.play()
            baseanim.layer.removeAllAnimations()
            baseanim.isHidden = false
            self.baseanim.transform = CGAffineTransform(scaleX: 1, y: 1)
            UIView.animate(withDuration: 0.5, delay: 0, options:[.beginFromCurrentState], animations: {
                self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
            }, completion:
                {(finished: Bool) -> Void in
                    if (finished == true){
                        self.baseanim.isHidden = true
                    }
            }
            )
        }else{
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
            switch (wrongnum){
            case 0:
                wrong.alpha = 1.0
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                kill1c.constant = move.layer.presentation()!.frame.origin.x
                kill1.setNeedsLayout()
                kill1.layoutIfNeeded()
                wrongnum = 1
                kill1.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                    self.kill1.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                    self.kill1.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {(finished: Bool) -> Void in
                    self.kill1.isHidden = true
                })
                break;
            case 1:
                wrong2.alpha = 1.0
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                wrongnum = 2
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                kill2c.constant = move.layer.presentation()!.frame.origin.x
                kill2.setNeedsLayout()
                kill2.layoutIfNeeded()
                kill2.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                    self.kill2.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                    self.kill2.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {(finished: Bool) -> Void in
                    self.kill2.isHidden = true
                })
                break;
            case 2:
                 let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
                 if(provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    viewclickb.isHidden = true
                    viewclickb.isUserInteractionEnabled = false
                    gameovercheck = 1
                    if (provider.exists(forKey: "hscore") == false){
                        if(score > 0){
                            provider.setInt(forKey: "hscore", value: score)
                            newhighscore = true
                        }
                    }else{
                        if(score > provider.getInt(forKey: "hscore", defaultValue: 0)){
                            provider.setInt(forKey: "hscore", value: score)
                            newhighscore = true
                        }
                    }
                    wrong3.alpha = 1.0
                    gameover.isHidden = false
                    move.layer.removeAllAnimations()
                    baseanim.layer.removeAllAnimations()
                    baseanim.isHidden = true
                    kill1.layer.removeAllAnimations()
                    kill2.layer.removeAllAnimations()
                    kill1.isHidden = true
                    kill2.isHidden = true
                    move.isHidden = true
                    base.isHidden = true
                    scoreval.isHidden = true
                    wrong.isHidden = true
                    wrong2.isHidden = true
                    wrong3.isHidden = true
                    coin.isHidden = true
                    coinvalue.isHidden = true
                    pr.isHidden = true
                    pret.isHidden = true
                    pm.isHidden = true
                    pause.isHidden = true
                    gameoverc.constant = (self.view.bounds.width/2) - (self.gameover.bounds.width/2)
                    gameover.setNeedsLayout()
                    UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                        self.gameover.alpha = 1
                     self.gameover.superview?.layoutIfNeeded()
                    }, completion: {(finished: Bool) -> Void in
                        let countdown = Foundation.Timer(timeInterval: 0.5, target: self, selector: #selector(PlayViewController.gameoverslideright), userInfo: nil, repeats: false)
                        RunLoop.current.add(countdown, forMode: RunLoopMode.commonModes)
                    })
                }else{
                    wrong3.alpha = 1.0
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    wrongnum = 3
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    kill3c.constant = move.layer.presentation()!.frame.origin.x
                    kill3.setNeedsLayout()
                    kill3.layoutIfNeeded()
                    kill3.isHidden = false
                    UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                        self.kill3.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                        self.kill3.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    }, completion: {(finished: Bool) -> Void in
                        self.kill3.isHidden = true
                    })
                }
                break;
            case 3:
                let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                viewclickb.isHidden = true
                viewclickb.isUserInteractionEnabled = false
                gameovercheck = 1
                if (provider.exists(forKey: "hscore") == false){
                    if(score > 0){
                        provider.setInt(forKey: "hscore", value: score)
                        newhighscore = true
                    }
                }else{
                    if(score > provider.getInt(forKey: "hscore", defaultValue: 0)){
                        provider.setInt(forKey: "hscore", value: score)
                        newhighscore = true
                    }
                }
                wrong4.alpha = 1.0
                gameover.isHidden = false
                move.layer.removeAllAnimations()
                baseanim.layer.removeAllAnimations()
                baseanim.isHidden = true
                kill1.layer.removeAllAnimations()
                kill2.layer.removeAllAnimations()
                kill1.isHidden = true
                kill2.isHidden = true
                kill3.layer.removeAllAnimations()
                kill3.isHidden = true
                move.isHidden = true
                base.isHidden = true
                scoreval.isHidden = true
                wrong.isHidden = true
                wrong2.isHidden = true
                wrong3.isHidden = true
                wrong4.isHidden = true
                coin.isHidden = true
                coinvalue.isHidden = true
                pr.isHidden = true
                pret.isHidden = true
                pm.isHidden = true
                pause.isHidden = true
                gameoverc.constant = (self.view.bounds.width/2) - (self.gameover.bounds.width/2)
                gameover.setNeedsLayout()
                UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                    self.gameover.alpha = 1
                    self.gameover.superview?.layoutIfNeeded()
                }, completion: {(finished: Bool) -> Void in
                    let countdown = Foundation.Timer(timeInterval: 0.5, target: self, selector: #selector(PlayViewController.gameoverslideright), userInfo: nil, repeats: false)
                    RunLoop.current.add(countdown, forMode: RunLoopMode.commonModes)
                })
                break;
            default:
                wrong.alpha = 1.0
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                kill1c.constant = move.layer.presentation()!.frame.origin.x
                kill1.setNeedsLayout()
                kill1.layoutIfNeeded()
                wrongnum = 1
                kill1.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                    self.kill1.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                    self.kill1.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {(finished: Bool) -> Void in
                    self.kill1.isHidden = true
                })
                break;
            }
            }
            
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         print("view did aprrear")
        newhighscore = false
        doubleon = false
        print(String(describing: self.view.bounds.width / UIScreen.main.scale))
        rafterf()
        x2top.constant = ((base.center.y - coin.center.y) / 2) + coin.center.y - (x2h.constant / 2)
        x2l.constant = -1 * x2w.constant
        gameoverc.constant = (self.view.bounds.width - self.gameover.bounds.width)
        gameover.setNeedsLayout()
        gameover.layoutIfNeeded()
        doublescore.titleLabel!.adjustsFontSizeToFitWidth = true
        doublescore.titleLabel!.numberOfLines = 1
        doublescore.titleLabel!.minimumScaleFactor = 0.05
        doublescore.titleLabel?.baselineAdjustment = .alignCenters
        doublescore.titleLabel?.textAlignment  = .center
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will aprrear")
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
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
            base.backgroundColor = UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)
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
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            pr.layer.borderColor = UIColor.black.cgColor
            pr.setTitleColor(UIColor.black, for: UIControlState())
            pret.layer.borderColor = UIColor.black.cgColor
            pret.setTitleColor(UIColor.black, for: UIControlState())
            pm.layer.borderColor = UIColor.black.cgColor
            pm.setTitleColor(UIColor.black, for: UIControlState())
            pause.tintColor = UIColor.black
            coinvalue.textColor = UIColor.black
            scoreval.textColor = UIColor.black
            gameover.textColor = UIColor.black
            baseanim.backgroundColor = UIColor.black
            base.layer.borderColor = UIColor.black.cgColor
            move.layer.borderColor = UIColor.black.cgColor
            baseanim.layer.borderColor = UIColor.black.cgColor
            doublescore.layer.borderColor = UIColor.black.cgColor
            doublescore.backgroundColor = UIColor.black
            doublescore.setTitleColor(UIColor.white, for: UIControlState())
            layerfixbase.borderColor = UIColor.black.cgColor
            dir.tintColor = UIColor.black
            }else{
            self.view.backgroundColor = UIColor.black
            pr.layer.borderColor = UIColor.white.cgColor
            pr.setTitleColor(UIColor.white, for: UIControlState())
            pret.layer.borderColor = UIColor.white.cgColor
            pret.setTitleColor(UIColor.white, for: UIControlState())
            pm.layer.borderColor = UIColor.white.cgColor
            pm.setTitleColor(UIColor.white, for: UIControlState())
            pause.tintColor = UIColor.white
            coinvalue.textColor = UIColor.white
            scoreval.textColor = UIColor.white
            gameover.textColor = UIColor.white
            baseanim.backgroundColor = UIColor.white
            base.layer.borderColor = UIColor.white.cgColor
            move.layer.borderColor = UIColor.white.cgColor
            baseanim.layer.borderColor = UIColor.white.cgColor
            doublescore.layer.borderColor = UIColor.white.cgColor
            doublescore.backgroundColor = UIColor.white
            doublescore.setTitleColor(UIColor.black, for: UIControlState())
            layerfixbase.borderColor = UIColor.white.cgColor
            dir.tintColor = UIColor.white
        }
        movel.constant = 0
        move.setNeedsLayout()
        move.layoutIfNeeded()
        score = 0
        scoreval.text = "Score : 0"
        wrongnum = 0
        wrong.alpha = 0.27
        wrong2.alpha = 0.27
        wrong3.alpha = 0.27
        wrong4.alpha = 0.27
        kill1.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill2.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill3.transform = CGAffineTransform(scaleX: 1, y: 1)
        timerand()
        //pauseb.setTitle("⎮⎮", for: UIControlState())
        pause.setImage(UIImage.init(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        dir.image = dir.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pausetf = false
        move.isHidden = false
        base.isHidden = false
        scoreval.isHidden = false
        wrong.isHidden = false
        wrong2.isHidden = false
        wrong3.isHidden = false
        coin.isHidden = false
        coinvalue.isHidden = false
        pause.isHidden = false
        pr.isHidden = true
        pret.isHidden = true
        pm.isHidden = true
        gameovercheck = 0
        if (provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
            wrong4.isHidden = true
        }else{
            wrong4.isHidden = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(PlayViewController.applicationWillResignActiveNotification), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wrong.image = wrong.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        wrong2.image = wrong2.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        wrong3.image = wrong3.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        wrong4.image = wrong4.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        kill1.image = kill1.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        kill2.image = kill2.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        kill3.image = kill3.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pr.layer.cornerRadius = 10
        pr.layer.borderWidth = 5
        pret.layer.cornerRadius = 10
        pret.layer.borderWidth = 5
        pm.layer.cornerRadius = 10
        pm.layer.borderWidth = 5
        base.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        base.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        move.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        move.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        baseanim.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        baseanim.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        doublescore.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
       // doubletimer =  Foundation.Timer(timeInterval: randromdoubletime, target: self, selector: #selector(PlayViewController.doublepointsmove), userInfo: nil, repeats: false)
        doubletimer = Timerp(interval: randromdoubletime, callback: doublepointsmove, repeats: false)
        doubletimer.play()
        ///////////////////////pause.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6)
        timerand()
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if (provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
            wrong4.isHidden = true
        }else{
            wrong4.isHidden = false
        }
        baseanimh.constant = ((63 * self.view.bounds.width) / 411)
        baseanimw.constant = ((63 * self.view.bounds.width) / 411)
        movew.constant = ((35 * self.view.bounds.width) / 411)
        moveh.constant = ((35 * self.view.bounds.width) / 411)
        basew.constant = ((50 * self.view.bounds.width) / 411)
        baseh.constant = ((50 * self.view.bounds.width) / 411)
        x2h.constant = ((35 * self.view.bounds.width) / 411)
        x2w.constant = ((35 * self.view.bounds.width) / 411)
        dirw.constant = ((40 * self.view.bounds.width) / 411)
        dirh.constant = ((40 * self.view.bounds.width) / 411)
        layerfixbase.frame = CGRect(x: -1, y: -1, width: basew.constant + 2, height: baseh.constant + 2)
        layerfixbase.cornerRadius = ((5 * self.view.bounds.width) / 411)
        layerfixbase.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        layerfixbase.masksToBounds = true
        layerfixbase.allowsEdgeAntialiasing = true
        base.layer.addSublayer(layerfixbase)
        base.layer.allowsEdgeAntialiasing = true
        move.layer.allowsEdgeAntialiasing = true
        baseanim.layer.allowsEdgeAntialiasing = true
        self.move.setNeedsLayout()
        self.base.setNeedsLayout()
        self.move.layoutIfNeeded()
        self.base.layoutIfNeeded()
        self.doublescore.setNeedsLayout()
        self.doublescore.layoutIfNeeded()
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "correct", ofType: "mp3")!))
            self.audioPlayer.prepareToPlay()
        } catch {
        }
    }
 /*   func r() {
        gright = true
        movel.constant = self.view.bounds.width - self.move.bounds.width
        move.setNeedsLayout()
        UIView.animate(withDuration: time, delay: 0, options:[], animations: {
            self.move.superview?.layoutIfNeeded()
            }, completion: {(finished: Bool) -> Void in
                if (finished == true){
                    self.timerand()
                    self.l()
                }
        })
    }
    func l() {
        gright = false
        movel.constant = 0
        move.setNeedsLayout()
        UIView.animate(withDuration: time, delay: 0, options:[], animations: {
            self.move.superview?.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
            if (finished == true){
                self.timerand()
                self.r()
            }
        })
    }*/
    func rafterf() {
        gright = true
        let rtimeafterp:Double = ((time * Double(self.view.bounds.width - self.move.bounds.width - movel.constant))/Double(self.view.bounds.width - self.move.bounds.width))
        movel.constant = self.view.bounds.width - self.move.bounds.width
        move.setNeedsLayout()
        UIView.animate(withDuration: rtimeafterp, delay: 0, options:[], animations: {
            self.move.superview?.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
            if (finished == true){
                self.timerand()
                self.lafterf()
            }
        })
    }
    func lafterf() {
        gright = false
        let ltimeafterp:Double = ((time * Double(movel.constant))/Double(self.view.bounds.width - self.move.bounds.width))
        movel.constant = 0
        move.setNeedsLayout()
        UIView.animate(withDuration: ltimeafterp, delay: 0, options:[], animations: {
            self.move.superview?.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
            if (finished == true){
                self.timerand()
                self.rafterf()
            }
        })
    }
    @IBAction func pause(_ sender: AnyObject) {
        if(pausetf == false){
            stopAnimation()
            doubletimer.pause()
            doubletimerlast.pause()
            pause.setImage(UIImage.init(named: "play")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            pausetf = true
            self.dir.isHidden = true
            movel.constant = (move.layer.presentation()?.frame.origin.x)!
            move.layer.removeAllAnimations()
            move.superview?.setNeedsLayout()
            move.superview?.layoutIfNeeded()
            baseanim.layer.removeAllAnimations()
            baseanim.isHidden = true
            kill1.layer.removeAllAnimations()
            kill2.layer.removeAllAnimations()
            kill3.layer.removeAllAnimations()
            kill1.isHidden = true
            kill2.isHidden = true
            kill3.isHidden = true
            move.isHidden = true
            base.isHidden = true
            scoreval.isHidden = true
            wrong.isHidden = true
            wrong2.isHidden = true
            wrong3.isHidden = true
            wrong4.isHidden = true
            coin.isHidden = true
            coinvalue.isHidden = true
            pr.isHidden = false
            pret.isHidden = false
            pm.isHidden = false
            viewclickb.isUserInteractionEnabled = false
        }else{
            resumeAnimation()
            doubletimer.play()
            doubletimerlast.play()
            if(gright == true){
                rafterf()
                }else{
                lafterf()
                }
             pause.setImage(UIImage.init(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            pausetf = false
            if(viewclickb.gestureRecognizers?.isEmpty == false){
                dir.isHidden = false
            }
            move.isHidden = false
            base.isHidden = false
            scoreval.isHidden = false
            wrong.isHidden = false
            wrong2.isHidden = false
            wrong3.isHidden = false
            coin.isHidden = false
            coinvalue.isHidden = false
            pr.isHidden = true
            pret.isHidden = true
            pm.isHidden = true
            let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
            if (provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
                wrong4.isHidden = true
            }else{
                wrong4.isHidden = false
            }
            viewclickb.isUserInteractionEnabled = true
            
        }
    }
    @IBAction func menu(_ sender: AnyObject) {
        NotificationCenter.default.removeObserver(self)
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func retry(_ sender: AnyObject) {
        movel.constant = 0
        move.setNeedsLayout()
        move.layoutIfNeeded()
        score = 0
        scoreval.text = "Score : 0"
        wrongnum = 0
        wrong.alpha = 0.27
        wrong2.alpha = 0.27
        wrong3.alpha = 0.27
        wrong4.alpha = 0.27
        kill1.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill2.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill3.transform = CGAffineTransform(scaleX: 1, y: 1)
        timerand()
        pause.setImage(UIImage.init(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        dir.image = dir.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pausetf = false
        move.isHidden = false
        base.isHidden = false
        scoreval.isHidden = false
        wrong.isHidden = false
        wrong2.isHidden = false
        wrong3.isHidden = false
        coin.isHidden = false
        coinvalue.isHidden = false
        pause.isHidden = false
        pr.isHidden = true
        pret.isHidden = true
        pm.isHidden = true
        gameovercheck = 0
      viewclickb.isUserInteractionEnabled = true
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if (provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
            wrong4.isHidden = true
        }else{
            wrong4.isHidden = false
        }
    }
    @IBAction func res(_ sender: AnyObject) {
        resumeAnimation()
        doubletimer.play()
        doubletimerlast.play()
        if(gright == true){
            rafterf()
        }else{
            lafterf()
        }
        pause.setImage(UIImage.init(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        pausetf = false
        if(viewclickb.gestureRecognizers?.isEmpty == false){
            dir.isHidden = false
        }
        move.isHidden = false
        base.isHidden = false
        scoreval.isHidden = false
        wrong.isHidden = false
        wrong2.isHidden = false
        wrong3.isHidden = false
        coin.isHidden = false
        coinvalue.isHidden = false
        pr.isHidden = true
        pret.isHidden = true
        pm.isHidden = true
          viewclickb.isUserInteractionEnabled = true
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if (provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
            wrong4.isHidden = true
        }else{
            wrong4.isHidden = false
        }
    }
  /*  func timeafterp() {
        if(rightleft == "r"){
        timep = Float(((self.view.bounds.width - self.move.bounds.width) - movel.constant) * CGFloat(time))/Float(self.view.bounds.width - self.move.bounds.width)
        }else{
        timep = Float((movel.constant) * CGFloat(time))/Float(self.view.bounds.width - self.move.bounds.width)
        }
    }*/
    func timerand() {
        switch (2){
            //arc4random_uniform(3)
        case 0:
            time = Double(0.288)
            print((self.view.bounds.width))
            print(UIScreen.main.scale)
            print(time)
            break;
        case 1:
            time = Double((0.576 * ((self.view.bounds.width - self.move.bounds.width)))/(376.2857))
            break;
        case 2:
            time = Double(0.864)
            break;
        default:
            time = Double((0.576 * ((self.view.bounds.width - self.move.bounds.width)))/(376.2857))
            break;
        }
    }
    @objc func applicationWillResignActiveNotification() {
        if(gameovercheck == 0){
            movel.constant = (move.layer.presentation()?.frame.origin.x)!
            move.layer.removeAllAnimations()
            move.superview?.setNeedsLayout()
            move.superview?.layoutIfNeeded()
            stopAnimation()
            doubletimer.pause()
            doubletimerlast.pause()
            pause.setImage(UIImage.init(named: "play")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            pausetf = true
            dir.isHidden = true
            baseanim.layer.removeAllAnimations()
            baseanim.isHidden = true
            kill1.layer.removeAllAnimations()
            kill2.layer.removeAllAnimations()
            kill3.layer.removeAllAnimations()
            kill1.isHidden = true
            kill2.isHidden = true
            kill3.isHidden = true
            move.isHidden = true
            base.isHidden = true
            scoreval.isHidden = true
            wrong.isHidden = true
            wrong2.isHidden = true
            wrong3.isHidden = true
            wrong4.isHidden = true
            coin.isHidden = true
            coinvalue.isHidden = true
            pr.isHidden = false
            pret.isHidden = false
            pm.isHidden = false
            viewclickb.isUserInteractionEnabled = false
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
           doubletimer.invalidate()
           doubletimerlast.invalidate()
         NotificationCenter.default.removeObserver(self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @objc func swiperight(){
        print("right")
        self.viewclickb.gestureRecognizers?.removeAll()
        self.dir.isHidden = true
        coinv = coinv + 4
        coinvalue.text = String(coinv)
        print("finished swipe in")
    }
    @objc func swipeleft(){
        print("left")
        self.viewclickb.gestureRecognizers?.removeAll()
        self.dir.isHidden = true
        coinv = coinv + 4
        coinvalue.text = String(coinv)
            print("finished swipe in")
    }
    @objc func swipeup(){
        print("up")
        self.viewclickb.gestureRecognizers?.removeAll()
        self.dir.isHidden = true
        coinv = coinv + 4
        coinvalue.text = String(coinv)
            print("finished swipe in")
    }
    @objc func swipedown(){
        print("down")
        self.viewclickb.gestureRecognizers?.removeAll()
        self.dir.isHidden = true
        coinv = coinv + 4
        coinvalue.text = String(coinv)
            print("finished swipe in")
    }
    func doublepointsmove(){
        doublescore.isHidden = false
        doublescore.isEnabled = true
        doublescore.isUserInteractionEnabled = true
        self.x2l.constant = self.view.bounds.width
        doublescore.setNeedsLayout()
        UIView.animate(withDuration: 10, delay: 0, options: [.allowUserInteraction], animations: {
            self.doublescore.superview?.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
            if(finished == true){
                print("fini")
            self.doublescore.isHidden = true
            self.doublescore.isEnabled = false
            self.doublescore.isUserInteractionEnabled = false
            self.x2l.constant = -1 * self.x2w.constant
                self.randromdoubletime = Double(arc4random_uniform(5) + 5)
                self.doubletimer.invalidate()
              //  self.doubletimer =  Foundation.Timer(timeInterval: self.randromdoubletime, target: self, selector: #selector(PlayViewController.doublepointsmove), userInfo: nil, repeats: false)
              //  RunLoop.current.add(self.doubletimer, forMode: RunLoopMode.commonModes)
                self.doubletimer =  Timerp(interval: self.randromdoubletime, callback: self.doublepointsmove, repeats: false)
                self.doubletimer.play()
                print(self.randromdoubletime)
                print(self.randromdoubletime)
            }
        })
    }
    @objc func doubletimerlasting(){
        doubleon = false
        doubletimerlast.invalidate()
        //self.doubletimer =  Foundation.Timer(timeInterval: Double(arc4random_uniform(5) + 5), target: self, selector: #selector(PlayViewController.doublepointsmove), userInfo: nil, repeats: false)
       // RunLoop.current.add(self.doubletimer, forMode: RunLoopMode.commonModes)
         self.randromdoubletime = Double(arc4random_uniform(5) + 5)
        self.doubletimer.invalidate()
        doubletimer =  Timerp(interval: randromdoubletime, callback: doublepointsmove, repeats: false)
        doubletimer.play()
    }
    @objc func gameoverslideright(){
        gameoverc.constant = 0
        gameover.setNeedsLayout()
        UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
            self.gameover.alpha = 0
            self.gameover.superview?.layoutIfNeeded()
            }, completion: {(finished: Bool) -> Void in
                NotificationCenter.default.removeObserver(self)
                let scorev = self.storyboard!.instantiateViewController(withIdentifier: "score") as! ScoreViewController
                scorev.scoreval = self.score
                scorev.newhighscoresc = self.newhighscore
                self.navigationController?.pushViewController(scorev, animated: true)
        })
    }
    func stopAnimation() {
        pausedtime = self.doublescore.layer.convertTime(CACurrentMediaTime(), from: nil)
        self.doublescore.layer.speed = 0.0
        self.doublescore.layer.timeOffset = pausedtime
    }
    func resumeAnimation() {
        self.doublescore.layer.speed = 1.0
        self.doublescore.layer.timeOffset = 0.0
        self.doublescore.layer.beginTime = 0.0
        let timeSincePause = self.doublescore.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedtime
        self.doublescore.layer.beginTime = timeSincePause
    }
    
}

