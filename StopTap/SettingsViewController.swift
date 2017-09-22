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
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.applicationWillResignActiveNotification), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        back.layer.cornerRadius = 10
        back.layer.borderWidth = 5
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
            provider.setInt(forKey: "vib", value: 1)
            vib.tintColor = UIColor.red
        }
    }
    @IBAction func backb(_ sender: AnyObject) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
          let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        provider.setInt(forKey: "musicval", value: Int(musslide.value))
        provider.setInt(forKey: "sfxval", value: Int(sfxslide.value))
        NotificationCenter.default.removeObserver(self)
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func musc(_ sender: AnyObject) {
        musval.text = String(Int(musslide.value))
    }
    @IBAction func sfxc(_ sender: AnyObject) {
        sfxval.text = String(Int(sfxslide.value))
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
