//
//  CreateAccViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 6/5/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit

class CreateAccViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var createb: UIButton!
    @IBOutlet weak var emailt: UITextField!
    @IBOutlet weak var passt: UITextField!
    @IBOutlet weak var usert: UITextField!
    @IBOutlet weak var createw: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        usert.delegate = self
        passt.delegate = self
        emailt.delegate = self
        menu.layer.cornerRadius = 10
        menu.layer.borderWidth = 5
        createb.layer.cornerRadius = 10
        createb.layer.borderWidth = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createab(_ sender: AnyObject) {
        createb.isEnabled = false
        createb.isHidden = true
        usert.isEnabled = false
        passt.isEnabled = false
        emailt.isEnabled = false
        let userName = usert.text
        let password = passt.text
        let emailAddress = emailt.text
            App42API.initialize(withAPIKey: "38ae8af214d06b5aadd7064f31bb329c0f80088b69aa25620407cae9a296612e", andSecretKey: "69d230877fded2ac9dd47e3d71daa8e601f00fe8d34a6f4d7e8279c93a6a93e1")
        let userService = App42API.buildUserService() as? UserService
        userService?.createUser(userName, password: password, emailAddress:emailAddress, completionBlock: { (success, response, exception) -> Void in
            if(success)
            {
                let user = response as! User
                NSLog("%@", user.userName)
                NSLog("%@", user.email)
                NSLog("%@", user.sessionId)
                self.createw.isHidden = false
                self.createw.text = "Account Created"
            }
            else
            {
                self.usert.isEnabled = true
                self.passt.isEnabled = true
                self.emailt.isEnabled = true
                self.createb.isEnabled = true
                self.createb.isHidden = false
                self.createw.isHidden = false
                if(exception?.appErrorCode == 2001){
                    self.createw.text = "User Already Exists Can't Create Account"
                }else if(exception?.appErrorCode == 2005){
                    self.createw.text = "Email Already Exists Can't Create Account"
                }else{
                    if((exception?.reason?.contains("resolve host")) != nil){
                        self.createw.text = "Please Connect To Internet Or Try Again Later Can't Create Account"
                    }else{
                        self.createw.text = exception?.reason
                    }
                }
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(KeychainWrapper.stringForKey("nm") == "0"){
            self.view.backgroundColor = UIColor.white
            menu.layer.borderColor = UIColor.black.cgColor
            createb.layer.borderColor = UIColor.black.cgColor
            usert.layer.borderColor = UIColor.black.cgColor
            passt.layer.borderColor = UIColor.black.cgColor
            emailt.layer.borderColor = UIColor.black.cgColor
            menu.setTitleColor(UIColor.black, for: UIControlState())
            createb.setTitleColor(UIColor.black, for: UIControlState())
            createw.textColor = UIColor.black
            usert.textColor = UIColor.black
            passt.textColor = UIColor.black
            emailt.textColor = UIColor.black
            usert.backgroundColor = UIColor.white
            passt.backgroundColor = UIColor.white
            emailt.backgroundColor = UIColor.white
            usert.tintColor = UIColor.gray
            passt.tintColor = UIColor.gray
            emailt.tintColor = UIColor.gray
            passt.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.black])
            usert.attributedPlaceholder = NSAttributedString(string:"User Name",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.black])
            emailt.attributedPlaceholder = NSAttributedString(string:"EMAIL",
                                                             attributes:[NSAttributedStringKey.foregroundColor: UIColor.black])
        }else{
            self.view.backgroundColor = UIColor.black
            menu.layer.borderColor = UIColor.white.cgColor
            createb.layer.borderColor = UIColor.white.cgColor
            usert.layer.borderColor = UIColor.white.cgColor
            passt.layer.borderColor = UIColor.white.cgColor
            emailt.layer.borderColor = UIColor.white.cgColor
            menu.setTitleColor(UIColor.white, for: UIControlState())
            createb.setTitleColor(UIColor.white, for: UIControlState())
            createw.textColor = UIColor.white
            usert.textColor = UIColor.white
            passt.textColor = UIColor.white
            emailt.textColor = UIColor.white
            usert.backgroundColor = UIColor.black
            passt.backgroundColor = UIColor.black
            emailt.backgroundColor = UIColor.black
            usert.tintColor = UIColor.gray
            passt.tintColor = UIColor.gray
            emailt.tintColor = UIColor.gray
            usert.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
            passt.attributedPlaceholder = NSAttributedString(string:"User Name",
                                                                attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
            emailt.attributedPlaceholder = NSAttributedString(string:"EMAIL",
                                                             attributes:[NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        etextb(usert)
        etextb(passt)
        etextb(emailt)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.characters.count + string.characters.count - range.length
        if textField == self.usert {
            return newLength <= 8 // Bool
        } else if textField == self.passt {
            return newLength <= 8 // Bool
        }
        return true
    }
    @IBAction func backb(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textAlignment = NSTextAlignment.center
    }
    func textFieldShouldReturn(_ theTextField: UITextField) -> Bool {
        if theTextField == self.emailt {
            theTextField.resignFirstResponder()
        }else if theTextField == self.passt {
            self.emailt.becomeFirstResponder()
        }
        else if theTextField == self.usert {
            self.passt.becomeFirstResponder()
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
