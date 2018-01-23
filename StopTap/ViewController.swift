//
//  ViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 3/19/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//
import CoreMotion
import UIKit
class ViewController: UIViewController,UICollisionBehaviorDelegate,UINavigationControllerDelegate{
    let bganim1:UIImageView = UIImageView()
    let bganim2:UIImageView = UIImageView()
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var account: UIButton!
    @IBOutlet weak var shop: UIButton!
    @IBOutlet weak var htp: UIButton!
    @IBOutlet weak var highsc: UILabel!
    @IBOutlet weak var val: UILabel!
    @IBOutlet weak var gname: UILabel!
    let motionManager = CMMotionManager()
    var animator:UIDynamicAnimator? = nil;
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    let itemBehavior = UIDynamicItemBehavior()
    var checkgravity = 0
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         gname.center.y = ((play.center.y - play.frame.height / 2.0) / 2.0)
        //gnamet.constant = ((play.frame.origin.y / 2.0) - (gname.frame.height))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bganim1.frame.origin.x = self.view.frame.width - (self.bganim1.frame.width + 1)
        bganim1.frame.origin.y = 1
        bganim2.frame.origin.x = 1
        bganim2.frame.origin.y = 1
        gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
        gravity.addItem(bganim1)
        collider.addItem(bganim1)
        itemBehavior.addItem(bganim1)
        gravity.addItem(bganim2)
        collider.addItem(bganim2)
        itemBehavior.addItem(bganim2)
        play.isExclusiveTouch = true
        account.isExclusiveTouch = true
        shop.isExclusiveTouch = true
        htp.isExclusiveTouch = true
        /*if(vars.signedin == 1){
            if(vars.hscore == "0"){
                self.highsc.isHidden = true
                self.val.isHidden = true
            }else{
                self.val.text = vars.hscore
                self.highsc.isHidden = false
                self.val.isHidden = false
            }
        }else{
            if (KeychainWrapper.stringForKey("hscore") == nil){
                self.highsc.isHidden = true
                self.val.isHidden = true
            }else{
                self.val.text = KeychainWrapper.stringForKey("hscore")
                self.highsc.isHidden = false
                self.val.isHidden = false
            }
        } */
        //
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.viewrisign), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if (provider.exists(forKey: "hscore") == false){
            self.highsc.isHidden = true
            self.val.isHidden = true
        }else{
            self.val.text = String(provider.getInt(forKey: "hscore"))
            self.highsc.isHidden = false
            self.val.isHidden = false
        }
        self.gname.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 12))
        gname.setNeedsLayout()
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [.repeat,.autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.gname.transform = self.gname.transform.rotated(by:  -1 * (CGFloat.pi / 12)).scaledBy(x: 1.5, y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.5, animations: {
                self.gname.transform = self.gname.transform.rotated(by:  -1 * (CGFloat.pi / 12)).scaledBy(x: 2/3, y: 2/3)
            })
        }, completion: nil)
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 1){
            self.view.backgroundColor = UIColor.black
            play.layer.borderColor = UIColor.white.cgColor
            htp.layer.borderColor = UIColor.white.cgColor
            shop.layer.borderColor = UIColor.white.cgColor
            account.layer.borderColor = UIColor.white.cgColor
            bganim1.layer.borderColor = UIColor.white.cgColor
            bganim2.layer.borderColor = UIColor.white.cgColor
            play.backgroundColor = UIColor.black
            htp.backgroundColor = UIColor.black
            shop.backgroundColor = UIColor.black
            account.backgroundColor = UIColor.black
            play.setTitleColor(UIColor.white, for: UIControlState())
            htp.setTitleColor(UIColor.white, for: UIControlState())
            shop.setTitleColor(UIColor.white, for: UIControlState())
            account.setTitleColor(UIColor.white, for: UIControlState())
            highsc.textColor = UIColor.white
            val.textColor = UIColor.white
            gname.textColor = UIColor.white
        }else{
            self.view.backgroundColor = UIColor.white
            play.layer.borderColor = UIColor.black.cgColor
            htp.layer.borderColor = UIColor.black.cgColor
            shop.layer.borderColor = UIColor.black.cgColor
            account.layer.borderColor = UIColor.black.cgColor
            bganim1.layer.borderColor = UIColor.black.cgColor
            bganim2.layer.borderColor = UIColor.black.cgColor
            play.backgroundColor = UIColor.white
            htp.backgroundColor = UIColor.white
            shop.backgroundColor = UIColor.white
            account.backgroundColor = UIColor.white
            play.setTitleColor(UIColor.black, for: UIControlState())
            htp.setTitleColor(UIColor.black, for: UIControlState())
            shop.setTitleColor(UIColor.black, for: UIControlState())
            account.setTitleColor(UIColor.black, for: UIControlState())
            highsc.textColor = UIColor.black
            val.textColor = UIColor.black
            gname.textColor = UIColor.black
        }
        switch provider.getInt(forKey: "shopselect", defaultValue: 1) {
        case 1:
            bganim1.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            break;
        case 2:
            bganim1.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.45, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.14, green: 1.0, blue: 0.0, alpha: 1.0)
            break;
        case 3:
            bganim1.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.0, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.015, green: 0.0, blue: 1.0, alpha: 1.0)
            break;
        case 4:
            bganim1.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.086, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.58, green: 0.0, blue: 1.0, alpha: 1.0)
            break;
        case 5:
            bganim1.backgroundColor = UIColor(red: 0.87, green: 0.99, blue: 0.0, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.0, green: 0.57, blue: 0.99, alpha: 1.0)
            break;
        case 6:
            bganim1.backgroundColor = UIColor(red: 1.0, green: 0.94, blue: 0.0, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.34, green: 0.17, blue: 0.17, alpha: 1.0)
            break;
        case 7:
            bganim1.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
            break;
        case 8:
            bganim1.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.07, green: 0.73, blue: 0.76, alpha: 1.0)
            break;
        case 9:
            bganim1.backgroundColor = UIColor(red: 0.55, green: 1.0, blue: 0.54, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.9, green: 0.7, blue: 0.64, alpha: 1.0)
            break;
        case 10:
            bganim1.backgroundColor = UIColor(red: 0.25, green: 0.074, blue: 0.94, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.09, green: 0.92, blue: 0.57, alpha: 1.0)
            break;
        case 11:
            bganim1.backgroundColor = UIColor(red: 0.84, green: 0.38, blue: 0.17, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 0.23, green: 0.27, blue: 0.047, alpha: 1.0)
            break;
        case 12:
            bganim1.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.39, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 1.0, green: 0.54, blue: 1.0, alpha: 1.0)
            break;
        case 15:
            bganim1.backgroundColor = UIColor(hexString: provider.getString(forKey: "cpsc", defaultValue: "#004cff"))
            bganim2.backgroundColor = UIColor(hexString:  provider.getString(forKey: "cpbc", defaultValue: "#ff0000"))
            break;
        default:
            bganim1.backgroundColor = UIColor(red: 0.0, green: 0.29, blue: 1.0, alpha: 1.0)
            bganim2.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            break;
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        checkgravity = 0
        motionManager.stopDeviceMotionUpdates()
        gravity.removeItem(bganim1)
        gravity.removeItem(bganim2)
        itemBehavior.removeItem(bganim1)
        itemBehavior.removeItem(bganim2)
        collider.removeItem(bganim1)
        collider.removeItem(bganim2)
        self.gname.layer.removeAllAnimations()
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if (provider.exists(forKey: "nm") == false){
            provider.setInt(forKey: "nm", value: 0)
        }
        if (provider.exists(forKey: "lang") == false){
            provider.setInt(forKey: "lang", value: 1)
        }
        if (provider.exists(forKey: "musicval") == false){
            provider.setInt(forKey: "musicval", value: 10)
        }
        if (provider.exists(forKey: "sfxval") == false){
            provider.setInt(forKey: "sfxval", value: 10)
        }
        if (provider.exists(forKey: "vib") == false){
             provider.setInt(forKey: "vib", value: 1)
        }
        if (provider.exists(forKey: "shopselect") == false){
            provider.setInt(forKey: "shopselect", value: 1)
        }
        if (provider.exists(forKey: "shop2") == false){
            provider.setInt(forKey: "shop2", value: 0)
        }
        if (provider.exists(forKey: "shop3") == false){
            provider.setInt(forKey: "shop3", value: 0)
        }
        if (provider.exists(forKey: "shop4") == false){
            provider.setInt(forKey: "shop4", value: 0)
        }
        if (provider.exists(forKey: "shop5") == false){
            provider.setInt(forKey: "shop5", value: 0)
        }
        if (provider.exists(forKey: "shop6") == false){
            provider.setInt(forKey: "shop6", value: 0)
        }
        if (provider.exists(forKey: "shop7") == false){
            provider.setInt(forKey: "shop7", value: 0)
        }
        if (provider.exists(forKey: "shop8") == false){
            provider.setInt(forKey: "shop8", value: 0)
        }
        if (provider.exists(forKey: "shop9") == false){
            provider.setInt(forKey: "shop9", value: 0)
        }
        if (provider.exists(forKey: "shop10") == false){
            provider.setInt(forKey: "shop10", value: 0)
        }
        if (provider.exists(forKey: "shop11") == false){
            provider.setInt(forKey: "shop11", value: 0)
        }
        if (provider.exists(forKey: "shop12") == false){
            provider.setInt(forKey: "shop12", value: 0)
        }
        if (provider.exists(forKey: "shop13") == false){
            provider.setInt(forKey: "shop13", value: 0)
        }
        if (provider.exists(forKey: "shop14") == false){
            provider.setInt(forKey: "shop14", value: 1)
        }
        if (provider.exists(forKey: "shop15") == false){
            provider.setInt(forKey: "shop15", value: 0)
        }
        if (provider.exists(forKey: "shop16") == false){
            provider.setInt(forKey: "shop16", value: 0)
        }
        if (provider.exists(forKey: "cpsc") == false){
            provider.setString(forKey: "cpsc", value: "#004cff")
        }
        if (provider.exists(forKey: "cpbc") == false){
            provider.setString(forKey: "cpbc", value: "#ff0000")
        }
        if (provider.exists(forKey: "cv") == false){
            provider.setInt(forKey: "cv", value: 0)
        }
        navigationController?.delegate = self
         collider.collisionDelegate = self
        //ios 8 animation pop
        //add achievements
        /*var toastnmon = ToastStyle()
        toastnmon.backgroundColor = UIColor.white
        toastnmon.messageColor = UIColor.black
        var toastnmoff = ToastStyle()
        toastnmoff.backgroundColor = UIColor.black
        toastnmoff.messageColor = UIColor.white */

     /*   if(vars.signedin == 1){
            App42API.setOfflineStorage(true)
            App42API.initialize(withAPIKey: "38ae8af214d06b5aadd7064f31bb329c0f80088b69aa25620407cae9a296612e", andSecretKey: "69d230877fded2ac9dd47e3d71daa8e601f00fe8d34a6f4d7e8279c93a6a93e1")
            App42CacheManager.shared().setPolicy(APP42_NETWORK_FIRST)
            let dbName = "SHOPCOIN"
            let collectionName = "wajdi"
            let key = "username"
            let value = KeychainWrapper.stringForKey("usern")
            let storageService = App42API.buildStorageService() as? StorageService
            storageService?.findDocument(byKeyValue: dbName, collectionName: collectionName, key:key, value:value, completionBlock: { (success, response, exception) -> Void in
                if(success)
                {
                    let storage = response as! Storage
                    let jsonDocList = storage.jsonDocArray
                    for jsonDoc in jsonDocList! {
                        let data=(jsonDoc as AnyObject).jsonDoc!.data(using: String.Encoding.utf8)
                        do {
                            let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                            let scoreBoardService = App42API.buildScoreBoardService() as? ScoreBoardService
                            scoreBoardService?.getHighestScore(byUser: "StopTap", gameUserName:value, completionBlock: { (success, response, exception) -> Void in
                                if(success)
                                {
                                    let game = response as! Game
                                    let scoreList = game.scoreList
                                    for score in scoreList!
                                    {
                                        let scoreValue = (score as AnyObject).value as Double
                                        ViewController.vars.hscore = String(Int(scoreValue))
                                        vars.signedin = 1
                                        if(vars.hscore == "0"){
                                            self.highsc.isHidden = true
                                            self.val.isHidden = true
                                        }else{
                                            self.val.text = vars.hscore
                                            self.highsc.isHidden = false
                                            self.val.isHidden = false
                                        }
                                        if(KeychainWrapper.stringForKey("nm") == "1"){
                                            switch UIDevice.current.userInterfaceIdiom {
                                            case .phone:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomiphone, style: toastnmon)
                                                break
                                            case .pad:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomipad, style: toastnmon)
                                                break
                                            case .unspecified:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomiphone, style: toastnmon)
                                                break
                                            default:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomiphone, style: toastnmon)
                                                break
                                            }
                                        }else{
                                            switch UIDevice.current.userInterfaceIdiom {
                                            case .phone:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomiphone, style: toastnmoff)
                                                break
                                            case .pad:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomipad, style: toastnmoff)
                                                break
                                            case .unspecified:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomiphone, style: toastnmoff)
                                                break
                                            default:
                                                self.view.makeToast("Signed In", duration: 3.0, position: .bottomiphone, style: toastnmoff)
                                                break
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                }
                            })
                        } catch {
                        }
                    }
                }else{
                    vars.signedin = 0
                    if (KeychainWrapper.stringForKey("hscore") == nil){
                        self.highsc.isHidden = true
                        self.val.isHidden = true
                    }else{
                        self.val.text = KeychainWrapper.stringForKey("hscore")
                        self.highsc.isHidden = false
                        self.val.isHidden = false
                    }
                }
            })
            
        }else{

        }*/
        //remember excluded files later
        //fix foreground on play viewvontroller as soon as someone enters
        //fix pause dtection if it was on
        bganim1.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        bganim1.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        bganim2.layer.cornerRadius = ((5 * self.view.bounds.width) / 411)
        bganim2.layer.borderWidth = ((2.5 * self.view.bounds.width) / 411)
        if (provider.exists(forKey: "hscore") == false){
            highsc.isHidden = true
            val.isHidden = true
        }else{
            val.text = provider.getString(forKey: "hscore", defaultValue: "0")
            highsc.isHidden = false
            val.isHidden = false
        }
        createAnimatorStuff()
        bganim1.frame.size.height = ((40 * self.view.bounds.width) / 411)
        bganim1.frame.size.width = ((40 * self.view.bounds.width) / 411)
        bganim1.backgroundColor = UIColor.black
        self.view.insertSubview(bganim1, at: 0)
        bganim2.frame.size.height = ((40 * self.view.bounds.width) / 411)
        bganim2.frame.size.width = ((40 * self.view.bounds.width) / 411)
        bganim2.backgroundColor = UIColor.red
        self.view.insertSubview(bganim2, at: 1)
        play.layer.cornerRadius = 10
        play.layer.borderWidth = 5
        htp.layer.cornerRadius = 10
        htp.layer.borderWidth = 5
        shop.layer.cornerRadius = 10
        shop.layer.borderWidth = 5
        account.layer.cornerRadius = 10
        account.layer.borderWidth = 5
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //randdirbganim()
       // motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: gravityUpdated as! CMDeviceMotionHandler)
        if(animator?.behaviors.contains(collider) == false){
        animator?.removeBehavior(collider)
        }
        motionManager.deviceMotionUpdateInterval = 0.2
        collider.translatesReferenceBoundsIntoBoundary = true
            collider.addBoundary(withIdentifier: "bottom" as NSCopying, from: CGPoint(x: 0, y: self.view.safeAreaLayoutGuide.layoutFrame.maxY+1), to: CGPoint(x: self.view.frame.maxX, y: self.view.safeAreaLayoutGuide.layoutFrame.maxY+1))
        animator?.addBehavior(collider)
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if(operation == UINavigationControllerOperation.push){
            return pushanimation() as UIViewControllerAnimatedTransitioning
        }else if(operation == UINavigationControllerOperation.pop){
            return popanimation() as UIViewControllerAnimatedTransitioning
        }
        return nil
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if(checkgravity == 0){
            checkgravity = 1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
                (deviceMotion, error) -> Void in
                let grav : CMAcceleration = deviceMotion!.gravity;
                
                let x = CGFloat(grav.x);
                let y = CGFloat(grav.y);
                var p = CGPoint(x: x, y: y)
                if (error != nil) {
                    print(error ?? "")
                }
                
                // Have to correct for orientation.
                let orientation = UIApplication.shared.statusBarOrientation;
                
                if(orientation == UIInterfaceOrientation.landscapeLeft) {
                    let t = p.x
                    p.x = p.y
                    p.y = 0 - t
                } else if (orientation == UIInterfaceOrientation.landscapeRight) {
                    let t = p.x
                    p.x = 0 - p.y
                    p.y = t
                } else if (orientation == UIInterfaceOrientation.portraitUpsideDown) {
                    p.x *= -1
                    p.y *= -1
                }
                
                let v = CGVector(dx: p.x, dy: 0 - p.y);
                self.gravity.gravityDirection = v;
            })
            
        }
    }
   /* struct vars {
        //static var signedin = 0
        static var hscore = "0"
        static var shop2 = "0"
        static var shop3 = "0"
        static var shop4 = "0"
        static var shop5 = "0"
        static var shopselect = "1"
        static var nmselect = "0"
        static var coin = "0"
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAnimatorStuff() {
        animator = UIDynamicAnimator(referenceView:self.view);
        
        gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
        animator?.addBehavior(gravity);
        // We're bouncin' off the walls
         // print("coll" + String.init(describing: collider.boundaryIdentifiers) )
        itemBehavior.resistance = 0.1
        itemBehavior.allowsRotation = false
        itemBehavior.friction = 0
        itemBehavior.elasticity = 0.75
        animator?.addBehavior(itemBehavior)
    }
    @objc func viewrisign(){
        self.gname.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 12))
        gname.setNeedsLayout()
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [.repeat,.autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.gname.transform = self.gname.transform.rotated(by:  -1 * (CGFloat.pi / 12)).scaledBy(x: 1.5, y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.5, animations: {
                self.gname.transform = self.gname.transform.rotated(by:  -1 * (CGFloat.pi / 12)).scaledBy(x: 2/3, y: 2/3)
            })
        }, completion: nil)
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
    }
}
