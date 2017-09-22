//
//  SignViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 5/29/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit

class SignViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var signw: UILabel!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var sign: UIButton!
    @IBOutlet weak var sigaimage: UIImageView!
    @IBOutlet weak var siga: UIButton!
    @IBOutlet weak var usertext: UITextField!
    @IBOutlet weak var passtext: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(KeychainWrapper.stringForKey("nm") == "0"){
            self.view.backgroundColor = UIColor.white
            sign.layer.borderColor = UIColor.black.cgColor
            back.layer.borderColor = UIColor.black.cgColor
            siga.layer.borderColor = UIColor.black.cgColor
            passtext.layer.borderColor = UIColor.black.cgColor
            usertext.layer.borderColor = UIColor.black.cgColor
            siga.setTitleColor(UIColor.black, for: UIControlState())
            back.setTitleColor(UIColor.black, for: UIControlState())
            sign.setTitleColor(UIColor.black, for: UIControlState())
            signw.textColor = UIColor.black
            passtext.textColor = UIColor.black
            usertext.textColor = UIColor.black
            usertext.backgroundColor = UIColor.white
            passtext.backgroundColor = UIColor.white
            usertext.tintColor = UIColor.gray
            passtext.tintColor = UIColor.gray
            passtext.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.black])
            usertext.attributedPlaceholder = NSAttributedString(string:"User Name",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.black])
        }else{
            self.view.backgroundColor = UIColor.black
            sign.layer.borderColor = UIColor.white.cgColor
            back.layer.borderColor = UIColor.white.cgColor
            siga.layer.borderColor = UIColor.white.cgColor
            passtext.layer.borderColor = UIColor.white.cgColor
            usertext.layer.borderColor = UIColor.white.cgColor
            siga.setTitleColor(UIColor.white, for: UIControlState())
            back.setTitleColor(UIColor.white, for: UIControlState())
            sign.setTitleColor(UIColor.white, for: UIControlState())
            signw.textColor = UIColor.white
            passtext.textColor = UIColor.white
            usertext.textColor = UIColor.white
            usertext.backgroundColor = UIColor.black
            passtext.backgroundColor = UIColor.black
            usertext.tintColor = UIColor.gray
            passtext.tintColor = UIColor.gray
            passtext.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
            usertext.attributedPlaceholder = NSAttributedString(string:"User Name",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        etextb(usertext)
        etextb(passtext)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passtext.delegate = self
        usertext.delegate = self
        siga.layer.cornerRadius = 10
        siga.layer.borderWidth = 5
        sign.layer.cornerRadius = 10
        sign.layer.borderWidth = 5
        back.layer.cornerRadius = 10
        back.layer.borderWidth = 5
        if (KeychainWrapper.stringForKey("sign") == nil){
            KeychainWrapper.setString("0", forKey: "sign")
            sigaimage.image = UIImage(named: "presence_invisible")
        }else{
            if(KeychainWrapper.stringForKey("sign") == "1"){
                sigaimage.image = UIImage(named: "presence_online")
            }else{
                sigaimage.image = UIImage(named: "presence_invisible")
            }
        }
    }
    @IBAction func sigac(_ sender: AnyObject) {
        if(KeychainWrapper.stringForKey("sign") == "0"){
            KeychainWrapper.setString("1", forKey: "sign")
            sigaimage.image = UIImage(named: "presence_online")
        }else{
            KeychainWrapper.setString("0", forKey: "sign")
            sigaimage.image = UIImage(named: "presence_invisible")
        }
    }
    
    @IBAction func backb(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 8
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func textFieldShouldReturn(_ theTextField: UITextField) -> Bool {
        if theTextField == self.passtext {
            theTextField.resignFirstResponder()
        }
        else if theTextField == self.usertext {
            self.passtext.becomeFirstResponder()
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textAlignment = NSTextAlignment.center
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signib(_ sender: AnyObject) {
        usertext.isEnabled = false
        passtext.isEnabled = false
        sign.isEnabled = false
        sign.isHidden = true
        App42API.initialize(withAPIKey: "38ae8af214d06b5aadd7064f31bb329c0f80088b69aa25620407cae9a296612e", andSecretKey: "69d230877fded2ac9dd47e3d71daa8e601f00fe8d34a6f4d7e8279c93a6a93e1")
        App42API.enableApp42Trace(true)
        App42API.setOfflineStorage(false)
        let userName = usertext.text
        let pwd = passtext.text
        let userService = App42API.buildUserService() as? UserService
        userService?.authenticateUser(userName, password:pwd, completionBlock: { (success, response, exception) -> Void in
            if(success)
            {
                let dbName = "SHOPCOIN"
                let collectionName = "wajdi"
                let key = "username"
                let value = userName
                App42API.setOfflineStorage(false)
                let storageService = App42API.buildStorageService() as? StorageService
                storageService?.findDocument(byKeyValue: dbName, collectionName: collectionName, key:key, value:value, completionBlock: { (success, response, exception) -> Void in
                    if(success)
                    {
                        let storage = response as! Storage
                       NSLog("dbName is : %@", storage.dbName)
                        NSLog("collectionName is : %@", storage.collectionName)
                        let jsonDocList = storage.jsonDocArray
                        print("signed in")
                       /* for jsonDoc in jsonDocList! {
                            let data=(jsonDoc as AnyObject).jsonDoc!.data(using: String.Encoding.utf8)
                            do {
                              let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                                self.signw.isHidden = false
                                self.signw.text = "Signed In"
                                self.siga.isEnabled = true
                                self.siga.isHidden = false
                                self.sigaimage.isHidden = false
                                ViewController.vars.signedin = 1
                                ViewController.vars.hscore = String(describing: jsonobj.object(forKey: "hscore")!)
                                KeychainWrapper.setString(userName!, forKey: "usern")
                            } catch {
                            }
                        }*/
                    }
                    else  
                    {
                     if(exception?.appErrorCode == 2601){
                            let jsonDictionary = NSDictionary(objects:[userName!,"0",3], forKeys:["username" as NSCopying,"hscore" as NSCopying,"age" as NSCopying])
                        do {
                            
                            let jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
                            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
                            print(json)
                            /*let storageService = App42API.buildStorageService() as? StorageService
                            storageService?.insertJSONDocument(dbName, collectionName: collectionName,json:json, completionBlock: { (success, response, exception) -> Void in
                                if(success)
                                {
                                    self.signw.isHidden = false
                                    self.signw.text = "Signed In"
                                    self.siga.isEnabled = true
                                    self.siga.isHidden = false
                                    self.sigaimage.isHidden = false
                                    ViewController.vars.signedin = 1
                                    KeychainWrapper.setString(userName!, forKey: "usern")
                                }
                                else
                                {
                                    self.usertext.isEnabled = true
                                    self.passtext.isEnabled = true
                                    self.sign.isEnabled = true
                                    self.sign.isHidden = false
                                    self.signw.isHidden = false
                                    self.signw.text = exception?.reason
                                }
                            })*/
                        } catch {
                        }
                        }else{
                            self.usertext.isEnabled = true
                            self.passtext.isEnabled = true
                            self.sign.isEnabled = true
                            self.sign.isHidden = false
                            self.signw.isHidden = false
                            self.signw.text = exception?.reason
                        }
                    }  
                })
            }
            else
            {
                self.usertext.isEnabled = true
                self.passtext.isEnabled = true
                self.sign.isEnabled = true
                self.sign.isHidden = false
                self.signw.isHidden = false
                if(exception?.appErrorCode == 2000){
                    self.signw.text = "User Does Not Exist Sign In Failed"
                }else if(exception?.appErrorCode == 2002){
                    self.signw.text = "User Name/Password Did Not Match Sign In Failed"
                }else{
                    if((exception?.reason?.contains("resolve host")) != nil){
                        self.signw.text = "Please Connect To Internet Or Try Again Later Sign In Failed"
                    }else{
                        self.signw.text = exception?.reason
                    }
                }
            }
        })
    }
    func etextb(_ textb:UITextField){
        let border = CALayer()
        let width = CGFloat(2.0)
        if(KeychainWrapper.stringForKey("nm") == "0"){
            border.borderColor = UIColor.black.cgColor
        }else{
            border.borderColor = UIColor.white.cgColor
        }
        border.frame = CGRect(x: 0, y: textb.frame.size.height - width, width:  textb.frame.size.width, height: textb.frame.size.height)
        border.borderWidth = width
        textb.layer.addSublayer(border)
        textb.layer.masksToBounds = true
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
