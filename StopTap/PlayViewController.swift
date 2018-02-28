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
import QuartzCore
class PlayViewController: UIViewController {
    @IBOutlet weak var move: UIImageView!
    @IBOutlet weak var base: UIImageView!
    var score:Int = 0
    var gright:Bool = true
    var pausetf:Bool = false
    var wrongnum:Int = 0
    var gameovercheck:Int = 0
    var extrascorerandom:Int = Int(arc4random_uniform(9) + 2)
    var correctsfx: AVAudioPlayer!
    var mbgm: AVAudioPlayer!
    var wrongsfx:AVAudioPlayer!
    var doubleonsfx: AVAudioPlayer!
    var doubleoffsfx: AVAudioPlayer!
    var inarowsfx: AVAudioPlayer!
    let coinmulti:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop14", defaultValue: 1)
    var coinv:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "cv", defaultValue: 0)
    var newhighscore:Bool = false
    var doubletimer:Timerp = Timerp()
    var doubletimerlast:Timerp = Timerp()
    var doubleon:Bool = false
    var doubleanim:Bool = false
    var randromdoubletime:Double = Double(arc4random_uniform(6) + 20)
    let layerfixbase:CALayer = CALayer()
    var animator: UIViewPropertyAnimator!
    var number:CGFloat = 0.0
    var doubleanimator: UIViewPropertyAnimator!
    var doublelnumber:CGFloat = 0.0
    var checkifusertoucheddouble:Int = 0
    var onetimecorrect:Int = 2
    var inarow:Int = 0
    @IBOutlet weak var xw2signwidth: NSLayoutConstraint!
    @IBOutlet weak var x2sign: UIButton!
    let lang:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "lang", defaultValue: 1)
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
    @IBOutlet weak var kill1w: NSLayoutConstraint!
    @IBOutlet weak var kill1h: NSLayoutConstraint!
    @IBOutlet weak var kill2h: NSLayoutConstraint!
    @IBOutlet weak var kill2w: NSLayoutConstraint!
    @IBOutlet weak var kill3h: NSLayoutConstraint!
    @IBOutlet weak var kill3w: NSLayoutConstraint!
    @IBAction func viewclickcancel(_ sender: AnyObject) {
        if(checkifusertoucheddouble == 0){
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
        }else{
            checkifusertoucheddouble = checkifusertoucheddouble - 1
        }
    }
    @IBAction func viewclickout(_ sender: AnyObject) {
        if(checkifusertoucheddouble == 0){
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
        }else{
            checkifusertoucheddouble = checkifusertoucheddouble - 1
        }
        
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
        if(checkifusertoucheddouble == 0){
            if(onetimecorrect == 1){
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
            if(score >= extrascorerandom){
                extrascorerandom = Int(arc4random_uniform(9) + 2) + score
                switch (Int(arc4random_uniform(4))) {
                case 0:
                    //print("right")
                    self.viewclickb.addGestureRecognizer(swiperight)
                    self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
                    break
                case 1:
                    //print("left")
                    self.viewclickb.addGestureRecognizer(swipeleft)
                    self.dir.transform = CGAffineTransform(rotationAngle: (0))
                    break
                case 2:
                    //print("up")
                    self.viewclickb.addGestureRecognizer(swipeup)
                    self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
                    break
                case 3:
                    //print("down")
                    self.viewclickb.addGestureRecognizer(swipedown)
                    self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi * 1.5))
                    break
                default:
                    self.viewclickb.addGestureRecognizer(swiperight)
                    self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
                    break
                }
                self.dir.isHidden = false
                //print(extrascorerandom)
                //print("random work")
            }
            }
            
        }else{
            checkifusertoucheddouble = checkifusertoucheddouble - 1
        }
    }
    @IBAction func viewclick(_ sender: Any, forEvent event: UIEvent) {
        let myButton:UIButton = sender as! UIButton
        let touches: Set<UITouch>? = event.touches(for: myButton)
        let touch: UITouch? = touches?.first
        let touchPoint: CGPoint? = touch?.location(in: myButton)
        //print("ouch" + String(describing: touchPoint))
        if  doublescore.layer.presentation()?.hitTest(touchPoint!) != nil {
            self.doubleonsfx.currentTime = 0
            self.doubleonsfx.play()
            checkifusertoucheddouble = 2
            doubleanim = false
            doubleon = true
            doubleanimator.stopAnimation(true)
            doublescore.isHidden = true
            self.doubletimerlast =  Timerp(interval: 10, callback: doubletimerlasting, repeats: false)
            doubletimerlast.play()
            x2sign.setNeedsLayout()
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
                self.x2sign.alpha = 1.0
                self.x2sign.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
            //print("doubleclickedon")
        }else{
        checkifusertoucheddouble = 0
        let projectileFrame: CGRect = move.layer.presentation()!.frame
        if (projectileFrame.intersects(base.frame))
        {
            if(onetimecorrect == 2){
                onetimecorrect = onetimecorrect - 1
            if(doubleon == true){
            score = score + 2
            }else{
            score = score + 1
            }
            coinv = coinv + (1 * coinmulti)
                switch (lang) {
                case 0:
                    coinvalue.text = convertEngNumToPersianNum(num: String(coinv))
                    scoreval.text = "النتيجة : " + convertEngNumToPersianNum(num: String(score))
                    break;
                case 1:
                    coinvalue.text = String(coinv)
                    scoreval.text = "Score : " + String(score)
                    break;
                default:
                    coinvalue.text = String(coinv)
                    scoreval.text = "Score : " + String(score)
                    break;
                }
            inarow = inarow + 1
            if(inarow >= 10 && wrongnum > 0){
                self.inarowsfx.currentTime = 0
                self.inarowsfx.play()
                inarow = 0
                switch(wrongnum){
                case 1:
                    wrongnum = 0
                    wrong.alpha = 0.27
                    break;
                case 2 :
                    wrongnum = 1
                    wrong2.alpha = 0.27
                    break;
                case 3 :
                    wrongnum = 2
                    wrong3.alpha = 0.27
                    break;
                default:
                    wrongnum = 0
                    wrong.alpha = 0.27
                    break;
                }
                baseanim.layer.removeAllAnimations()
                baseanim.isHidden = false
               /* UIView.animate(withDuration: 0.5, delay: 0, options:[.beginFromCurrentState], animations: {
                    self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
                }, completion:
                    {(finished: Bool) -> Void in
                        if (finished == true){
                            self.baseanim.isHidden = true
                        }
                }
                ) */
                self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options:.beginFromCurrentState, animations: {
                    self.baseanim.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion:    {(finished: Bool) -> Void in
                    if (finished == true){
                        //self.baseanim.isHidden = true
                        UIView.animate(withDuration: 0.25, delay: 0, options:[.beginFromCurrentState], animations: {
                            self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
                        }, completion:
                            {(finished: Bool) -> Void in
                                if (finished == true){
                                    self.baseanim.isHidden = true
                                }
                        }
                        )
                    }
                })
            }else{
                self.correctsfx.currentTime = 0
                self.correctsfx.play()
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
                
                }
            }else{
                onetimecorrect = onetimecorrect - 1
            }
        }else{
            inarow = 0
            let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
            switch (wrongnum){
            case 0:
                self.wrongsfx.currentTime = 0
                self.wrongsfx.play()
                wrong.alpha = 1.0
                if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                kill1c.constant = (move.layer.presentation()!.frame.origin.x + (movew.constant / 2) - (kill1.frame.width / 2))
                kill1.setNeedsLayout()
                kill1.layoutIfNeeded()
                wrongnum = 1
                kill1.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                    self.kill1.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                    self.kill1.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {(finished: Bool) -> Void in
                    self.kill1.isHidden = true
                    self.kill1.transform = CGAffineTransform(rotationAngle: 0)
                    self.kill1.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                break;
            case 1:
                self.wrongsfx.currentTime = 0
                self.wrongsfx.play()
                wrong2.alpha = 1.0
                if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                wrongnum = 2
                kill2c.constant = (move.layer.presentation()!.frame.origin.x + (movew.constant / 2) - (kill2.frame.width / 2))
                kill2.setNeedsLayout()
                kill2.layoutIfNeeded()
                kill2.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                    self.kill2.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                    self.kill2.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {(finished: Bool) -> Void in
                    self.kill2.isHidden = true
                    self.kill2.transform = CGAffineTransform(rotationAngle: 0)
                    self.kill2.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                })
                break;
            case 2:
                
                 if(provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
                    self.wrongsfx.currentTime = 0
                    self.wrongsfx.play()
                    if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    }
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
                    x2sign.isHidden = true
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
                    gameoverc.constant = (self.view.safeAreaLayoutGuide.layoutFrame.width/2) - (self.gameover.bounds.width/2)
                    gameover.setNeedsLayout()
                    doublescore.isEnabled = false
                    doublescore.isHidden = true
                    animator.stopAnimation(true)
                    doubletimer.invalidate()
                    doubletimerlast.invalidate()
                    if(doubleanim == true){
                    doubleanimator.stopAnimation(true)
                    }
                    self.x2l.constant = -1 * self.x2w.constant
                    UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                        self.gameover.alpha = 1
                     self.gameover.superview?.layoutIfNeeded()
                    }, completion: {(finished: Bool) -> Void in
                        let countdown = Foundation.Timer(timeInterval: 0.5, target: self, selector: #selector(PlayViewController.gameoverslideright), userInfo: nil, repeats: false)
                        RunLoop.current.add(countdown, forMode: RunLoopMode.commonModes)
                    })
                }else{
                    self.wrongsfx.currentTime = 0
                    self.wrongsfx.play()
                    wrong3.alpha = 1.0
                    if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    }
                    wrongnum = 3
                    kill3c.constant = (move.layer.presentation()!.frame.origin.x + (movew.constant / 2) - (kill3.frame.width / 2))
                    kill3.setNeedsLayout()
                    kill3.layoutIfNeeded()
                    kill3.isHidden = false
                    UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                        self.kill3.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                        self.kill3.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    }, completion: {(finished: Bool) -> Void in
                        self.kill3.isHidden = true
                        self.kill3.transform = CGAffineTransform(rotationAngle: 0)
                        self.kill3.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                }
                break;
            case 3:
                self.wrongsfx.currentTime = 0
                self.wrongsfx.play()
                if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
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
                x2sign.isHidden = true
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
                animator.stopAnimation(true)
                if(doubleanim == true){
                doubleanimator.stopAnimation(true)
                }
                self.x2l.constant = -1 * self.x2w.constant
                doublescore.isEnabled = false
                doublescore.isHidden = true
                doubletimer.invalidate()
                doubletimerlast.invalidate()
                gameoverc.constant = (self.view.safeAreaLayoutGuide.layoutFrame.width/2) - (self.gameover.bounds.width/2)
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
                self.wrongsfx.currentTime = 0
                self.wrongsfx.play()
                wrong.alpha = 1.0
                if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                kill1c.constant = (move.layer.presentation()!.frame.origin.x + (movew.constant / 2) - (kill1.frame.width / 2))
                kill1.setNeedsLayout()
                kill1.layoutIfNeeded()
                wrongnum = 1
                kill1.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                    self.kill1.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
                    self.kill1.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: {(finished: Bool) -> Void in
                    self.kill1.isHidden = true
                    self.kill1.transform = CGAffineTransform(rotationAngle: 0)
                    self.kill1.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                break;
            }
            }
            
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         //print("view did aprrear")
        newhighscore = false
        doubleon = false
        //print(String(describing: self.view.bounds.width / UIScreen.main.scale))
        if(pausetf == false){
        rafterf()
        }
        x2top.constant =  ((self.view.bounds.height * (3/4)) - (x2h.constant / 2))
        x2l.constant = -1 * x2w.constant
        gameoverc.constant = (self.view.safeAreaLayoutGuide.layoutFrame.width - self.gameover.bounds.width)
        gameover.setNeedsLayout()
        gameover.layoutIfNeeded()
        doublescore.titleLabel!.widthAnchor.constraint(equalToConstant: (x2w.constant * (3/4))).isActive = true
        doublescore.titleLabel!.adjustsFontSizeToFitWidth = true
        doublescore.titleLabel!.numberOfLines = 1
        doublescore.titleLabel!.minimumScaleFactor = 0.05
        doublescore.titleLabel?.baselineAdjustment = .alignCenters
        doublescore.titleLabel?.textAlignment  = .center
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            self.correctsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "correct", ofType: "wav")!))
            self.correctsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.correctsfx.prepareToPlay()
            self.doubleonsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "doublepointson", ofType: "wav")!))
            self.doubleonsfx.prepareToPlay()
            self.doubleonsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.doubleoffsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "doublepointsoff", ofType: "wav")!))
            self.doubleoffsfx.prepareToPlay()
            self.doubleoffsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.inarowsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "inarow", ofType: "wav")!))
            self.inarowsfx.prepareToPlay()
            self.inarowsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.wrongsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "wrong", ofType: "wav")!))
            self.wrongsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.wrongsfx.prepareToPlay()
            self.mbgm =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!))
            self.mbgm.prepareToPlay()
            self.mbgm.numberOfLoops = -1
            self.mbgm.volume = 0.0
            self.mbgm.play()
        } catch {
        }
        self.mbgm.setVolume((Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "musicval", defaultValue: 10)) / 10.0), fadeDuration: 0.5)
        //print("view will aprrear")
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
        doublescore.backgroundColor = blend(colors: [move.backgroundColor!,base.backgroundColor!])
        x2sign.backgroundColor = blend(colors: [move.backgroundColor!,base.backgroundColor!])
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
            doublescore.layer.shadowColor = UIColor.black.cgColor
            doublescore.setTitleColor(UIColor.black, for: UIControlState())
            x2sign.layer.shadowColor = UIColor.black.cgColor
            x2sign.setTitleColor(UIColor.black, for: UIControlState())
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
            doublescore.layer.shadowColor = UIColor.white.cgColor
            doublescore.setTitleColor(UIColor.white, for: UIControlState())
            x2sign.layer.shadowColor = UIColor.white.cgColor
            x2sign.setTitleColor(UIColor.white, for: UIControlState())
            layerfixbase.borderColor = UIColor.white.cgColor
            dir.tintColor = UIColor.white
        }
        movel.constant = 0
        move.setNeedsLayout()
        self.move.superview?.layoutIfNeeded()
        score = 0
        gright = true
        x2sign.layer.removeAllAnimations()
        x2sign.isHidden = false
        x2sign.alpha = 0.27
        x2sign.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        switch (lang) {
        case 0:
            scoreval.text = "النتيجة : ٠"
            break;
        case 1:
            scoreval.text = "Score : 0"
            break;
        default:
            scoreval.text = "Score : 0"
            break;
        }
        scoreval.setNeedsLayout()
        scoreval.layoutIfNeeded()
        wrongnum = 0
        wrong.alpha = 0.27
        wrong2.alpha = 0.27
        wrong3.alpha = 0.27
        wrong4.alpha = 0.27
        extrascorerandom = Int(arc4random_uniform(9) + 2)
        kill1.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill2.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill3.transform = CGAffineTransform(scaleX: 1, y: 1)
        doubleon = false
        doubleanim = false
        number = 0.0
        inarow = 0
        doublelnumber = 0.0
        checkifusertoucheddouble = 0
        onetimecorrect = 2
        doubletimer.invalidate()
        doubletimer = Timerp(interval: randromdoubletime, callback: doublepointsmove, repeats: false)
        doubletimer.play()
        doubletimerlast.invalidate()
        x2l.constant = -1 * x2w.constant
        //timerand()
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
        viewclickb.isHidden = false
        newhighscore = false
        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
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
        pause.isExclusiveTouch = true
        pr.isExclusiveTouch = true
        pm.isExclusiveTouch = true
        pret.isExclusiveTouch = true
        base.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        base.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        move.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        move.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        baseanim.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        baseanim.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        if(UIDevice.current.userInterfaceIdiom == .phone){
            xw2signwidth.constant = 25.0
        }else{
            xw2signwidth.constant = 40.0
        }
       // print("x2sign width")
        //print(xw2signwidth.constant)
        x2sign.layer.cornerRadius = (xw2signwidth.constant / 2) //((50 * self.view.bounds.width) / 411)
        x2sign.layer.allowsEdgeAntialiasing = true
        x2sign.titleLabel!.widthAnchor.constraint(equalToConstant: (xw2signwidth.constant * (3/4))).isActive = true
        x2sign.titleLabel!.adjustsFontSizeToFitWidth = true
        x2sign.titleLabel!.numberOfLines = 1
        x2sign.titleLabel!.minimumScaleFactor = 0.05
        x2sign.titleLabel?.baselineAdjustment = .alignCenters
        x2sign.titleLabel?.textAlignment  = .center
        x2sign.layer.shadowOffset = CGSize(width: 0, height: 0)
       // doubletimer =  Foundation.Timer(timeInterval: randromdoubletime, target: self, selector: #selector(PlayViewController.doublepointsmove), userInfo: nil, repeats: false)
        doubletimer = Timerp(interval: randromdoubletime, callback: doublepointsmove, repeats: false)
        doubletimer.play()
        ///////////////////////pause.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6)
        //timerand()
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch (lang) {
        case 0:
            coinvalue.text = convertEngNumToPersianNum(num: String(coinv))
            coinvalue.arabic(size: 22, diffinsize: 4)
            scoreval.text = "النتيجة : ٠"
            scoreval.arabic(size: 24, diffinsize: 14)
            gameover.text = "انتهت اللعبة"
            gameover.arabic(size: 22, diffinsize: 10)
            pr.setTitle("استمر", for: UIControlState())
            pr.arabic(size: 20, diffinsize: 10)
            pret.setTitle("إعادة البدء", for: UIControlState())
            pret.arabic(size: 20, diffinsize: 10)
            pm.setTitle("القائمة", for: UIControlState())
            pm.arabic(size: 20, diffinsize: 10)
            doublescore.setTitle("٢x", for: UIControlState())
            doublescore.arabic(size: 100, diffinsize: 0)
            x2sign.setTitle("٢x", for: UIControlState())
            x2sign.arabic(size: 100, diffinsize: 0)
            break;
        case 1:
            coinvalue.text = String(coinv)
            coinvalue.english(size: 22, diffinsize: 4)
            scoreval.text = "Score : 0"
            scoreval.english(size: 24, diffinsize: 14)
            gameover.text = "Game Over"
            gameover.english(size: 22, diffinsize: 10)
            pr.setTitle("Resume", for: UIControlState())
            pr.english(size: 20, diffinsize: 10,left: 2, top: 2)
            pret.setTitle("Retry", for: UIControlState())
            pret.english(size: 20, diffinsize: 10,left: 2, top: 2)
            pm.setTitle("Menu", for: UIControlState())
            pm.english(size: 20, diffinsize: 10,left: 2, top: 2)
            doublescore.setTitle("x2", for: UIControlState())
            doublescore.english(size: 100, diffinsize: 0,left: 4,top: 2)
            x2sign.setTitle("x2", for: UIControlState())
            x2sign.english(size: 100, diffinsize: 0,left: 1,top: 1)
            break;
        default:
            coinvalue.text = String(coinv)
            coinvalue.english(size: 22, diffinsize: 4)
            scoreval.text = "Score : 0"
            scoreval.english(size: 24, diffinsize: 14)
            gameover.text = "Game Over"
            gameover.english(size: 22, diffinsize: 10)
            pr.setTitle("Resume", for: UIControlState())
            pr.english(size: 20, diffinsize: 10,left: 2, top: 2)
            pret.setTitle("Retry", for: UIControlState())
            pret.english(size: 20, diffinsize: 10,left: 2, top: 2)
            pm.setTitle("Menu", for: UIControlState())
            pm.english(size: 20, diffinsize: 10,left: 2, top: 2)
            doublescore.setTitle("x2", for: UIControlState())
            doublescore.english(size: 100, diffinsize: 0,left: 4,top: 2)
            x2sign.setTitle("x2", for: UIControlState())
            x2sign.english(size: 100, diffinsize: 0,left: 4,top: 2)
            break;
        }
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
        kill1h.constant = ((35 * self.view.bounds.width) / 411)
        kill1w.constant = ((35 * self.view.bounds.width) / 411)
        kill2h.constant = ((35 * self.view.bounds.width) / 411)
        kill2w.constant = ((35 * self.view.bounds.width) / 411)
        kill3h.constant = ((35 * self.view.bounds.width) / 411)
        kill3w.constant = ((35 * self.view.bounds.width) / 411)
        layerfixbase.frame = CGRect(x: -1, y: -1, width: basew.constant + 2, height: baseh.constant + 2)
        layerfixbase.cornerRadius = ((5 * self.view.bounds.width) / 411)
        layerfixbase.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        layerfixbase.masksToBounds = true
        layerfixbase.allowsEdgeAntialiasing = true
        base.layer.addSublayer(layerfixbase)
        base.layer.allowsEdgeAntialiasing = true
        move.layer.allowsEdgeAntialiasing = true
        //print(xw2signwidth.constant)
        baseanim.layer.allowsEdgeAntialiasing = true
        doublescore.layer.cornerRadius = (x2w.constant / 2) //((50 * self.view.bounds.width) / 411)
        doublescore.layer.allowsEdgeAntialiasing = true
        doublescore.layer.shadowRadius = 6.0
        doublescore.layer.shadowOffset = CGSize(width: 0, height: 0)
        doublescore.layer.shadowOpacity = 0.75
        self.move.setNeedsLayout()
        self.base.setNeedsLayout()
        self.move.layoutIfNeeded()
        self.base.layoutIfNeeded()
        self.doublescore.setNeedsLayout()
        self.doublescore.layoutIfNeeded()
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
        movel.constant = self.view.safeAreaLayoutGuide.layoutFrame.width - self.move.bounds.width
        move.setNeedsLayout()
        animator = UIViewPropertyAnimator(duration: timerand(), curve: .linear) { [unowned self, move] in
            self.move.superview?.layoutIfNeeded()
        }
        animator.addCompletion {
            position in
            switch position {
            case .end:
                do {
                    self.onetimecorrect = 2
                    self.animator = nil
                    self.number = 0.0
                    self.lafterf()
                    //print("fuck")
                    
                }
            case .current: //print("Completion handler called mid-way through animation")
                break;
            case .start: //print("Completion handler called  at start of animation")
                break;
            }
        }
        animator.fractionComplete = number
        //print("r hit wall animation state" + String(animator.state.rawValue))
        animator.startAnimation()
        
    }
    func lafterf() {
        gright = false
        movel.constant = 0
        move.setNeedsLayout()
        animator = UIViewPropertyAnimator(duration: timerand(), curve: .linear) { [unowned self, move] in
            self.move.superview?.layoutIfNeeded()
        }
        animator.addCompletion {
            position in
            switch position {
            case .end:
                do {
                    self.onetimecorrect = 2
                    self.animator = nil
                    self.number = 0.0
                    self.rafterf()
                    //print("fuck")
                }
            case .current: //print("Completion handler called mid-way through animation")
                break;
            case .start: //print("Completion handler called  at start of animation")
                break;
            }
        }
        animator.fractionComplete = number
        animator.startAnimation()
        
    }
    @IBAction func pause(_ sender: AnyObject) {
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        if(pausetf == false){
            mbgm.pause()
            if(correctsfx.isPlaying){
                correctsfx.pause()
            }
            if(doubleonsfx.isPlaying){
                doubleonsfx.pause()
            }
            if(doubleoffsfx.isPlaying){
                doubleoffsfx.pause()
            }
            if(inarowsfx.isPlaying){
                inarowsfx.pause()
            }
            if(wrongsfx.isPlaying){
                wrongsfx.pause()
            }
            KeyStoreDefaultsProvider(cryptoProvider: nil).setInt(forKey: "cv", value: self.coinv)
            pausetf = true
            pause.setImage(UIImage.init(named: "play")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            self.dir.isHidden = true
            x2sign.isHidden = true
            //stopAnimation()
            if(gright == true){
                number = animator.fractionComplete
                animator.stopAnimation(true)
                animator = nil
                movel.constant = 0
                move.setNeedsLayout()
                self.move.superview?.layoutIfNeeded()
            }else{
                number = animator.fractionComplete
                animator.stopAnimation(true)
                animator = nil
                movel.constant = self.view.bounds.width - self.move.bounds.width
                move.setNeedsLayout()
                self.move.superview?.layoutIfNeeded()
            }
            baseanim.layer.removeAllAnimations()
            baseanim.isHidden = true
            if(doubleon == true){
                doubletimerlast.pause()
            }else{
                if(doubleanim == false){
                    doubletimer.pause()
                }else{
                    doublescore.isHidden = true
                    doublelnumber = doubleanimator.fractionComplete
                    doubleanimator.stopAnimation(true)
                    doubleanimator = nil
                    x2l.constant = -1 * x2w.constant
                    doublescore.setNeedsLayout()
                    self.doublescore.superview?.layoutIfNeeded()
                }
            }
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
            mbgm.play()
            pausetf = false
            if(gright == true){
                rafterf()
                }else{
                lafterf()
                }
            if(doubleon == true){
                doubletimerlast.play()
            }else{
            if(doubleanim == true){
                doublescore.isHidden = false
                doublepointsmove()
            }else{
                doubletimer.play()
            }
            }
            x2sign.isHidden = false
             pause.setImage(UIImage.init(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
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
            if (provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
                wrong4.isHidden = true
            }else{
                wrong4.isHidden = false
            }
            viewclickb.isUserInteractionEnabled = true
            
        }
    }
    @IBAction func menu(_ sender: AnyObject) {
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        
        correctsfx.stop()
        correctsfx = nil
        wrongsfx.stop()
        wrongsfx = nil
        mbgm.stop()
        mbgm = nil
        doubleoffsfx.stop()
        doubleoffsfx = nil
        doubleonsfx.stop()
        doubleonsfx = nil
        inarowsfx.stop()
        inarowsfx = nil
        KeyStoreDefaultsProvider(cryptoProvider: nil).setInt(forKey: "cv", value: self.coinv)
        NotificationCenter.default.removeObserver(self)
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func retry(_ sender: AnyObject) {
        inarow = 0
        mbgm.pause()
        mbgm.currentTime = 0
        mbgm.play()
        if(correctsfx.isPlaying){
            correctsfx.pause()
        }
        if(wrongsfx.isPlaying){
            wrongsfx.pause()
        }
        if(doubleonsfx.isPlaying){
            doubleonsfx.pause()
        }
        if(doubleoffsfx.isPlaying){
            doubleoffsfx.pause()
        }
        if(inarowsfx.isPlaying){
            inarowsfx.pause()
        }
        movel.constant = 0
        move.setNeedsLayout()
        self.move.superview?.layoutIfNeeded()
        score = 0
        gright = true
        x2sign.layer.removeAllAnimations()
        x2sign.isHidden = false
        x2sign.alpha = 0.27
        x2sign.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        switch (lang) {
        case 0:
            scoreval.text = "النتيجة : ٠"
            break;
        case 1:
            scoreval.text = "Score : 0"
            break;
        default:
            scoreval.text = "Score : 0"
            break;
        }
        scoreval.setNeedsLayout()
        scoreval.layoutIfNeeded()
        wrongnum = 0
        wrong.alpha = 0.27
        wrong2.alpha = 0.27
        wrong3.alpha = 0.27
        wrong4.alpha = 0.27
        extrascorerandom = Int(arc4random_uniform(9) + 2)
        kill1.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill2.transform = CGAffineTransform(scaleX: 1, y: 1)
        kill3.transform = CGAffineTransform(scaleX: 1, y: 1)
        doubleon = false
        doubleanim = false
        number = 0.0
        doublelnumber = 0.0
        checkifusertoucheddouble = 0
        onetimecorrect = 2
        doubletimer.invalidate()
        doubletimer = Timerp(interval: randromdoubletime, callback: doublepointsmove, repeats: false)
        doubletimer.play()
        doubletimerlast.invalidate()
        x2l.constant = -1 * x2w.constant
        //timerand()
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
        viewclickb.isHidden = false
        newhighscore = false
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        if (provider.getInt(forKey: "shop16", defaultValue: 0) == 0){
            wrong4.isHidden = true
        }else{
            wrong4.isHidden = false
        }
        rafterf()
    }
    @IBAction func res(_ sender: AnyObject) {
        mbgm.play()
        x2sign.isHidden = false
        if(gright == true){
            rafterf()
        }else{
            lafterf()
        }
        if(doubleon == true){
            doubletimerlast.play()
        }else{
            if(doubleanim == true){
                doublescore.isHidden = false
                doublepointsmove()
            }else{
                doubletimer.play()
            }
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
        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
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
    func timerand() -> Double{
        switch (arc4random_uniform(3)){
            //arc4random_uniform(3)
        case 0:
            return Double(0.288)
            break;
        case 1:
            return Double(0.576)
            break;
        case 2:
            return Double(0.864)
            break;
        default:
            return Double(0.576)
            break;
        }
    }
    @objc func applicationWillResignActiveNotification() {
        if(gameovercheck == 0){
            mbgm.pause()
            if(correctsfx.isPlaying){
                correctsfx.pause()
            }
            if(wrongsfx.isPlaying){
                wrongsfx.pause()
            }
            if(doubleonsfx.isPlaying){
                doubleonsfx.pause()
            }
            if(doubleoffsfx.isPlaying){
                doubleoffsfx.pause()
            }
            if(inarowsfx.isPlaying){
                inarowsfx.pause()
            }
            KeyStoreDefaultsProvider(cryptoProvider: nil).setInt(forKey: "cv", value: self.coinv)
            x2sign.isHidden = true
            if(animator != nil){
            if(gright == true){
                number = animator.fractionComplete
                animator.stopAnimation(true)
                animator = nil
                movel.constant = 0
                move.setNeedsLayout()
                self.move.superview?.layoutIfNeeded()
            }else{
                number = animator.fractionComplete
                animator.stopAnimation(true)
                animator = nil
                movel.constant = self.view.bounds.width - self.move.bounds.width
                move.setNeedsLayout()
                self.move.superview?.layoutIfNeeded()
            }
            }
            pause.setImage(UIImage.init(named: "play")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            pausetf = true
            if(doubleon == true){
                doubletimerlast.pause()
            }else{
                if(doubleanim == false){
                    doubletimer.pause()
                }else{
                    doublescore.isHidden = true
                    doublelnumber = doubleanimator.fractionComplete
                    doubleanimator.stopAnimation(true)
                    doubleanimator = nil
                    x2l.constant = -1 * x2w.constant
                    doublescore.setNeedsLayout()
                    self.doublescore.superview?.layoutIfNeeded()
                }
            }
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
         NotificationCenter.default.removeObserver(self)
        if(correctsfx != nil){
            correctsfx.stop()
            correctsfx = nil
        }
        if(wrongsfx != nil){
            wrongsfx.stop()
            wrongsfx = nil
        }
        if(mbgm != nil){
            mbgm.stop()
            mbgm = nil
        }
        if(doubleonsfx != nil){
            doubleonsfx.stop()
            doubleonsfx = nil
        }
        if(doubleoffsfx != nil){
            doubleoffsfx.stop()
            doubleoffsfx = nil
        }
        if(inarowsfx != nil){
            inarowsfx.stop()
            inarowsfx = nil
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
    }
    @objc func swiperight(){
        //print("right")
        if(checkifusertoucheddouble == 0){
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
            coinv = coinv + 4
            switch (lang) {
            case 0:
                coinvalue.text = convertEngNumToPersianNum(num: String(coinv))
                break;
            case 1:
                coinvalue.text = String(coinv)
                break;
            default:
                coinvalue.text = String(coinv)
                break;
            }
           // print("finished swipe in")
        }else{
            checkifusertoucheddouble = checkifusertoucheddouble - 1
        }
    }
    @objc func swipeleft(){
        //print("left")
        if(checkifusertoucheddouble == 0){
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
            coinv = coinv + 4
            switch (lang) {
            case 0:
                coinvalue.text = convertEngNumToPersianNum(num: String(coinv))
                break;
            case 1:
                coinvalue.text = String(coinv)
                break;
            default:
                coinvalue.text = String(coinv)
                break;
            }
            //print("finished swipe in")
            
        }else{
            checkifusertoucheddouble = checkifusertoucheddouble - 1
        }
    }
    @objc func swipeup(){
        //print("up")
        if(checkifusertoucheddouble == 0){
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
            coinv = coinv + 4
            switch (lang) {
            case 0:
                coinvalue.text = convertEngNumToPersianNum(num: String(coinv))
                break;
            case 1:
                coinvalue.text = String(coinv)
                break;
            default:
                coinvalue.text = String(coinv)
                break;
            }
            //print("finished swipe in")
        }else{
            checkifusertoucheddouble = checkifusertoucheddouble - 1
        }
    }
    @objc func swipedown(){
        //print("down")
        if(checkifusertoucheddouble == 0){
            self.dir.isHidden = true
            self.viewclickb.gestureRecognizers?.removeAll()
            coinv = coinv + 4
            switch (lang) {
            case 0:
                coinvalue.text = convertEngNumToPersianNum(num: String(coinv))
                break;
            case 1:
                coinvalue.text = String(coinv)
                break;
            default:
                coinvalue.text = String(coinv)
                break;
            }
            //print("finished swipe in")
        }else{
            checkifusertoucheddouble = checkifusertoucheddouble - 1
        }
    }
    func doublepointsmove(){
        //print("double points callback")
        doubleanim = true
        doublescore.isHidden = false
        doublescore.isEnabled = true
        doublescore.isUserInteractionEnabled = false
        self.x2l.constant = self.view.bounds.width
        doublescore.setNeedsLayout()
        doubleanimator = UIViewPropertyAnimator(duration: Double(2.0), curve: .linear) { [unowned self, move] in
            self.doublescore.superview?.layoutIfNeeded()
        }
        doubleanimator.addCompletion {
            position in
            switch position {
            case .end:
                do {
                    self.doubleanim = false
                    //print("fini")
                    self.doublescore.isHidden = true
                    self.doublescore.isEnabled = false
                    self.doublescore.isUserInteractionEnabled = false
                    self.x2l.constant = -1 * self.x2w.constant
                    self.randromdoubletime = Double(arc4random_uniform(6) + 20)
                    self.doubletimer.invalidate()
                    //  self.doubletimer =  Foundation.Timer(timeInterval: self.randromdoubletime, target: self, selector: #selector(PlayViewController.doublepointsmove), userInfo: nil, repeats: false)
                    //  RunLoop.current.add(self.doubletimer, forMode: RunLoopMode.commonModes)
                    self.doubletimer =  Timerp(interval: self.randromdoubletime, callback: self.doublepointsmove, repeats: false)
                    self.doubletimer.play()
                    //print(self.randromdoubletime)
                    //print(self.randromdoubletime)
                    self.doubleanimator = nil
                    self.doublelnumber = 0.0
                    //print("fuck")
                }
            case .current: //print("Completion handler called mid-way through animation")
                break;
            case .start: //print("Completion handler called  at start of animation")
                break;
            }
        }
        doubleanimator.isUserInteractionEnabled = true
        doubleanimator.fractionComplete = doublelnumber
        doubleanimator.startAnimation()
        
    }
    func blend(colors: [UIColor]) -> UIColor {
        let componentsSum = colors.reduce((red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0))) { (temp, color) in
            guard let components = color.cgColor.components else { return temp }
            return (temp.0 + components[0], temp.1 + components[1], temp.2 + components[2])
        }
        let components = (red: componentsSum.red / CGFloat(colors.count) ,
                          green: componentsSum.green / CGFloat(colors.count),
                          blue: componentsSum.blue / CGFloat(colors.count))
        return UIColor(red: components.red, green: components.green, blue: components.blue, alpha: 1)
    }
    @objc func doubletimerlasting(){
        self.doubleoffsfx.currentTime = 0
        self.doubleoffsfx.play()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
            self.x2sign.alpha = 0.27
            self.x2sign.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        //print("dobuble timer finished")
        doubleon = false
        doubletimerlast.invalidate()
        //self.doubletimer =  Foundation.Timer(timeInterval: Double(arc4random_uniform(5) + 5), target: self, selector: #selector(PlayViewController.doublepointsmove), userInfo: nil, repeats: false)
       // RunLoop.current.add(self.doubletimer, forMode: RunLoopMode.commonModes)
        self.doubleanim = false
        self.doublescore.isHidden = true
        self.doublescore.isEnabled = false
        self.doublescore.isUserInteractionEnabled = false
        self.x2l.constant = -1 * self.x2w.constant
        //  self.doubletimer =  Foundation.Timer(timeInterval: self.randromdoubletime, target: self, selector: #selector(PlayViewController.doublepointsmove), userInfo: nil, repeats: false)
        //  RunLoop.current.add(self.doubletimer, forMode: RunLoopMode.commonModes)
        self.randromdoubletime = Double(arc4random_uniform(6) + 20)
        //print(randromdoubletime)
        self.doubletimer.invalidate()
        doubletimer =  Timerp(interval: randromdoubletime, callback: doublepointsmove, repeats: false)
        doubletimer.play()
        self.doubleanimator = nil
        self.doublelnumber = 0.0
    }
    func convertEngNumToPersianNum(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ar_JO")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        return faNumber!
    }
    @objc func gameoverslideright(){
        inarow = 0
        mbgm.setVolume(0.0, fadeDuration: 0.5)
        gameoverc.constant = 0
        gameover.setNeedsLayout()
        UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
            self.gameover.alpha = 0
            self.gameover.superview?.layoutIfNeeded()
            }, completion: {(finished: Bool) -> Void in
                KeyStoreDefaultsProvider(cryptoProvider: nil).setInt(forKey: "cv", value: self.coinv)
                NotificationCenter.default.removeObserver(self)
                let scorev = self.storyboard!.instantiateViewController(withIdentifier: "score") as! ScoreViewController
                scorev.scoreval = self.score
                scorev.newhighscoresc = self.newhighscore
                self.navigationController?.pushViewController(scorev, animated: true)
        })
    }
    
}

