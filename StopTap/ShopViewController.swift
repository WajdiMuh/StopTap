//
//  ShopViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 5/10/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//
import AudioToolbox
import UIKit
import AVFoundation

class ShopViewController: UIViewController,colorDelegate {
    @IBOutlet weak var coinval: UILabel!
    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var center: NSLayoutConstraint!
    @IBOutlet weak var nt: NSLayoutConstraint!
    @IBOutlet weak var nb: NSLayoutConstraint!
    @IBOutlet weak var shop: UILabel!
    @IBOutlet weak var small: UIImageView!
    @IBOutlet weak var big: UIImageView!
    @IBOutlet weak var cp: ColorPicker!
    @IBOutlet weak var bigt: UIButton!
    @IBOutlet weak var smallt: UIButton!
    @IBOutlet weak var rboxview: UIImageView!
    @IBOutlet weak var lboxview: UIImageView!
    var shopbgm: AVAudioPlayer!
    var buysound: AVAudioPlayer!
    var lang:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "lang", defaultValue: 1)
    var select:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shopselect", defaultValue: 1)
    var selected:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shopselect", defaultValue: 1)
    var shop2:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop2", defaultValue: 0)
    var shop3:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop3", defaultValue: 0)
    var shop4:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop4", defaultValue: 0)
    var shop5:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop5", defaultValue: 0)
    var shop6:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop6", defaultValue: 0)
    var shop7:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop7", defaultValue: 0)
    var shop8:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop8", defaultValue: 0)
    var shop9:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop9", defaultValue: 0)
    var shop10:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop10", defaultValue: 0)
    var shop11:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop11", defaultValue: 0)
    var shop12:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop12", defaultValue: 0)
    var shop13:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop13", defaultValue: 0)
    var shop14:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop14", defaultValue: 1)
    var shop15:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop15", defaultValue: 0)
    var shop16:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "shop16", defaultValue: 0)
    var cpsc:UIColor = UIColor(hexString: KeyStoreDefaultsProvider(cryptoProvider: nil).getString(forKey: "cpsc", defaultValue: "#004cff"))
    var cpbc:UIColor = UIColor(hexString: KeyStoreDefaultsProvider(cryptoProvider: nil).getString(forKey: "cpbc", defaultValue: "#ff0000"))
    var coinv:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "cv", defaultValue: 0)
    var buyb:Int = 3
    var buyc:Int = 0
    var boxchoose:Int = 0
    var buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
    let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
    var price:NSMutableAttributedString? = nil
    var namec:NSMutableAttributedString? = nil
    var toaststyle = ToastStyle()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(ShopViewController.pausemusic), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShopViewController.resumemusic), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.removeObserver(self)
        shopbgm.stop()
        shopbgm = nil
        buysound.stop()
        buysound = nil
    }
    @objc func pausemusic(){
        shopbgm.pause()
    }
    @objc func resumemusic(){
         shopbgm.play()
        if(buysound.isPlaying == true){
            buysound.stop()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cp.isExclusiveTouch = true
        back.isExclusiveTouch = true
        left.layer.cornerRadius = 10
        left.layer.borderWidth = 5
        right.layer.cornerRadius = 10
        right.layer.borderWidth = 5
        buy.layer.cornerRadius = 10
        buy.layer.borderWidth = 5
        back.layer.cornerRadius = 10
        back.layer.borderWidth = 5
        smallt.layer.cornerRadius = 10
        smallt.layer.borderWidth = 5
        bigt.layer.cornerRadius = 10
        bigt.layer.borderWidth = 5
        small.layer.cornerRadius = 10
        small.layer.borderWidth = 5
        big.layer.cornerRadius = 10
        big.layer.borderWidth = 5
        do {
            self.shopbgm =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "sbackground", ofType: "mp3")!))
            self.shopbgm.prepareToPlay()
            self.shopbgm.volume = 0.0
            self.shopbgm.numberOfLoops = -1
            self.buysound =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "chaching", ofType: "wav")!))
            self.buysound.prepareToPlay()
            self.buysound.volume = (Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "sfxval", defaultValue: 10)) / 10.0)
        } catch {
        }
        price = NSMutableAttributedString(string: "250 Coins")
        price?.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.yellow,range: NSRange(location:0,length:(price?.mutableString.length)!))
        namec = NSMutableAttributedString(string:"Green And Pink\n")
        cp.delegate = self
        lboxview.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        lboxview.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        rboxview.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        rboxview.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        buy.titleLabel?.textAlignment = NSTextAlignment.center
        smallt.titleLabel?.textAlignment = NSTextAlignment.center
        bigt.titleLabel?.textAlignment = NSTextAlignment.center
        switch (lang) {
        case 0:
            back.setTitle("عودة", for: UIControlState())
            back.arabic(size: 20, diffinsize: 10)
            coinval.text = convertEngNumToPersianNum(num: String(coinv))
            coinval.arabic(size: 22, diffinsize: 8)
            buy.arabic(size: 20, diffinsize: 10)
            name.arabic(size: 22, diffinsize: 18)
            shop.text = "المتجر"
            shop.arabic(size: 26, diffinsize: 14)
            smallt.setTitle("لون الصندوق\nالصغير", for: UIControlState())
            bigt.setTitle("لون الصندوق\nالكبير", for: UIControlState())
            smallt.arabic(size: 15, diffinsize: 5)
            bigt.arabic(size: 15, diffinsize: 5)
            if(UIDevice.current.userInterfaceIdiom == .phone){
                toaststyle.titleFont = UIFont.systemFont(ofSize: 18.0)
                 toaststyle.messageFont = UIFont.systemFont(ofSize: 18.0)
            }else{
                toaststyle.titleFont = UIFont.systemFont(ofSize: 25.0)
                 toaststyle.messageFont = UIFont.systemFont(ofSize: 25.0)
            }
            break
        case 1:
            back.setTitle("Back", for: UIControlState())
            back.english(size: 20, diffinsize: 10,left: 4,top: 3)
            coinval.text = String(coinv)
            coinval.english(size: 22, diffinsize: 8)
            buy.english(size: 20, diffinsize: 10,left: 4,top: 2)
            name.english(size: 22, diffinsize: 18)
            shop.text = "Shop"
            shop.english(size: 26, diffinsize: 14)
            smallt.setTitle("Small Box\nColor", for: UIControlState())
            bigt.setTitle("Big Box\nColor", for: UIControlState())
            smallt.english(size: 15, diffinsize: 5,left: 0,top: 0)
            bigt.english(size: 15, diffinsize: 5,left:0,top: 0)
            if(UIDevice.current.userInterfaceIdiom == .phone){
                toaststyle.titleFont = UIFont(name:"DotsAllForNowJL", size: 18.0)
                 toaststyle.messageFont = UIFont(name:"DotsAllForNowJL", size: 18.0)
            }else{
                toaststyle.titleFont = UIFont(name:"DotsAllForNowJL", size: 25.0)
                  toaststyle.messageFont = UIFont(name:"DotsAllForNowJL", size: 25.0)
            }
            break
        default:
            back.setTitle("Back", for: UIControlState())
            back.english(size: 20, diffinsize: 10,left: 4,top: 3)
            coinval.text = String(coinv)
            coinval.english(size: 22, diffinsize: 8)
            buy.english(size: 20, diffinsize: 10,left: 4,top: 2)
            name.english(size: 22, diffinsize: 18)
            shop.text = "Shop"
            shop.english(size: 26, diffinsize: 14)
            smallt.setTitle("Small Box\nColor", for: UIControlState())
            bigt.setTitle("Big Box\nColor", for: UIControlState())
            smallt.english(size: 15, diffinsize: 5,left: 0,top: 0)
            bigt.english(size: 15, diffinsize: 5,left:0,top: 0)
            if(UIDevice.current.userInterfaceIdiom == .phone){
                toaststyle.titleFont = UIFont(name:"DotsAllForNowJL", size: 18.0)
                toaststyle.messageFont = UIFont(name:"DotsAllForNowJL", size: 18.0)
            }else{
                toaststyle.titleFont = UIFont(name:"DotsAllForNowJL", size: 25.0)
                toaststyle.messageFont = UIFont(name:"DotsAllForNowJL", size: 25.0)
            }
            break
        }
        if (selected == 1){
            lboxview.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            left.isEnabled = false
            left.isHidden = true
            switch (lang) {
            case 0:
                name.text = "أحمر و أزرق"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                name.text = "Red And Blue"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                name.text = "Red And Blue"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 2){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "أخضر و وردي"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                name.text = "Green And Pink"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                name.text = "Green And Pink"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 3){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "أزرق و برتقالي"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                name.text = "Blue And Orange"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                name.text = "Blue And Orange"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 4){
            lboxview.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "أرجواني و أخضر"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                  name.text = "Purple And Green"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                 name.text = "Purple And Green"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 5){
            lboxview.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "أزرق و أصفر"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                 name.text = "Blue And Yellow"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
               name.text = "Blue And Yellow"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 6){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "بني و أصفر"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                  name.text = "Brown And Yellow"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                    name.text = "Brown And Yellow"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 7){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "رمادي وأحمر"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                name.text = "Grey And Red"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                  name.text = "Grey And Red"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 8){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "أزرق فاتح و وردي"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                name.text = "Light Blue And Pink"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                 name.text = "Light Blue And Pink"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 9){
            lboxview.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "بني فاتح و أخضر فاتح"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
               name.text = "Light Brown And Light Green"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
             name.text = "Light Brown And Light Green"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 10){
            lboxview.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "أخضر فاتح و أزرق"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                name.text = "Light Green And Blue"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
              name.text = "Light Green And Blue"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 11){
            lboxview.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "زيتي و برتقالي"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                   name.text = "Olive And Orange"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                   name.text = "Olive And Orange"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 12){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)
            switch (lang) {
            case 0:
                name.text = "وردي فاتح و فوشي"
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                   name.text = "Light Pink And Fuschia"
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                    name.text = "Light Pink And Fuschia"
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }else if(selected == 15){
            lboxview.isHidden = true
            rboxview.isHidden = true
            name.isHidden = true
            small.isHidden = false
            big.isHidden = false
            smallt.isHidden = false
            bigt.isHidden = false
            cp.isHidden = false
            small.backgroundColor = cpsc
            big.layer.borderColor = cpbc.cgColor
            big.backgroundColor = cpbc
            switch (lang) {
            case 0:
                buy.setTitle("المختار", for: UIControlState())
                break
            case 1:
                buy.setTitle("Selected", for: UIControlState())
                break
            default:
                buy.setTitle("Selected", for: UIControlState())
                break
            }
        }
        // Do any additional setup after loading the view.
    }
    func pickedColor(_ color: UIColor) {
        if (boxchoose == 0) {
            small.backgroundColor = color
        }else{
            big.backgroundColor = color
        }
        buyb = 2
        switch (lang) {
        case 0:
            buy.setTitle("اختار", for: UIControlState())
            break
        case 1:
            buy.setTitle("Select", for: UIControlState())
            break
        default:
            buy.setTitle("Select", for: UIControlState())
            break
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("viewwill appear")
        shopbgm.play()
        shopbgm.setVolume((Float(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "musicval", defaultValue: 10)) / 10.0), fadeDuration: 0.5)
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            back.layer.borderColor = UIColor.black.cgColor
            buy.layer.borderColor = UIColor.black.cgColor
            left.layer.borderColor = UIColor.black.cgColor
            right.layer.borderColor = UIColor.black.cgColor
            smallt.layer.borderColor = UIColor.black.cgColor
            bigt.layer.borderColor = UIColor.black.cgColor
            small.layer.borderColor = UIColor.black.cgColor
            lboxview.layer.borderColor = UIColor.black.cgColor
            rboxview.layer.borderColor = UIColor.black.cgColor
            back.setTitleColor(UIColor.black, for: UIControlState())
            buy.setTitleColor(UIColor.black, for: UIControlState())
            left.setTitleColor(UIColor.black, for: UIControlState())
            right.setTitleColor(UIColor.black, for: UIControlState())
            smallt.setTitleColor(UIColor.black, for: UIControlState())
            bigt.setTitleColor(UIColor.black, for: UIControlState())
            coinval.textColor = UIColor.black
            name.textColor = UIColor.black
            shop.textColor = UIColor.black
            toaststyle.backgroundColor = UIColor.black
            toaststyle.messageColor = UIColor.white
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black
            shadow.shadowOffset = CGSize(width: 0, height: 0)
            shadow.shadowBlurRadius = 4.0
            price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
            //price?.addAttribute(NSAttributedStringKey.strokeWidth,value: -5.0,range: NSRange(location:0,length:(price?.mutableString.length)!))
            //price?.addAttribute(NSAttributedStringKey.font,value: name.font.withSize(28),range: NSRange(location:0,length:(price?.mutableString.length)!))
        }else{
            self.view.backgroundColor = UIColor.black
            back.layer.borderColor = UIColor.white.cgColor
            buy.layer.borderColor = UIColor.white.cgColor
            left.layer.borderColor = UIColor.white.cgColor
            right.layer.borderColor = UIColor.white.cgColor
            smallt.layer.borderColor = UIColor.white.cgColor
            bigt.layer.borderColor = UIColor.white.cgColor
            small.layer.borderColor = UIColor.white.cgColor
            lboxview.layer.borderColor = UIColor.white.cgColor
            rboxview.layer.borderColor = UIColor.white.cgColor
            right.setTitleColor(UIColor.white, for: UIControlState())
            back.setTitleColor(UIColor.white, for: UIControlState())
            buy.setTitleColor(UIColor.white, for: UIControlState())
            left.setTitleColor(UIColor.white, for: UIControlState())
            smallt.setTitleColor(UIColor.white, for: UIControlState())
            bigt.setTitleColor(UIColor.white, for: UIControlState())
            coinval.textColor = UIColor.white
            name.textColor = UIColor.white
            shop.textColor = UIColor.white
            toaststyle.backgroundColor = UIColor.white
            toaststyle.messageColor = UIColor.black
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowOffset = CGSize(width: 0, height: 0)
            shadow.shadowBlurRadius = 4.0
            price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
            //price?.addAttribute(NSAttributedStringKey.strokeWidth,value: -5.0,range: NSRange(location:0,length:(price?.mutableString.length)!))
            //price?.addAttribute(NSAttributedStringKey.font,value: name.font.withSize(28),range: NSRange(location:0,length:(price?.mutableString.length)!))
        }
    }
    @IBAction func smallclick(_ sender: AnyObject) {
        boxchoose = 0
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            small.layer.borderColor = UIColor.black.cgColor
        }else{
            small.layer.borderColor = UIColor.white.cgColor
        }
        big.layer.borderColor = big.backgroundColor?.cgColor
    }
    @IBAction func bigclick(_ sender: AnyObject) {
        boxchoose = 1
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            big.layer.borderColor = UIColor.black.cgColor
        }else{
            big.layer.borderColor = UIColor.white.cgColor
        }
        small.layer.borderColor = small.backgroundColor?.cgColor
    }
    @IBAction func leftb(_ sender: AnyObject) {
        if(select == 2){
            select = 1
            lboxview.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            left.isEnabled = false
            left.isHidden = true
            switch (lang) {
            case 0:
                name.text = "أحمر و أزرق"
                if (select == selected){
                    buy.setTitle("المختار", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("اختار", for: UIControlState())
                    buyb = 2
                }
                break
            case 1:
                name.text = "Red And Blue"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
                break
            default:
                name.text = "Red And Blue"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
                break
            }
        }else if(select == 3){
            select = 2
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)
            buy.isHidden = false
            if (shop2 == 1){
                switch (lang) {
                case 0:
                   name.text = "أخضر و وردي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                             name.text = "Green And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                             name.text = "Green And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أخضر و وردي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Green And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Green And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
            }
        }else if(select == 4){
            select = 3
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop3 == 1){
                switch (lang) {
                case 0:
                      name.text = "أزرق و برتقالي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                        name.text = "Blue And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                        name.text = "Blue And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أزرق و برتقالي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                              namec?.mutableString.setString("Blue And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                              namec?.mutableString.setString("Blue And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 5){
            select = 4
            lboxview.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop4 == 1){
                switch (lang) {
                case 0:
                  name.text = "أرجواني و أخضر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                     name.text = "Purple And Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                  name.text = "Purple And Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }

            }else{
                
              
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أرجواني و أخضر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Purple And Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                   namec?.mutableString.setString("Purple And Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 6){
            select = 5
            lboxview.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            buy.isHidden = false
            if (shop5 == 1){
                switch (lang) {
                case 0:
                      name.text = "أزرق و أصفر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Blue And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                   name.text = "Blue And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
          
              
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أزرق و أصفر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                          namec?.mutableString.setString("Blue And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                          namec?.mutableString.setString("Blue And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 7){
            select = 6
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            buy.isHidden = false
            if (shop6 == 1){
                switch (lang) {
                case 0:
                    name.text = "بني و أصفر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                      name.text = "Brown And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                      name.text = "Brown And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
               
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("بني و أصفر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                          namec?.mutableString.setString("Brown And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                          namec?.mutableString.setString("Brown And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 8){
            select = 7
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            buy.isHidden = false
            if (shop7 == 1){
                switch (lang) {
                case 0:
                     name.text = "رمادي وأحمر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Grey And Red"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Grey And Red"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
               
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("رمادي وأحمر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                                 namec?.mutableString.setString("Grey And Red\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                                 namec?.mutableString.setString("Grey And Red\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 9){
            select = 8
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            buy.isHidden = false
            if (shop8 == 1){
                switch (lang) {
                case 0:
                    name.text = "أزرق فاتح و وردي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Light Blue And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                   name.text = "Light Blue And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
               
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أزرق فاتح و وردي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                           namec?.mutableString.setString("Light Blue And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                           namec?.mutableString.setString("Light Blue And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 10){
            select = 9
            lboxview.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            buy.isHidden = false
            if (shop9 == 1){
                switch (lang) {
                case 0:
                   name.text = "بني فاتح و أخضر فاتح"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                      name.text = "Light Brown And Light Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                      name.text = "Light Brown And Light Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
              
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("بني فاتح و أخضر فاتح\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                     namec?.mutableString.setString("Light Brown And Light Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                     namec?.mutableString.setString("Light Brown And Light Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 11){
            select = 10
            lboxview.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            buy.isHidden = false
            if (shop10 == 1){
                switch (lang) {
                case 0:
                    name.text = "أخضر فاتح و أزرق"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Light Green And Blue"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Light Green And Blue"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
              
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أخضر فاتح و أزرق\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                     namec?.mutableString.setString("Light Green And Blue\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                     namec?.mutableString.setString("Light Green And Blue\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 12){
            select = 11
            lboxview.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            buy.isHidden = false
            if (shop11 == 1){
                switch (lang) {
                case 0:
                     name.text = "زيتي و برتقالي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                      name.text = "Olive And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                     name.text = "Olive And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
        
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("زيتي و برتقالي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Olive And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Olive And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 13){
            select = 12
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = false
            rboxview.isHidden = false
            buy.isHidden = false
            name.isHidden = false
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
                name.setNeedsLayout()
                center.isActive = false
                nt.isActive = true
                nb.isActive = true
                name.layoutIfNeeded()
            if (shop12 == 1){
                switch (lang) {
                case 0:
                     name.text = "وردي فاتح و فوشي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                              name.text = "Light Pink And Fuschia"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                              name.text = "Light Pink And Fuschia"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
           
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("وردي فاتح و فوشي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                       namec?.mutableString.setString("Light Pink And Fuschia\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                       namec?.mutableString.setString("Light Pink And Fuschia\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 14){
            select = 13
            name.setNeedsLayout()
            center.isActive = true
            nt.isActive = false
            nb.isActive = false
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            if (shop13 == 1){
                switch (lang) {
                case 0:
                    name.text = "وضع الظلام\nاستبدل الأبيض بالأسود"
                    if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                        buy.setTitle("وضع الظلام غير مفعّل", for: UIControlState())
                    }else{
                        buy.setTitle("وضع الظلام مفعّل", for: UIControlState())
                    }
                    break
                case 1:
                      name.text = "NIGHTMODE\nReplace White With Black"
                      if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                        buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                      }else{
                        buy.setTitle("NIGHTMODE ON", for: UIControlState())
                      }
                    break
                default:
                    name.text = "NIGHTMODE\nReplace White With Black"
                    if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                        buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                    }else{
                        buy.setTitle("NIGHTMODE ON", for: UIControlState())
                    }
                    break
                }
                buyb = 3
            }else{
            
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٥٠٠ عملة")
                    namec?.mutableString.setString("وضع الظلام\nاستبدل الأبيض بالأسود\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                   price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("NIGHTMODE\nReplace White With Black\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("NIGHTMODE\nReplace White With Black\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
            }
        }else if(select == 15){
            select = 14
            name.setNeedsLayout()
            nt.isActive = false
            nb.isActive = false
            center.isActive = true
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            if (shop14 == 3){
                buyb = 3
                buy.isHidden = true
                switch (lang) {
                case 0:
                    name.text = "٣x\nضاعف عملاتك بمقدار ثلاثة مرات"
                    break
                case 1:
                    name.text = "X3\nTriple Your Coins"
                    break
                default:
                    name.text = "X3\nTriple Your Coins"
                    break
                }
            }else if(shop14 == 2){
                switch (lang) {
                case 0:
                    price?.mutableString.setString("١٠٠٠ عملة")
                    namec?.mutableString.setString("٣x\nضاعف عملاتك بمقدار ثلاثة مرات\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("X3\nTriple Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("X3\nTriple Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }else if(shop14 == 1){
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٥٠٠ عملة")
                    namec?.mutableString.setString("٢x\nضاعف عملاتك\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("X2\nDouble Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("X2\nDouble Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
            
            }else if(select == 16){
            select = 15
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            if (shop15 == 1){
                name.isHidden = true
                small.isHidden = false
                big.isHidden = false
                smallt.isHidden = false
                bigt.isHidden = false
                cp.isHidden = false
                small.backgroundColor = cpsc
                big.backgroundColor = cpbc
                boxchoose = 0
                if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                    small.layer.borderColor = UIColor.black.cgColor
                }else{
                    small.layer.borderColor = UIColor.white.cgColor
                }
                big.layer.borderColor = big.backgroundColor?.cgColor
                switch (lang) {
                case 0:
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                switch (lang) {
                case 0:
                    price?.mutableString.setString("١٠٠٠ عملة")
                    namec?.mutableString.setString("اختيار الألوان\nاختار الألوان الخاصة بك\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("Color Picker\nChoose Your Own Colors\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("Color Picker\nChoose Your Own Colors\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }
    }
    @IBAction func rightb(_ sender: AnyObject) {
        if(select == 1){
            select = 2
            left.isEnabled = true
            left.isHidden = false
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)
            buy.isHidden = false
            if (shop2 == 1){
                switch (lang) {
                case 0:
                    name.text = "أخضر و وردي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Green And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Green And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أخضر و وردي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Green And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Green And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
            }
        }else if(select == 2){
            select = 3
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop3 == 1){
                switch (lang) {
                case 0:
                    name.text = "أزرق و برتقالي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Blue And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Blue And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أزرق و برتقالي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Blue And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Blue And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 3){
            select = 4
            lboxview.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop4 == 1){
                switch (lang) {
                case 0:
                    name.text = "أرجواني و أخضر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Purple And Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Purple And Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
                
            }else{
                
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أرجواني و أخضر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Purple And Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Purple And Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 4){
            select = 5
            lboxview.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            buy.isHidden = false
            if (shop5 == 1){
                switch (lang) {
                case 0:
                    name.text = "أزرق و أصفر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Blue And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Blue And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أزرق و أصفر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Blue And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Blue And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 5){
            select = 6
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            buy.isHidden = false
            if (shop6 == 1){
                switch (lang) {
                case 0:
                    name.text = "بني و أصفر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Brown And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Brown And Yellow"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("بني و أصفر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Brown And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Brown And Yellow\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 6){
            select = 7
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            buy.isHidden = false
            if (shop7 == 1){
                switch (lang) {
                case 0:
                    name.text = "رمادي وأحمر"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Grey And Red"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Grey And Red"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("رمادي وأحمر\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Grey And Red\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Grey And Red\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 7){
            select = 8
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            buy.isHidden = false
            if (shop8 == 1){
                switch (lang) {
                case 0:
                    name.text = "أزرق فاتح و وردي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Light Blue And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Light Blue And Pink"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أزرق فاتح و وردي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Blue And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Blue And Pink\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 8){
            select = 9
            lboxview.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            buy.isHidden = false
            if (shop9 == 1){
                switch (lang) {
                case 0:
                    name.text = "بني فاتح و أخضر فاتح"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Light Brown And Light Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Light Brown And Light Green"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("بني فاتح و أخضر فاتح\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Brown And Light Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Brown And Light Green\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 9){
            select = 10
            lboxview.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            buy.isHidden = false
            if (shop10 == 1){
                switch (lang) {
                case 0:
                    name.text = "أخضر فاتح و أزرق"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Light Green And Blue"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Light Green And Blue"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("أخضر فاتح و أزرق\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Green And Blue\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Green And Blue\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 10){
            select = 11
            lboxview.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            buy.isHidden = false
            if (shop11 == 1){
                switch (lang) {
                case 0:
                    name.text = "زيتي و برتقالي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Olive And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Olive And Orange"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("زيتي و برتقالي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Olive And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Olive And Orange\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 11){
            select = 12
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop12 == 1){
                switch (lang) {
                case 0:
                    name.text = "وردي فاتح و فوشي"
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    name.text = "Light Pink And Fuschia"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    name.text = "Light Pink And Fuschia"
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٢٥٠ عملة")
                    namec?.mutableString.setString("وردي فاتح و فوشي\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Pink And Fuschia\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("250 Coins")
                    namec?.mutableString.setString("Light Pink And Fuschia\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 12){
            select = 13
            name.setNeedsLayout()
            nt.isActive = false
            nb.isActive = false
            center.isActive = true
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            if (shop13 == 1){
                switch (lang) {
                case 0:
                    name.text = "وضع الظلام\nاستبدل الأبيض بالأسود"
                    if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                        buy.setTitle("وضع الظلام غير مفعّل", for: UIControlState())
                    }else{
                        buy.setTitle("وضع الظلام مفعّل", for: UIControlState())
                    }
                    break
                case 1:
                    name.text = "NIGHTMODE\nReplace White With Black"
                    if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                        buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                    }else{
                        buy.setTitle("NIGHTMODE ON", for: UIControlState())
                    }
                    break
                default:
                    name.text = "NIGHTMODE\nReplace White With Black"
                    if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                        buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                    }else{
                        buy.setTitle("NIGHTMODE ON", for: UIControlState())
                    }
                    break
                }
                buyb = 3
            }else{
                
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٥٠٠ عملة")
                    namec?.mutableString.setString("وضع الظلام\nاستبدل الأبيض بالأسود\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("NIGHTMODE\nReplace White With Black\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("NIGHTMODE\nReplace White With Black\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
            }
        }
        else if(select == 13){
            select = 14
            name.setNeedsLayout()
            center.isActive = true
            nt.isActive = false
            nb.isActive = false
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            if (shop14 == 3){
                buyb = 3
                buy.isHidden = true
                switch (lang) {
                case 0:
                    name.text = "٣x\nضاعف عملاتك بمقدار ثلاثة مرات"
                    break
                case 1:
                    name.text = "X3\nTriple Your Coins"
                    break
                default:
                    name.text = "X3\nTriple Your Coins"
                    break
                }
            }else if(shop14 == 2){
                switch (lang) {
                case 0:
                    price?.mutableString.setString("١٠٠٠ عملة")
                    namec?.mutableString.setString("٣x\nضاعف عملاتك بمقدار ثلاثة مرات\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("X3\nTriple Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("X3\nTriple Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }else if(shop14 == 1){
                switch (lang) {
                case 0:
                    price?.mutableString.setString("٥٠٠ عملة")
                    namec?.mutableString.setString("٢x\nضاعف عملاتك\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("X2\nDouble Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("500 Coins")
                    namec?.mutableString.setString("X2\nDouble Your Coins\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 14){
            select = 15
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.setNeedsLayout()
            center.isActive = true
            nt.isActive = false
            nb.isActive = false
            name.layoutIfNeeded()
            if (shop15 == 1){
                name.isHidden = true
                small.isHidden = false
                big.isHidden = false
                smallt.isHidden = false
                bigt.isHidden = false
                cp.isHidden = false
                small.backgroundColor = cpsc
                big.backgroundColor = cpbc
                boxchoose = 0
                if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                    small.layer.borderColor = UIColor.black.cgColor
                }else{
                    small.layer.borderColor = UIColor.white.cgColor
                }
                big.layer.borderColor = big.backgroundColor?.cgColor
                switch (lang) {
                case 0:
                    if (select == selected){
                        buy.setTitle("المختار", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("اختار", for: UIControlState())
                        buyb = 2
                    }
                    break
                case 1:
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                default:
                    if (select == selected){
                        buy.setTitle("Selected", for: UIControlState())
                        buyb = 3
                    }else{
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                    }
                    break
                }
            }else{
                switch (lang) {
                case 0:
                    price?.mutableString.setString("١٠٠٠ عملة")
                    namec?.mutableString.setString("اختيار الألوان\nاختار الألوان الخاصة بك\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("Color Picker\nChoose Your Own Colors\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("Color Picker\nChoose Your Own Colors\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                
            }
        }else if(select == 15){
            select = 16
                name.setNeedsLayout()
            nt.isActive = false
            nb.isActive = false
            center.isActive = true
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = false
            right.isHidden = true
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            if (shop16 == 1){
                    switch (lang) {
                    case 0:
                        name.text = "روح اضافية\nسيكون لديك ٤ أرواح"
                        break
                    case 1:
                        name.text = "Extra Life\nYou Will Now Have 4 Lives"
                        break
                    default:
                        name.text = "Extra Life\nYou Will Now Have 4 Lives"
                        break
                    }
                buyb = 3
                buy.isHidden = true
            }else{
                switch (lang) {
                case 0:
                    price?.mutableString.setString("١٠٠٠ عملة")
                    namec?.mutableString.setString("روح اضافية\nسيكون لديك ٤ أرواح\n")
                    buy.setTitle("اشتري", for: UIControlState())
                    break
                case 1:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("Extra Life\nYou Will Now Have 4 Lives\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                default:
                    price?.mutableString.setString("1000 Coins")
                    namec?.mutableString.setString("Extra Life\nYou Will Now Have 4 Lives\n")
                    buy.setTitle("Buy", for: UIControlState())
                    break
                }
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
            }
        }
    }
    @IBAction func buyb(_ sender: AnyObject) {
        if(buyc == 0){
            if(buyb == 1){
                if(select == 2){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop2 = 1
                        provider.setInt(forKey: "shop2", value: 1)
                        provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "أخضر و وردي"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Green And Pink"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Green And Pink"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 3){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop3 = 1
                         provider.setInt(forKey: "shop3", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "أزرق و برتقالي"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Blue And Orange"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Blue And Orange"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 4){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop4 = 1
                        provider.setInt(forKey: "shop4", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "أرجواني و أخضر"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Purple And Green"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Purple And Green"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 5){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop5 = 1
                        provider.setInt(forKey: "shop5", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "أزرق و أصفر"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Blue And Yellow"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Blue And Yellow"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 6){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop6 = 1
                       provider.setInt(forKey: "shop6", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "بني و أصفر"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Brown And Yellow"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Brown And Yellow"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 7){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop7 = 1
                         provider.setInt(forKey: "shop7", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "رمادي وأحمر"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                             name.text = "Grey And Red"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Grey And Red"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 8){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop8 = 1
                        provider.setInt(forKey: "shop8", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "أزرق فاتح و وردي"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Light Blue And Pink"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Light Blue And Pink"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 9){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop9 = 1
                         provider.setInt(forKey: "shop9", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "بني فاتح و أخضر فاتح"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                             name.text = "Light Brown And Light Green"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Light Brown And Light Green"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 10){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop10 = 1
                        provider.setInt(forKey: "shop10", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "أخضر فاتح و أزرق"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Light Green And Blue"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Light Green And Blue"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 11){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop11 = 1
                      provider.setInt(forKey: "shop11", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                             name.text = "زيتي و برتقالي"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                           name.text = "Olive And Orange"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Olive And Orange"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 12){
                    if(coinv >= 250){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 2
                        coinv = coinv - 250
                        shop12 = 1
                        provider.setInt(forKey: "shop12", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "وردي فاتح و فوشي"
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Light Pink And Fuschia"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Light Pink And Fuschia"
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 13){
                    if(coinv >= 500){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buyb = 3
                        coinv = coinv - 500
                        shop13 = 1
                        provider.setInt(forKey: "shop13", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "وضع الظلام\nاستبدل الأبيض بالأسود"
                            buy.setTitle("وضع الظلام غير مفعّل", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                            name.text = "NIGHTMODE\nReplace White With Black"
                            coinval.text = String(coinv)
                            break
                        default:
                            buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                            name.text = "NIGHTMODE\nReplace White With Black"
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }else if(select == 14){
                    if(shop14 == 2){
                            if(coinv >= 1000){
                                self.buysound.pause()
                                self.buysound.currentTime = 0
                                self.buysound.play()
                                buy.isHidden = true
                            buyb = 2
                            coinv = coinv - 1000
                            shop14 = 3
                            provider.setInt(forKey: "shop14", value: 3)
                               provider.setInt(forKey: "cv", value: coinv)
                            switch (lang) {
                            case 0:
                                name.text = "٣x\nضاعف عملاتك بمقدار ثلاثة مرات"
                                coinval.text = convertEngNumToPersianNum(num: String(coinv))
                                break
                            case 1:
                                name.text = "X3\nTriple Your Coins"
                                coinval.text = String(coinv)
                                break
                            default:
                                name.text = "X3\nTriple Your Coins"
                                coinval.text = String(coinv)
                                break
                            }
                        }else{
                            if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                            }
                            switch (lang) {
                            case 0:
                                self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                                break
                            case 1:
                                self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                                break
                            default:
                                self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                                break
                            }
                            buy.isEnabled = false
                            buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                        }
                }else{
                        if(coinv >= 500){
                            self.buysound.pause()
                            self.buysound.currentTime = 0
                            self.buysound.play()
                            coinv = coinv - 500
                               provider.setInt(forKey: "cv", value: coinv)
                            switch (lang) {
                            case 0:
                                price?.mutableString.setString("١٠٠٠ عملة")
                                namec?.mutableString.setString("٣x\nضاعف عملاتك بمقدار ثلاثة مرات\n")
                                buy.setTitle("اشتري", for: UIControlState())
                                coinval.text = convertEngNumToPersianNum(num: String(coinv))
                                break
                            case 1:
                                price?.mutableString.setString("1000 Coins")
                                namec?.mutableString.setString("X3\nTriple Your Coins\n")
                                buy.setTitle("Buy", for: UIControlState())
                                coinval.text = String(coinv)
                                break
                            default:
                                price?.mutableString.setString("1000 Coins")
                                namec?.mutableString.setString("X3\nTriple Your Coins\n")
                                buy.setTitle("Buy", for: UIControlState())
                                coinval.text = String(coinv)
                                break
                            }
                            namec?.append(price!)
                            name.attributedText = namec
                            buyb = 1
                            shop14 = 2
                            provider.setInt(forKey: "shop14", value: 2)
                        }else{
                            if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                            }
                            switch (lang) {
                            case 0:
                                self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                                break
                            case 1:
                                self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                                break
                            default:
                                self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                                break
                            }
                            buy.isEnabled = false
                            buy.isHidden = true
                            buyc = 1
                            left.isHidden = true
                            right.isHidden = true
                            left.isEnabled = false
                            right.isEnabled = false
                            buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                            RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                        }
                }
            }
                else if(select == 15){
                    if(coinv >= 1000){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        name.isHidden = true
                        small.isHidden = false
                        big.isHidden = false
                        smallt.isHidden = false
                        bigt.isHidden = false
                        big.layer.borderColor = big.backgroundColor?.cgColor
                        cp.isHidden = false
                        buyb = 2
                        coinv = coinv - 1000
                        shop15 = 1
                        provider.setInt(forKey: "shop15", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            buy.setTitle("اختار", for: UIControlState())
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        default:
                            buy.setTitle("Select", for: UIControlState())
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                    
                    }else if(select == 16){
                    if(coinv >= 1000){
                        self.buysound.pause()
                        self.buysound.currentTime = 0
                        self.buysound.play()
                        buy.isHidden = true
                            buyb = 2
                            coinv = coinv - 1000
                            shop16 = 1
                            provider.setInt(forKey: "shop16", value: 1)
                           provider.setInt(forKey: "cv", value: coinv)
                        switch (lang) {
                        case 0:
                            name.text = "روح اضافية\nسيكون لديك ٤ أرواح"
                            coinval.text = convertEngNumToPersianNum(num: String(coinv))
                            break
                        case 1:
                            name.text = "Extra Live\nYou Will Now Have 4 Lives"
                            coinval.text = String(coinv)
                            break
                        default:
                            name.text = "Extra Live\nYou Will Now Have 4 Lives"
                            coinval.text = String(coinv)
                            break
                        }
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        }
                        switch (lang) {
                        case 0:
                            self.view.makeToast("ليس لديك\nعملات كافية", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        case 1:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        default:
                            self.view.makeToast("You Don't Have\nEnough Coins", duration: 1.1, position: .shop, style: toaststyle)
                            break
                        }
                        buy.isEnabled = false
                        buy.isHidden = true
                        buyc = 1
                        left.isHidden = true
                        right.isHidden = true
                        left.isEnabled = false
                        right.isEnabled = false
                        buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
                        RunLoop.current.add(buycancel, forMode: RunLoopMode.commonModes)
                    }
                }
            }else if(buyb == 2){
                if(select == 15){
                    if(color(small.backgroundColor!, isEqualToColor:UIColor.white, withTolerance: 0.2) || color(small.backgroundColor!, isEqualToColor:UIColor.black, withTolerance: 0.2) ||
                        color(small.backgroundColor!, isEqualToColor:big.backgroundColor!, withTolerance: 0.5) ||
                        color(big.backgroundColor!, isEqualToColor:UIColor.white, withTolerance: 0.2)
                        || color(big.backgroundColor!, isEqualToColor:UIColor.black, withTolerance: 0.2)){
                        switch (lang) {
                        case 0:
                            self.view.makeToast("الصناديق لا يمكن أن يكونوا أبيض أو أسود\nو لا يمكن أن يكونوا نفس اللون", duration: 1.1, position: .center, style: toaststyle)
                            break
                        case 1:
                             self.view.makeToast("The Boxes Can't Be White or Black\nAnd They Can't Have The Same Color", duration: 1.1, position: .center, style: toaststyle)
                            break
                        default:
                             self.view.makeToast("The Boxes Can't Be White or Black\nAnd They Can't Have The Same Color", duration: 1.1, position: .center, style: toaststyle)
                            break
                        }
                        //print("there r equals")
                    }else{
                        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                            AudioServicesPlaySystemSound(1519);
                        }
                        buyb = 3
                        //print("error")
                        provider.setString(forKey: "cpsc", value: (small.backgroundColor?.toHexString())!)
                        provider.setString(forKey: "cpbc", value: (big.backgroundColor?.toHexString())!)
                        cpsc = small.backgroundColor!
                        cpbc = big.backgroundColor!
                        provider.setInt(forKey: "shopselect", value: select)
                        selected = select
                        switch (lang) {
                        case 0:
                            buy.setTitle("المختار", for: UIControlState())
                            break
                        case 1:
                            buy.setTitle("Selected", for: UIControlState())
                            break
                        default:
                            buy.setTitle("Selected", for: UIControlState())
                            break
                        }
                    }
                }else{
                    if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
                        AudioServicesPlaySystemSound(1519);
                    }
                    provider.setInt(forKey: "shopselect", value: select)
                    selected = select
                    switch (lang) {
                    case 0:
                        buy.setTitle("المختار", for: UIControlState())
                        break
                    case 1:
                        buy.setTitle("Selected", for: UIControlState())
                        break
                    default:
                        buy.setTitle("Selected", for: UIControlState())
                        break
                    }
                }
            }else if(select == 13 && shop13 == 1){
                let shadow = NSShadow()
                shadow.shadowOffset = CGSize(width: 0, height: 0)
                shadow.shadowBlurRadius = 4.0
                if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                    switch (lang) {
                    case 0:
                            buy.setTitle("وضع الظلام مفعّل", for: UIControlState())
                        break
                    case 1:
                            buy.setTitle("NIGHTMODE ON", for: UIControlState())
                        break
                    default:
                            buy.setTitle("NIGHTMODE ON", for: UIControlState())
                        break
                    }
                    provider.setInt(forKey: "nm", value: 1)
                    self.view.backgroundColor = UIColor.black
                    back.layer.borderColor = UIColor.white.cgColor
                    buy.layer.borderColor = UIColor.white.cgColor
                    left.layer.borderColor = UIColor.white.cgColor
                    right.layer.borderColor = UIColor.white.cgColor
                    smallt.layer.borderColor = UIColor.white.cgColor
                    bigt.layer.borderColor = UIColor.white.cgColor
                    small.layer.borderColor = UIColor.white.cgColor
                    big.layer.borderColor = UIColor.white.cgColor
                    lboxview.layer.borderColor = UIColor.white.cgColor
                    rboxview.layer.borderColor = UIColor.white.cgColor
                    right.setTitleColor(UIColor.white, for: UIControlState())
                    back.setTitleColor(UIColor.white, for: UIControlState())
                    buy.setTitleColor(UIColor.white, for: UIControlState())
                    left.setTitleColor(UIColor.white, for: UIControlState())
                    smallt.setTitleColor(UIColor.white, for: UIControlState())
                    bigt.setTitleColor(UIColor.white, for: UIControlState())
                    coinval.textColor = UIColor.white
                    name.textColor = UIColor.white
                    shop.textColor = UIColor.white
                    toaststyle.backgroundColor = UIColor.white
                    toaststyle.messageColor = UIColor.black
                    shadow.shadowColor = UIColor.white
                    price?.removeAttribute(NSAttributedStringKey.shadow, range: NSRange(location:0,length:(price?.mutableString.length)!))
                    price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
                }else{
                    switch (lang) {
                    case 0:
                            buy.setTitle("وضع الظلام غير مفعّل", for: UIControlState())
                        break
                    case 1:
                            buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                        break
                    default:
                            buy.setTitle("NIGHTMODE OFF", for: UIControlState())
                        break
                    }
                    provider.setInt(forKey: "nm", value: 0)
                    self.view.backgroundColor = UIColor.white
                    back.layer.borderColor = UIColor.black.cgColor
                    buy.layer.borderColor = UIColor.black.cgColor
                    left.layer.borderColor = UIColor.black.cgColor
                    right.layer.borderColor = UIColor.black.cgColor
                    smallt.layer.borderColor = UIColor.black.cgColor
                    bigt.layer.borderColor = UIColor.black.cgColor
                    lboxview.layer.borderColor = UIColor.black.cgColor
                    rboxview.layer.borderColor = UIColor.black.cgColor
                    small.layer.borderColor = UIColor.black.cgColor
                    big.layer.borderColor = UIColor.black.cgColor
                    back.setTitleColor(UIColor.black, for: UIControlState())
                    buy.setTitleColor(UIColor.black, for: UIControlState())
                    left.setTitleColor(UIColor.black, for: UIControlState())
                    right.setTitleColor(UIColor.black, for: UIControlState())
                    smallt.setTitleColor(UIColor.black, for: UIControlState())
                    bigt.setTitleColor(UIColor.black, for: UIControlState())
                    coinval.textColor = UIColor.black
                    name.textColor = UIColor.black
                    shop.textColor = UIColor.black
                    toaststyle.backgroundColor = UIColor.black
                    toaststyle.messageColor = UIColor.white
                    shadow.shadowColor = UIColor.black
                    price?.removeAttribute(NSAttributedStringKey.shadow, range: NSRange(location:0,length:(price?.mutableString.length)!))
                    price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
                }
            }
        }
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
     return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
    }
    
    @IBAction func back(_ sender: AnyObject) {
        if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        shopbgm.setVolume(0.0, fadeDuration: 0.5)
        buycancel.invalidate()
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func buycanim(){
        buy.isEnabled = true
        buy.isHidden = false
        buyc = 0
        if (select != 16){
            right.isHidden = false
            left.isHidden = false
            right.isEnabled = true
            left.isEnabled = true
        }else{
            left.isHidden = false
            left.isEnabled = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func color(_ color1: UIColor, isEqualToColor color2: UIColor, withTolerance tolerance: CGFloat) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return fabs(r1 - r2) <= tolerance && fabs(g1 - g2) <= tolerance && fabs(b1 - b2) <= tolerance && fabs(a1 - a2) <= tolerance
    }
    func convertEngNumToPersianNum(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ar_JO")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        return faNumber!
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
extension UIColor {
    convenience init(hexString:String) {
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }

    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}
