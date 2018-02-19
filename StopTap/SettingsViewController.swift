//
//  SettingsViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 3/29/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit
import AudioToolbox
class SettingsViewController: UIViewController {
    @IBOutlet weak var sfxslide: UISlider!
    @IBOutlet weak var sfxval: UILabel!
    @IBOutlet weak var musval: UILabel!
    @IBOutlet weak var musslide: UISlider!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var vib: UIButton!
    @IBOutlet weak var settting: UILabel!
    @IBOutlet weak var musict: UILabel!
    @IBOutlet weak var sfxt: UILabel!
    @IBOutlet weak var langb: UIButton!
    var lang:Int = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "lang", defaultValue: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.applicationWillResignActiveNotification), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        back.layer.cornerRadius = 10
        back.layer.borderWidth = 5
        vib.isExclusiveTouch = true
        back.isExclusiveTouch = true
        langb.isExclusiveTouch = true
        if(UIDevice.current.userInterfaceIdiom == .phone){
            vib.isHidden = false
            vib.isEnabled = true
        }else{
            vib.isHidden = true
            vib.isEnabled = false
        }
        if (provider.getInt(forKey: "vib", defaultValue: 1) == 0){
            vib.tintColor = UIColor.init(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        }else{
            vib.tintColor = UIColor.red
        }
        musval.text = String(provider.getInt(forKey: "musicval", defaultValue: 10))
        sfxval.text = String(provider.getInt(forKey: "sfxval", defaultValue: 10))
        musslide.value = Float(provider.getInt(forKey: "musicval", defaultValue: 10))
        sfxslide.value = Float(provider.getInt(forKey: "sfxval", defaultValue: 10))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        lang = KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "lang", defaultValue: 1)
        switch (provider.getInt(forKey: "lang", defaultValue: 1)) {
        case 0:
            settting.text = "الإعدادات"
            musict.text = "الموسيقى"
            sfxt.text = "الأصوات"
            musval.arabic(size: 17, diffinsize: 0)
            sfxval.arabic(size: 17, diffinsize: 0)
            musict.arabic(size: 18, diffinsize: 8)
            sfxt.arabic(size: 18, diffinsize: 8)
            settting.arabic(size: 26, diffinsize: 14)
            back.setTitle("عودة", for: UIControlState())
            back.arabic(size: 20, diffinsize: 10)
            musval.text = convertEngNumToPersianNum(num: musval.text!)
            sfxval.text = convertEngNumToPersianNum(num: sfxval.text!)
            break
        case 1:
            settting.text = "Settings"
            musict.text = "Music"
            sfxt.text = "SFX"
            musval.english(size: 17, diffinsize: 7)
            sfxval.english(size: 17, diffinsize: 7)
            musict.english(size: 18, diffinsize: 8)
            sfxt.english(size: 18, diffinsize: 8)
            settting.english(size: 26, diffinsize: 14)
            back.setTitle("Back", for: UIControlState())
            back.english(size: 20, diffinsize: 10,left: 4,top: 3)
            musval.text = convertartoeng(num: musval.text!)
            sfxval.text = convertartoeng(num: sfxval.text!)
            break
        default:
            settting.text = "Settings"
            musict.text = "Music"
            sfxt.text = "SFX"
            musval.english(size: 17, diffinsize: 0)
            sfxval.english(size: 17, diffinsize: 0)
            musict.english(size: 18, diffinsize: 8)
            sfxt.english(size: 18, diffinsize: 8)
            settting.english(size: 26, diffinsize: 14)
            back.setTitle("Back", for: UIControlState())
            back.english(size: 20, diffinsize: 10,left: 4,top: 3)
            musval.text = convertartoeng(num: musval.text!)
            sfxval.text = convertartoeng(num: sfxval.text!)
            break
        }
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            back.layer.borderColor = UIColor.black.cgColor
            back.setTitleColor(UIColor.black, for: UIControlState())
            sfxval.textColor = UIColor.black
            musval.textColor = UIColor.black
            settting.textColor = UIColor.black
            musict.textColor = UIColor.black
            sfxt.textColor = UIColor.black
            musslide.tintColor = UIColor.black
            sfxslide.tintColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.black
            back.layer.borderColor = UIColor.white.cgColor
            back.setTitleColor(UIColor.white, for: UIControlState())
            sfxval.textColor = UIColor.white
            musval.textColor = UIColor.white
            settting.textColor = UIColor.white
            musict.textColor = UIColor.white
            sfxt.textColor = UIColor.white
            musslide.tintColor = UIColor.white
            sfxslide.tintColor = UIColor.white
        }
            }
    @IBAction func vibb(_ sender: AnyObject) {
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if (provider.getInt(forKey: "vib", defaultValue: 1) == 1){
            provider.setInt(forKey: "vib", value: 0)
            vib.tintColor = UIColor.init(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        }else{
            AudioServicesPlaySystemSound(1519);
            provider.setInt(forKey: "vib", value: 1)
            vib.tintColor = UIColor.red
        }
    }
    @IBAction func backb(_ sender: AnyObject) {
        //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        provider.setInt(forKey: "musicval", value: Int(musslide.value))
        provider.setInt(forKey: "sfxval", value: Int(sfxslide.value))
        NotificationCenter.default.removeObserver(self)
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func musc(_ sender: AnyObject) {
        switch (lang){
        case 0:
            musval.text = convertEngNumToPersianNum(num: String(Int(musslide.value)))
            break;
        case 1:
            musval.text = String(Int(musslide.value))
            break;
        default:
            musval.text = String(Int(musslide.value))
            break;
        }
    }
    @IBAction func sfxc(_ sender: AnyObject) {
        switch (lang){
        case 0:
            sfxval.text = convertEngNumToPersianNum(num: String(Int(sfxslide.value)))
            break;
        case 1:
            sfxval.text = String(Int(sfxslide.value))
            break;
        default:
            sfxval.text = String(Int(sfxslide.value))
            break;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func applicationWillResignActiveNotification() {
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        provider.setInt(forKey: "musicval", value: Int(musslide.value))
        provider.setInt(forKey: "sfxval", value: Int(sfxslide.value))
    }
    @IBAction func langtouch(_ sender: Any) {
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if(provider.getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        provider.setInt(forKey: "musicval", value: Int(musslide.value))
        provider.setInt(forKey: "sfxval", value: Int(sfxslide.value))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
    }
    func convertEngNumToPersianNum(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "ar_JO")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        return faNumber!
    }
    func convertartoeng(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "en")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        return faNumber!
    }
    
}
