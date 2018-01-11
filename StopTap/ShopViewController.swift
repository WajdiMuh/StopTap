//
//  ShopViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 5/10/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController,colorDelegate {
    @IBOutlet weak var coinval: UILabel!
    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var buy: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var center: NSLayoutConstraint!
    @IBOutlet weak var shop: UILabel!
    @IBOutlet weak var small: UIImageView!
    @IBOutlet weak var big: UIImageView!
    @IBOutlet weak var cp: ColorPicker!
    @IBOutlet weak var bigt: UIButton!
    @IBOutlet weak var smallt: UIButton!
    @IBOutlet weak var rs: UISlider!
    @IBOutlet weak var rv: UILabel!
    @IBOutlet weak var gv: UILabel!
    @IBOutlet weak var gs: UISlider!
    @IBOutlet weak var bv: UILabel!
    @IBOutlet weak var bs: UISlider!
    @IBOutlet weak var rboxview: UIImageView!
    @IBOutlet weak var lboxview: UIImageView!
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
    var coinv:Int = 30002223
    var buyb:Int = 3
    var buyc:Int = 0
    var boxchoose:Int = 0
    var buycancel = Foundation.Timer(timeInterval: 1.5, target: self, selector: #selector(ShopViewController.buycanim), userInfo: nil, repeats: false)
    let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
    var price:NSMutableAttributedString? = nil
    var namec:NSMutableAttributedString? = nil
    @IBOutlet weak var cperror: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        rs.isExclusiveTouch = true
        gs.isExclusiveTouch = true
        bs.isExclusiveTouch = true
        cp.isExclusiveTouch = true
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
        price = NSMutableAttributedString(string: "250 Coin")
        price?.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.yellow,range: NSRange(location:0,length:(price?.mutableString.length)!))
        coinval.text = String(coinv)
        namec = NSMutableAttributedString(string:"Green And Pink\n")
        cp.delegate = self
        lboxview.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        lboxview.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        rboxview.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        rboxview.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        buy.titleLabel?.textAlignment = NSTextAlignment.center
        smallt.titleLabel?.textAlignment = NSTextAlignment.center
        bigt.titleLabel?.textAlignment = NSTextAlignment.center
        smallt.setTitle("Small Box\nColor", for: UIControlState())
        bigt.setTitle("Big Box\nColor", for: UIControlState())
        if (selected == 1){
            lboxview.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            left.isEnabled = false
            left.isHidden = true
            name.text = "Red And Blue"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 2){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)
            name.text = "Green And Pink"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 3){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            name.text = "Blue And Orange"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 4){
            lboxview.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            name.text = "Purple And Green"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 5){
            lboxview.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            name.text = "Blue And Yellow"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 6){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            name.text = "Brown And Yellow"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 7){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            name.text = "Grey And Red"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 8){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            name.text = "Light Blue And Pink"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 9){
            lboxview.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            name.text = "Light Brown And Light Green"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 10){
            lboxview.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            name.text = "Light Green And Blue"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 11){
            lboxview.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            name.text = "Olive And Orange"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 12){
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)
            name.text = "Light Pink And Fuschia"
            buy.setTitle("Selected", for: UIControlState())
        }else if(selected == 15){
            lboxview.isHidden = true
            rboxview.isHidden = true
            name.isHidden = true
            rv.isHidden = false
            rs.isHidden = false
            gv.isHidden = false
            gs.isHidden = false
            bv.isHidden = false
            bs.isHidden = false
            small.isHidden = false
            big.isHidden = false
            smallt.isHidden = false
            bigt.isHidden = false
            cp.isHidden = false
            small.backgroundColor = cpsc
            big.backgroundColor = cpbc
            var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0,a:CGFloat = 0
            cpsc.getRed(&r, green: &g, blue: &b, alpha: &a)
            rs.value = Float(r * 255)
            gs.value = Float(g * 255)
            bs.value = Float(b * 255)
            buy.setTitle("Selected", for: UIControlState())
        }
        // Do any additional setup after loading the view.
    }
    func pickedColor(_ color: UIColor) {
        if (boxchoose == 0) {
            small.backgroundColor = color
        }else{
            big.backgroundColor = color
        }
        var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0,a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        rs.value = Float(r * 255)
        gs.value = Float(g * 255)
        bs.value = Float(b * 255)
        rv.text = String(Int(r * 255))
        gv.text = String(Int(g * 255))
        bv.text = String(Int(b * 255))
        buyb = 2
        buy.setTitle("Select", for: UIControlState())
    }
    func touchendcp() {
        rv.text = "R"
        gv.text = "G"
        bv.text = "B"
    }
    @IBAction func rsd(_ sender: AnyObject) {
        rv.text = String(Int(rs.value))
        if(boxchoose == 0){
        small.backgroundColor = UIColor(red: CGFloat(rs.value/255), green: CGFloat(gs.value/255), blue: CGFloat(bs.value/255), alpha: 1.0)
        }else{
        big.backgroundColor = UIColor(red: CGFloat(rs.value/255), green: CGFloat(gs.value/255), blue: CGFloat(bs.value/255), alpha: 1.0)
        }
        buyb = 2
        buy.setTitle("Select", for: UIControlState())
    }
    @IBAction func rsc(_ sender: AnyObject) {
        rv.text = "R"
    }
    @IBAction func rsuo(_ sender: AnyObject) {
        rv.text = "R"
    }
    @IBAction func rsui(_ sender: AnyObject) {
        rv.text = "R"
    }
    @IBAction func gsv(_ sender: AnyObject) {
        gv.text = String(Int(gs.value))
        if(boxchoose == 0){
            small.backgroundColor = UIColor(red: CGFloat(rs.value/255), green: CGFloat(gs.value/255), blue: CGFloat(bs.value/255), alpha: 1.0)
        }else{
            big.backgroundColor = UIColor(red: CGFloat(rs.value/255), green: CGFloat(gs.value/255), blue: CGFloat(bs.value/255), alpha: 1.0)
        }
        buyb = 2
        buy.setTitle("Select", for: UIControlState())
    }
    @IBAction func gsc(_ sender: AnyObject) {
        gv.text = "G"
    }
    @IBAction func gsui(_ sender: AnyObject) {
        gv.text = "G"
    }
    @IBAction func gsao(_ sender: AnyObject) {
        gv.text = "G"
    }
    @IBAction func bsv(_ sender: AnyObject) {
        bv.text = String(Int(bs.value))
        if(boxchoose == 0){
            small.backgroundColor = UIColor(red: CGFloat(rs.value/255), green: CGFloat(gs.value/255), blue: CGFloat(bs.value/255), alpha: 1.0)
        }else{
            big.backgroundColor = UIColor(red: CGFloat(rs.value/255), green: CGFloat(gs.value/255), blue: CGFloat(bs.value/255), alpha: 1.0)
        }
        buyb = 2
        buy.setTitle("Select", for: UIControlState())
    }
    @IBAction func bsc(_ sender: AnyObject) {
        bv.text = "B"
    }
    @IBAction func bsui(_ sender: AnyObject) {
        bv.text = "B"
    }
    @IBAction func bsuo(_ sender: AnyObject) {
        bv.text = "B"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            back.layer.borderColor = UIColor.black.cgColor
            buy.layer.borderColor = UIColor.black.cgColor
            left.layer.borderColor = UIColor.black.cgColor
            right.layer.borderColor = UIColor.black.cgColor
            smallt.layer.borderColor = UIColor.black.cgColor
            bigt.layer.borderColor = UIColor.black.cgColor
            small.layer.borderColor = UIColor.black.cgColor
            big.layer.borderColor = UIColor.black.cgColor
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
            cperror.textColor = UIColor.black
            rv.textColor = UIColor.black
            gv.textColor = UIColor.black
            bv.textColor = UIColor.black
            rs.tintColor = UIColor.black
            gs.tintColor = UIColor.black
            bs.tintColor = UIColor.black
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black
            shadow.shadowOffset = CGSize(width: 0, height: 0)
            shadow.shadowBlurRadius = 4.0
            price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
            //price?.addAttribute(NSAttributedStringKey.strokeWidth,value: -5.0,range: NSRange(location:0,length:(price?.mutableString.length)!))
            price?.addAttribute(NSAttributedStringKey.font,value: name.font.withSize(28),range: NSRange(location:0,length:(price?.mutableString.length)!))
        }else{
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
            cperror.textColor = UIColor.white
            rv.textColor = UIColor.white
            gv.textColor = UIColor.white
            bv.textColor = UIColor.white
            rs.tintColor = UIColor.white
            gs.tintColor = UIColor.white
            bs.tintColor = UIColor.white
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowOffset = CGSize(width: 0, height: 0)
            shadow.shadowBlurRadius = 4.0
            price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
            //price?.addAttribute(NSAttributedStringKey.strokeWidth,value: -5.0,range: NSRange(location:0,length:(price?.mutableString.length)!))
            price?.addAttribute(NSAttributedStringKey.font,value: name.font.withSize(28),range: NSRange(location:0,length:(price?.mutableString.length)!))
        }
    }
    @IBAction func smallclick(_ sender: AnyObject) {
        boxchoose = 0
        small.layer.cornerRadius = 10
        small.layer.borderWidth = 5
        big.layer.cornerRadius = 0
        big.layer.borderWidth = 0
        var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0,a:CGFloat = 0
        small.backgroundColor!.getRed(&r, green: &g, blue: &b, alpha: &a)
        rs.value = Float(r * 255)
        gs.value = Float(g * 255)
        bs.value = Float(b * 255)
    }
    @IBAction func bigclick(_ sender: AnyObject) {
        boxchoose = 1
        big.layer.cornerRadius = 10
        big.layer.borderWidth = 5
        small.layer.cornerRadius = 0
        small.layer.borderWidth = 0
        var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0,a:CGFloat = 0
        big.backgroundColor!.getRed(&r, green: &g, blue: &b, alpha: &a)
        rs.value = Float(r * 255)
        gs.value = Float(g * 255)
        bs.value = Float(b * 255)
    }
    @IBAction func leftb(_ sender: AnyObject) {
        if(select == 2){
            select = 1
            lboxview.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            left.isEnabled = false
            left.isHidden = true
            name.text = "Red And Blue"
            if (select == selected){
                buy.setTitle("Selected", for: UIControlState())
                buyb = 3
            }else{
                buy.setTitle("Select", for: UIControlState())
                buyb = 2
            }
        }else if(select == 3){
            select = 2
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)
            buy.isHidden = false
            if (shop2 == 1){
                name.text = "Green And Pink"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Green And Pink\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 4){
            select = 3
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop3 == 1){
                name.text = "Blue And Orange"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Blue And Orange\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 5){
            select = 4
            lboxview.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop4 == 1){
                name.text = "Purple And Green"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Purple And Green\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 6){
            select = 5
            lboxview.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            buy.isHidden = false
            if (shop5 == 1){
                name.text = "Blue And Yellow"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Blue And Yellow\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 7){
            select = 6
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            buy.isHidden = false
            if (shop6 == 1){
                name.text = "Brown And Yellow"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Brown And Yellow\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 8){
            select = 7
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            buy.isHidden = false
            if (shop7 == 1){
                name.text = "Grey And Red"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Grey And Red\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 9){
            select = 8
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            buy.isHidden = false
            if (shop8 == 1){
                name.text = "Light Blue And Pink"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Blue And Pink\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 10){
            select = 9
            lboxview.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            buy.isHidden = false
            if (shop9 == 1){
                name.text = "Light Brown And Light Green"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Brown And Light Green\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 11){
            select = 10
            lboxview.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            buy.isHidden = false
            if (shop10 == 1){
                name.text = "Light Green And Blue"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Green And Blue\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 12){
            select = 11
            lboxview.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            buy.isHidden = false
            if (shop11 == 1){
                name.text = "Olive And Orange"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Olive And Orange\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
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
            rv.isHidden = true
            rs.isHidden = true
            gv.isHidden = true
            gs.isHidden = true
            bv.isHidden = true
            bs.isHidden = true
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            name.font = name.font.withSize(22.5)
                name.setNeedsLayout()
                center.constant = 77
                name.layoutIfNeeded()
            if (shop12 == 1){
                name.text = "Light Pink And Fuschia"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Pink And Fuschia\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 14){
            select = 13
            name.setNeedsLayout()
            center.constant = 0
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            rv.isHidden = true
            rs.isHidden = true
            gv.isHidden = true
            gs.isHidden = true
            bv.isHidden = true
            bs.isHidden = true
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            name.font = name.font.withSize(20.25)
            if (shop13 == 1){
                name.text = "NIGHTMODE\nReplace White With Black"
                buyb = 3
                if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                    buy.setTitle("NIGHTMODE\nOFF", for: UIControlState())
                }else{
                    buy.setTitle("NIGHTMODE\nON", for: UIControlState())
                }
            }else{
                price?.mutableString.setString("500 Coin")
                namec?.mutableString.setString("NIGHTMODE\nReplace White With Black\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
            }
        }else if(select == 15){
            select = 14
            name.setNeedsLayout()
            center.constant = 0
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            rv.isHidden = true
            rs.isHidden = true
            gv.isHidden = true
            gs.isHidden = true
            bv.isHidden = true
            bs.isHidden = true
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            name.font = name.font.withSize(20.25)
            if (shop14 == 3){
                name.text = "X3\nTriple Your Coins"
                buyb = 3
                buy.isHidden = true
            }else if(shop14 == 2){
                price?.mutableString.setString("1000 Coin")
                namec?.mutableString.setString("X3\nTriple Your Coins\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
            }else if(shop14 == 1){
                price?.mutableString.setString("500 Coin")
                namec?.mutableString.setString("X2\nDouble Your Coins\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
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
                rv.isHidden = false
                rs.isHidden = false
                gv.isHidden = false
                gs.isHidden = false
                bv.isHidden = false
                bs.isHidden = false
                small.isHidden = false
                big.isHidden = false
                smallt.isHidden = false
                bigt.isHidden = false
                cp.isHidden = false
                small.backgroundColor = cpsc
                big.backgroundColor = cpbc
                boxchoose = 0
                small.layer.cornerRadius = 10
                small.layer.borderWidth = 5
                big.layer.cornerRadius = 0
                big.layer.borderWidth = 0
                var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0,a:CGFloat = 0
                cpsc.getRed(&r, green: &g, blue: &b, alpha: &a)
                rs.value = Float(r * 255)
                gs.value = Float(g * 255)
                bs.value = Float(b * 255)
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("1000 Coin")
                namec?.mutableString.setString("Color Picker\nChoose Your Own Colors\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
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
                name.text = "Green And Pink"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Green And Pink\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 2){
            select = 3
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop3 == 1){
                name.text = "Blue And Orange"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Blue And Orange\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 3){
            select = 4
            lboxview.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop4 == 1){
                name.text = "Purple And Green"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Purple And Green\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 4){
            select = 5
            lboxview.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            buy.isHidden = false
            if (shop5 == 1){
                    name.text = "Blue And Yellow"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Blue And Yellow\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 5){
            select = 6
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            buy.isHidden = false
            if (shop6 == 1){
                name.text = "Brown And Yellow"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Brown And Yellow\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 6){
            select = 7
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            buy.isHidden = false
            if (shop7 == 1){
                name.text = "Grey And Red"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Grey And Red\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 7){
            select = 8
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            buy.isHidden = false
            if (shop8 == 1){
                name.text = "Light Blue And Pink"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Blue And Pink\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 8){
            select = 9
            lboxview.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            buy.isHidden = false
            if (shop9 == 1){
                name.text = "Light Brown And Light Green"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Brown And Light Green\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 9){
            select = 10
            lboxview.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            buy.isHidden = false
            if (shop10 == 1){
                name.text = "Light Green And Blue"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Green And Blue\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 10){
            select = 11
            lboxview.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            buy.isHidden = false
            if (shop11 == 1){
                name.text = "Olive And Orange"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Olive And Orange\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 11){
            select = 12
            lboxview.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0)
            rboxview.backgroundColor = UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)
            buy.isHidden = false
            if (shop12 == 1){
                name.text = "Light Pink And Fuschia"
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("250 Coin")
                namec?.mutableString.setString("Light Pink And Fuschia\n")
                namec?.append(price!)
                name.attributedText = namec
                buy.setTitle("Buy", for: UIControlState())
                buyb = 1
            }
        }else if(select == 12){
            select = 13
            name.setNeedsLayout()
            center.constant = 0
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            rv.isHidden = true
            rs.isHidden = true
            gv.isHidden = true
            gs.isHidden = true
            bv.isHidden = true
            bs.isHidden = true
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            name.font = name.font.withSize(20.25)
            if (shop13 == 1){
                name.text = "NIGHTMODE\nReplace White With Black"
                buyb = 3
                if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                    buy.setTitle("NIGHTMODE\nOFF", for: UIControlState())
                }else{
                    buy.setTitle("NIGHTMODE\nON", for: UIControlState())
                }
            }else{
                price?.mutableString.setString("500 Coin")
                namec?.mutableString.setString("NIGHTMODE\nReplace White With Black\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
            }
        }
        else if(select == 13){
            select = 14
            name.setNeedsLayout()
            center.constant = 0
            name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = true
            right.isHidden = false
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            rv.isHidden = true
            rs.isHidden = true
            gv.isHidden = true
            gs.isHidden = true
            bv.isHidden = true
            bs.isHidden = true
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            name.font = name.font.withSize(20.25)
            if (shop14 == 3){
                name.text = "X3\nTriple Your Coins"
                buyb = 3
                buy.isHidden = true
            }else if(shop14 == 2){
                price?.mutableString.setString("1000 Coin")
                namec?.mutableString.setString("X3\nTriple Your Coins\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
            }else if(shop14 == 1){
                price?.mutableString.setString("500 Coin")
                namec?.mutableString.setString("X2\nDouble Your Coins\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
            }
        }else if(select == 14){
            select = 15
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.setNeedsLayout()
            center.constant = 0
            name.layoutIfNeeded()
            name.font = name.font.withSize(20.25)
            if (shop15 == 1){
                name.isHidden = true
                rv.isHidden = false
                rs.isHidden = false
                gv.isHidden = false
                gs.isHidden = false
                bv.isHidden = false
                bs.isHidden = false
                small.isHidden = false
                big.isHidden = false
                smallt.isHidden = false
                bigt.isHidden = false
                cp.isHidden = false
                small.backgroundColor = cpsc
                big.backgroundColor = cpbc
                boxchoose = 0
                small.layer.cornerRadius = 10
                small.layer.borderWidth = 5
                big.layer.cornerRadius = 0
                big.layer.borderWidth = 0
                var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0,a:CGFloat = 0
                cpsc.getRed(&r, green: &g, blue: &b, alpha: &a)
                rs.value = Float(r * 255)
                gs.value = Float(g * 255)
                bs.value = Float(b * 255)
                if (select == selected){
                    buy.setTitle("Selected", for: UIControlState())
                    buyb = 3
                }else{
                    buy.setTitle("Select", for: UIControlState())
                    buyb = 2
                }
            }else{
                price?.mutableString.setString("1000 Coin")
                namec?.mutableString.setString("Color Picker\nChoose Your Own Colors\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
            }
        }else if(select == 15){
            select = 16
                name.setNeedsLayout()
                center.constant = 0
                name.layoutIfNeeded()
            name.isHidden = false
            right.isEnabled = false
            right.isHidden = true
            lboxview.isHidden = true
            rboxview.isHidden = true
            buy.isHidden = false
            name.isHidden = false
            rv.isHidden = true
            rs.isHidden = true
            gv.isHidden = true
            gs.isHidden = true
            bv.isHidden = true
            bs.isHidden = true
            small.isHidden = true
            big.isHidden = true
            smallt.isHidden = true
            bigt.isHidden = true
            cp.isHidden = true
            name.font = name.font.withSize(20.25)
            if (shop16 == 1){
                name.text = "Extra Live\nYou Will Now Have 4 Lives"
                buyb = 3
                buy.isHidden = true
            }else{
                price?.mutableString.setString("1000 Coin")
                namec?.mutableString.setString("Extra Live\nYou Will Now Have 4 Lives\n")
                namec?.append(price!)
                name.attributedText = namec
                buyb = 1
                buy.setTitle("Buy", for: UIControlState())
            }
        }
    }
    @IBAction func buyb(_ sender: AnyObject) {
        if(buyc == 0){
            if(buyb == 1){
                if(select == 2){
                    if(coinv >= 250){
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Green And Pink"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop2 = 1
                        provider.setInt(forKey: "shop2", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Blue And Orange"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop3 = 1
                         provider.setInt(forKey: "shop3", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Purple And Green"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop4 = 1
                        provider.setInt(forKey: "shop4", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Blue And Yellow"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop5 = 1
                        provider.setInt(forKey: "shop5", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Brown And Yellow"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop6 = 1
                       provider.setInt(forKey: "shop6", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Grey And Red"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop7 = 1
                         provider.setInt(forKey: "shop7", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Light Blue And Pink"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop8 = 1
                        provider.setInt(forKey: "shop8", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Light Brown And Light Green"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop9 = 1
                         provider.setInt(forKey: "shop9", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                          name.text = "Light Green And Blue"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop10 = 1
                        provider.setInt(forKey: "shop10", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Olive And Orange"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop11 = 1
                      provider.setInt(forKey: "shop11", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("Select", for: UIControlState())
                        name.text = "Light Pink And Fuschia"
                        buyb = 2
                        coinv = coinv - 250
                        coinval.text = String(coinv)
                        shop12 = 1
                      provider.setInt(forKey: "shop12", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        buy.setTitle("NIGHTMODE\nOFF", for: UIControlState())
                        name.text = "NIGHTMODE\nReplace White With Black"
                        buyb = 3
                        coinv = coinv - 500
                        coinval.text = String(coinv)
                        shop13 = 1
                        provider.setInt(forKey: "shop13", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                            name.text = "X3\nTriple Your Coins"
                            buy.isHidden = true
                            buyb = 2
                            coinv = coinv - 1000
                            coinval.text = String(coinv)
                            shop14 = 3
                            provider.setInt(forKey: "shop14", value: 3)
                        }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                            price?.mutableString.setString("1000 Coin")
                            namec?.mutableString.setString("X3\nTriple Your Coins\n")
                            namec?.append(price!)
                            name.attributedText = namec
                            buyb = 1
                            coinv = coinv - 500
                            coinval.text = String(coinv)
                            shop14 = 2
                            provider.setInt(forKey: "shop14", value: 2)
                        }else{
                            buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                        name.isHidden = true
                        rv.isHidden = false
                        rs.isHidden = false
                        gv.isHidden = false
                        gs.isHidden = false
                        bv.isHidden = false
                        bs.isHidden = false
                        small.isHidden = false
                        big.isHidden = false
                        smallt.isHidden = false
                        bigt.isHidden = false
                        cp.isHidden = false
                        buy.setTitle("Select", for: UIControlState())
                        buyb = 2
                        coinv = coinv - 1000
                        coinval.text = String(coinv)
                        shop15 = 1
                        provider.setInt(forKey: "shop15", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                            name.text = "Extra Live\nYou Will Now Have 4 Lives"
                            buy.isHidden = true
                            buyb = 2
                            coinv = coinv - 1000
                            coinval.text = String(coinv)
                            shop16 = 1
                            provider.setInt(forKey: "shop16", value: 1)
                    }else{
                        buy.setTitle("You Don't Have\nEnough Coins", for: UIControlState())
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
                buyb = 3
                if(select == 15){
                    if(color(small.backgroundColor!, isEqualToColor:UIColor.white, withTolerance: 0.2) || color(small.backgroundColor!, isEqualToColor:UIColor.black, withTolerance: 0.2) ||
                        color(small.backgroundColor!, isEqualToColor:big.backgroundColor!, withTolerance: 0.5) ||
                        color(big.backgroundColor!, isEqualToColor:UIColor.white, withTolerance: 0.2)
                        || color(big.backgroundColor!, isEqualToColor:UIColor.black, withTolerance: 0.2)){
                        cperror.isHidden = false
                    }else{
                        print("error")
                        cperror.isHidden = true
                        provider.setString(forKey: "cpsc", value: (small.backgroundColor?.toHexString())!)
                        provider.setString(forKey: "cpbc", value: (big.backgroundColor?.toHexString())!)
                        cpsc = small.backgroundColor!
                        cpbc = big.backgroundColor!
                        provider.setInt(forKey: "shopselect", value: select)
                        selected = select
                        buy.setTitle("Selected", for: UIControlState())
                    }
                }else{
                    provider.setInt(forKey: "shopselect", value: select)
                    selected = select
                    buy.setTitle("Selected", for: UIControlState())
                }
            }else if(select == 13 && shop13 == 1){
                let shadow = NSShadow()
                shadow.shadowOffset = CGSize(width: 0, height: 0)
                shadow.shadowBlurRadius = 4.0
                if (provider.getInt(forKey: "nm", defaultValue: 0) == 0){
                    buy.setTitle("NIGHTMODE\nON", for: UIControlState())
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
                    cperror.textColor = UIColor.white
                    rv.textColor = UIColor.white
                    gv.textColor = UIColor.white
                    bv.textColor = UIColor.white
                    rs.tintColor = UIColor.white
                    gs.tintColor = UIColor.white
                    bs.tintColor = UIColor.white
                    shadow.shadowColor = UIColor.white
                    price?.removeAttribute(NSAttributedStringKey.shadow, range: NSRange(location:0,length:(price?.mutableString.length)!))
                    price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
                }else{
                    buy.setTitle("NIGHTMODE\nOFF", for: UIControlState())
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
                    cperror.textColor = UIColor.black
                    rv.textColor = UIColor.black
                    gv.textColor = UIColor.black
                    bv.textColor = UIColor.black
                    rs.tintColor = UIColor.black
                    gs.tintColor = UIColor.black
                    bs.tintColor = UIColor.black
                    shadow.shadowColor = UIColor.black
                    price?.removeAttribute(NSAttributedStringKey.shadow, range: NSRange(location:0,length:(price?.mutableString.length)!))
                    price?.addAttribute(NSAttributedStringKey.shadow,value: shadow,range: NSRange(location:0,length:(price?.mutableString.length)!))
                }
            }
        }
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
    @IBAction func back(_ sender: AnyObject) {
        buycancel.invalidate()
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func buycanim(){
        buy.setTitle("Buy", for: UIControlState())
        buyc = 0
        if (select != 7){
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
