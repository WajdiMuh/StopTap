//
//  HtpViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 4/1/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//
import UIKit
import AVFoundation
import AudioToolbox
class HtpViewController: UIViewController {
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
    var wrongsfx: AVAudioPlayer!
    var doubleonsfx: AVAudioPlayer!
    var doubleoffsfx: AVAudioPlayer!
    var inarowsfx: AVAudioPlayer!
    @IBOutlet weak var xw2signwidth: NSLayoutConstraint!
    @IBOutlet weak var x2sign: UIButton!
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
    @IBOutlet weak var timect: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        back.isExclusiveTouch = true
        wrong.image = wrong.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        wrong2.image = wrong2.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        wrong3.image = wrong3.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        back.setImage(UIImage.init(named: "play")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "correct", ofType: "wav")!))
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.wrongsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "wrong", ofType: "wav")!))
            self.wrongsfx.prepareToPlay()
            self.wrongsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.doubleonsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "doublepointson", ofType: "wav")!))
            self.doubleonsfx.prepareToPlay()
            self.doubleonsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.doubleoffsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "doublepointsoff", ofType: "wav")!))
            self.doubleoffsfx.prepareToPlay()
            self.doubleoffsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
            self.inarowsfx =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "inarow", ofType: "wav")!))
            self.inarowsfx.prepareToPlay()
            self.inarowsfx.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
        } catch {
        }
        if(UIDevice.current.userInterfaceIdiom == .phone){
            xw2signwidth.constant = 25.0
        }else{
            xw2signwidth.constant = 40.0
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
        
        x2sign.layer.cornerRadius = (xw2signwidth.constant / 2) //((50 * self.view.bounds.width) / 411)
        x2sign.layer.allowsEdgeAntialiasing = true
        x2sign.titleLabel!.widthAnchor.constraint(equalToConstant: (xw2signwidth.constant * (3/4))).isActive = true
        x2sign.titleLabel!.adjustsFontSizeToFitWidth = true
        x2sign.titleLabel!.numberOfLines = 1
        x2sign.titleLabel!.minimumScaleFactor = 0.05
        x2sign.titleLabel?.baselineAdjustment = .alignCenters
        x2sign.titleLabel?.textAlignment  = .center
        x2sign.layer.shadowOffset = CGSize(width: 0, height: 0)
        
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
        doublescore.layer.cornerRadius = (x2w.constant / 2) //((50 * self.view.bounds.width) / 411)
        doublescore.layer.allowsEdgeAntialiasing = true
        doublescore.layer.shadowColor = UIColor.yellow.cgColor
        doublescore.layer.shadowRadius = 6.0
        doublescore.layer.shadowOffset = CGSize(width: 0, height: 0)
        doublescore.layer.shadowOpacity = 0.75
        dir.image = dir.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.dir.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.back.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch provider.getInt(forKey: "lang", defaultValue: 1) {
        case 0:
            scoreval.text = "النتيجة : ٠"
            scoreval.arabic(size: 24, diffinsize: 14)
            coinval.text = "٠"
            coinval.arabic(size: 22, diffinsize: 8)
            timecount.arabic(size: 20, diffinsize: 20)
            doublescore.setTitle("٢x", for: UIControlState())
            doublescore.arabic(size: 100, diffinsize: 0)
            x2sign.setTitle("٢x", for: UIControlState())
            x2sign.arabic(size: 100, diffinsize: 0)
            break
        case 1:
            scoreval.text = "Score : 0"
            scoreval.english(size: 24, diffinsize: 14)
            coinval.text = "0"
            coinval.english(size: 22, diffinsize: 8)
            timecount.english(size: 20, diffinsize: 20)
            doublescore.setTitle("x2", for: UIControlState())
            doublescore.english(size: 100, diffinsize: 0,left: 4,top: 2)
            x2sign.setTitle("x2", for: UIControlState())
            x2sign.english(size: 100, diffinsize: 0,left: 1,top: 1)
            break
        default:
            scoreval.text = "Score : 0"
            scoreval.english(size: 24, diffinsize: 4)
            coinval.text = "0"
            coinval.english(size: 26, diffinsize: 0)
            timecount.english(size: 20, diffinsize: 0)
            doublescore.setTitle("x2", for: UIControlState())
            doublescore.english(size: 100, diffinsize: 0,left: 4,top: 2)
            x2sign.setTitle("x2", for: UIControlState())
            x2sign.english(size: 100, diffinsize: 0,left: 1,top: 1)
            break
        }
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            timecount.textColor = UIColor.black
            scoreval.textColor = UIColor.black
            base.layer.borderColor = UIColor.black.cgColor
            move.layer.borderColor = UIColor.black.cgColor
            baseanim.layer.borderColor = UIColor.black.cgColor
            baseanim.backgroundColor = UIColor.black
            layerfixbase.borderColor = UIColor.black.cgColor
            doublescore.setTitleColor(UIColor.black, for: UIControlState())
            doublescore.layer.shadowColor = UIColor.black.cgColor
            coinval.textColor = UIColor.black
            dir.tintColor = UIColor.black
            back.tintColor = UIColor.black
            x2sign.layer.shadowColor = UIColor.black.cgColor
            x2sign.setTitleColor(UIColor.black, for: UIControlState())
            
        }else{
            self.view.backgroundColor = UIColor.black
            timecount.textColor = UIColor.white
            scoreval.textColor = UIColor.white
            baseanim.backgroundColor = UIColor.white
            base.layer.borderColor = UIColor.white.cgColor
            move.layer.borderColor = UIColor.white.cgColor
            baseanim.layer.borderColor = UIColor.white.cgColor
            layerfixbase.borderColor = UIColor.white.cgColor
            doublescore.layer.shadowColor = UIColor.white.cgColor
            doublescore.setTitleColor(UIColor.white, for: UIControlState())
            coinval.textColor = UIColor.white
            dir.tintColor = UIColor.white
            back.tintColor = UIColor.white
            x2sign.layer.shadowColor = UIColor.white.cgColor
            x2sign.setTitleColor(UIColor.white, for: UIControlState())
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
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        countdown = Foundation.Timer(timeInterval: 0.5, target: self, selector: #selector(HtpViewController.time), userInfo: nil, repeats: false)
         RunLoop.current.add(countdown, forMode: RunLoopMode.commonModes)
        x2t.constant = ((self.view.bounds.height * (3/4)) - (x2h.constant / 2))
       // print("x2t" + String(describing: x2t.constant))
        x2l.constant = -1 * x2w.constant
        doublescore.titleLabel!.widthAnchor.constraint(equalToConstant: (x2w.constant * (3/4))).isActive = true
        doublescore.titleLabel!.adjustsFontSizeToFitWidth = true
        doublescore.titleLabel!.numberOfLines = 1
        //doublescore.titleLabel!.minimumScaleFactor = 0.05
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
        timecount.setNeedsLayout()
         timect.constant = timecount.frame.origin.x
        timecount.layoutIfNeeded()
    }
    @IBAction func viewcl(_ sender: AnyObject) {
        if(canclick == true){
            if(move.tag == 1){
                if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                timecount.text = ""
                wrongsfx.play()
                wrong.alpha = 1.0
             //   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                move.tag = 2
                canclick = false
                movel.constant = (self.view.bounds.width/2) - (self.move.bounds.width/2)
                move.setNeedsLayout()
                UIView.animate(withDuration: 1, delay: 0, options:[], animations: {
                    self.move.superview?.layoutIfNeeded()
                    }, completion: {(finished: Bool) -> Void in
                        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
                        switch provider.getInt(forKey: "lang", defaultValue: 1) {
                        case 0:
                            self.timecount.text = "انقر الشاشة أثناء وجود الصندوق الصغير داخل الصندوق الكبير لكي تكسب نتيجة. انقر الآن ▼"
                            break
                        case 1:
                            self.timecount.text = "Tap On The Screen While The Small Box Is Inside The Big Box To Gain Score. Tap Now ▼"
                            break
                        default:
                            self.timecount.text = "Tap On The Screen While The Small Box Is Inside The Big Box To Gain Score. Tap Now ▼"
                            break
                        }
                        self.move.tag = 2
                        self.canclick = true
                })
            }else if(move.tag == 2){
                self.baseanim.layer.removeAllAnimations()
                UIView.commitAnimations()
                let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
                if(score == 0){
                    canclick = false
                    audioPlayer.pause()
                    audioPlayer.currentTime = 0
                    audioPlayer.play()
                    timecount.text = ""
                    score = score + 1
                    coins = coins + 1
                    switch provider.getInt(forKey: "lang", defaultValue: 1) {
                    case 0:
                        scoreval.text = "النتيجة : " + convertEngNumToPersianNum(num: String(score))
                        coinval.text = convertEngNumToPersianNum(num: String(coins))
                        break
                    case 1:
                        scoreval.text = "Score : " + String(score)
                        coinval.text = String(coins)
                        break
                    default:
                        scoreval.text = "Score : " + String(score)
                        coinval.text = String(coins)
                        break
                    }
                    baseanim.isHidden = false
                    self.baseanim.transform = CGAffineTransform(scaleX: 1, y: 1)
                    UIView.animate(withDuration: 0.5, delay: 0, options:[], animations: {
                        self.baseanim.transform = CGAffineTransform(scaleX: 0.68, y: 0.68)
                        }, completion:
                        {(finished: Bool) -> Void in
                            if (finished == true){
                                self.baseanim.isHidden = true
                                switch provider.getInt(forKey: "lang", defaultValue: 1) {
                                case 0:
                                    self.timecount.text = "إذا نقرت بشكل صحيح ١٠ مرات على التوالي سوف تحصل على حياة اضافية. انقر الآن ▼"
                                    break
                                case 1:
                                    self.timecount.text = "If You Get It Corret 10 Times In A Row You Will Get An Extra Life. Tap Now ▼"
                                    break
                                default:
                                    self.timecount.text = "If You Get It Corret 10 Times In A Row You Will Get An Extra Life. Tap Now ▼"
                                    break
                                }
                                self.canclick = true
                                
                            }
                        }
                    )


                }else if (score == 1){
                    inarowsfx.play()
                    wrong.alpha = 0.27
                    self.baseanim.isHidden = false
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
                                        self.doublescore.isHidden = false
                                        self.doublescore.isEnabled = true
                                        self.doublescore.isUserInteractionEnabled = true
                                        self.x2l.constant = (self.view.bounds.width/2) - (self.x2w.constant/2)
                                        self.doublescore.setNeedsLayout()
                                        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                                            self.doublescore.superview?.layoutIfNeeded()
                                        }, completion: {(finished: Bool) -> Void in
                                            if(finished == true){
                                                switch provider.getInt(forKey: "lang", defaultValue: 1) {
                                                case 0:
                                                    self.timecount.text = "إذا نقرت إشارة النتيجة المزدوجة سوف تكسب ضعف النتيجة، هذا يستمر لمدة ١٠ ثانية. انقر الآن ▼"
                                                    break
                                                case 1:
                                                    self.timecount.text = "If You Tap On The Double Score Sign You Will Gain Double The Score, This Lasts For 10 Seconds. Tap Now ▼"
                                                    break
                                                default:
                                                    self.timecount.text = "If You Tap On The Double Score Sign You Will Gain Double The Score, This Lasts For 10 Seconds. Tap Now ▼"
                                                    break
                                                }
                                            }
                                        })
                                    }
                            }
                            )
                        }
                    })
                    
                    timecount.text = ""
                    score = score + 1
                    coins = coins + 1
                    switch provider.getInt(forKey: "lang", defaultValue: 1) {
                    case 0:
                        scoreval.text = "النتيجة : " + convertEngNumToPersianNum(num: String(score))
                        coinval.text = convertEngNumToPersianNum(num: String(coins))
                        break
                    case 1:
                        scoreval.text = "Score : " + String(score)
                        coinval.text = String(coins)
                        break
                    default:
                        scoreval.text = "Score : " + String(score)
                        coinval.text = String(coins)
                        break
                    }
                    
                }else if (score == 2){
                    if(doubleon == true){
                        audioPlayer.pause()
                        audioPlayer.currentTime = 0
                        audioPlayer.play()
                        doubleoffsfx.play()
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
                        coins = coins + 1
                        switch provider.getInt(forKey: "lang", defaultValue: 1) {
                        case 0:
                            timecount.text = "اسحب باتجاه السهم لكسب ٤ عملات اضافية. اسحب الآن ▼"
                            scoreval.text = "النتيجة : " + convertEngNumToPersianNum(num: String(score))
                            coinval.text = convertEngNumToPersianNum(num: String(coins))
                            break
                        case 1:
                            timecount.text = "Swipe In The Direction Of The Arrow To Gain 4 Extra Coins. Swipe Now ▼"
                            scoreval.text = "Score : " + String(score)
                            coinval.text = String(coins)
                            break
                        default:
                            timecount.text = "Swipe In The Direction Of The Arrow To Gain 4 Extra Coins. Swipe Now ▼"
                            scoreval.text = "Score : " + String(score)
                            coinval.text = String(coins)
                            break
                        }
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
                            self.x2sign.alpha = 0.27
                            self.x2sign.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        }, completion: nil)
                    }
                }
                }
        }
    }
    @IBAction func x2touchdown(_ sender: Any) {
        doubleon = true
        doubleonsfx.play()
        x2sign.setNeedsLayout()
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: {
            self.x2sign.alpha = 1.0
            self.x2sign.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch provider.getInt(forKey: "lang", defaultValue: 1) {
        case 0:
            timecount.text = "انقر الشاشة أثناء وجود الصندوق الصغير داخل الصندوق الكبير و النتيجة المزدوجة فعّالة لكي تكسب ضعف النتيجة. انقر الآن ▼"
            break
        case 1:
            timecount.text = "Tap On The Screen While The Small Box Is Inside The Big Box And The Double Score Is Active To Gain Double The Score. Tap Now ▼"
            break
        default:
            timecount.text = "Tap On The Screen While The Small Box Is Inside The Big Box And The Double Score Is Active To Gain Double The Score. Tap Now ▼"
            break
        }
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
            let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
            switch provider.getInt(forKey: "lang", defaultValue: 1) {
            case 0:
                self.timecount.text = "إذا نقرت الشاشة أثناء وجود الصندوق الصغير خارج الصندوق الكبير سوف تفقد حياة. انقر الآن ▼"
                break
            case 1:
                self.timecount.text = "If You Tap The Screen While The Small Box Is Outside The Big Box You Will Lose A Life. Tap Now ▼"
                break
            default:
                self.timecount.text = "If You Tap The Screen While The Small Box Is Outside The Big Box You Will Lose A Life. Tap Now ▼"
                break
            }
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
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        coins = coins + 5
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
        switch provider.getInt(forKey: "lang", defaultValue: 1) {
        case 0:
            scoreval.text = "النتيجة : " + convertEngNumToPersianNum(num: String(score))
            coinval.text = convertEngNumToPersianNum(num: String(coins))
            break
        case 1:
            scoreval.text = "Score : " + String(score)
            coinval.text = String(coins)
            break
        default:
            scoreval.text = "Score : " + String(score)
            coinval.text = String(coins)
            break
        }
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
        if(coins == 3){
        dir.isHidden = false
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(HtpViewController.swiperight))
        swiperight.direction = UISwipeGestureRecognizerDirection.right
        self.viewclick.addGestureRecognizer(swiperight)
        }
    }
    @IBAction func backclick(_ sender: Any) {
        if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        countdown.invalidate()
        self.navigationController?.popToRootViewController(animated: true)
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func convertEngNumToPersianNum(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ar_JO")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        return faNumber!
    }
    
}
