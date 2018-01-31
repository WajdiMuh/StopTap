//
//  devViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 4/2/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//
import AudioToolbox
import UIKit

class devViewController: UIViewController {
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var developedb: UILabel!
    @IBOutlet weak var thx: UILabel!
    @IBOutlet weak var devimg: UIImageView!
    var color:Foundation.Timer = Foundation.Timer()
    var check:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.layer.cornerRadius = 10
        menu.layer.borderWidth = 5
        color = Foundation.Timer(timeInterval: 0.5, target: self, selector: #selector(devViewController.colordev), userInfo: nil, repeats: true)
        RunLoop.current.add(color, forMode: RunLoopMode.commonModes)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat,.curveEaseInOut,.autoreverse], animations: {
            self.devimg.transform = self.devimg.transform.scaledBy(x: 1.1, y: 1.1)
        }, completion: {(finished: Bool) -> Void in
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch (provider.getInt(forKey: "lang", defaultValue: 1)) {
        case 0:
            developedb.text = "طورت بواسطة"
            developer.text = "وجدي المهتدي"
            thx.text = "شكراً للّعب"
            developedb.arabic(size: 20, diffinsize: 6)
            developer.arabic(size: 20, diffinsize: 6)
            thx.arabic(size: 20, diffinsize: 6)
            menu.setTitle("عودة", for: UIControlState())
            menu.arabic(size: 20, diffinsize: 6)
            break
        case 1:
            developedb.text = "Developed By"
            developer.text = "Wajdi Al-Muhtadi"
            thx.text = "Thx For Playing"
            developedb.english(size: 20, diffinsize: 6)
            developer.english(size: 20, diffinsize: 6)
            thx.english(size: 20, diffinsize: 6)
            menu.setTitle("Back", for: UIControlState())
            menu.english(size: 20, diffinsize: 6,left: 4,top: 3)
            break
        default:
            developedb.text = "Developed By"
            developer.text = "Wajdi Al-Muhtadi"
            thx.text = "Thx For Playing"
            developedb.english(size: 20, diffinsize: 6)
            developer.english(size: 20, diffinsize: 6)
            thx.english(size: 20, diffinsize: 6)
            menu.setTitle("Back", for: UIControlState())
            menu.english(size: 20, diffinsize: 6,left: 4,top: 3)
            break
        }
        check = provider.getInt(forKey: "nm", defaultValue: 0)
        if(check == 0){
            self.view.backgroundColor = UIColor.white
            menu.layer.borderColor = UIColor.black.cgColor
            menu.setTitleColor(UIColor.black, for: UIControlState())
            developer.textColor = UIColor.black
            developedb.textColor = UIColor.black
            thx.textColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.black
            menu.layer.borderColor = UIColor.white.cgColor
            menu.setTitleColor(UIColor.white, for: UIControlState())
            developer.textColor = UIColor.white
            developedb.textColor = UIColor.white
            thx.textColor = UIColor.white
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menub(_ sender: AnyObject) {
        if(KeyStoreDefaultsProvider(cryptoProvider: nil).getInt(forKey: "vib", defaultValue: 1) == 1){
            AudioServicesPlaySystemSound(1519);
        }
        color.invalidate()
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func colordev(){
        if(check == 0){
        if (developer.textColor == UIColor.black){
            developer.textColor = UIColor.init(red: 0, green: 0.29, blue: 0.9, alpha: 1)
        }else{
            developer.textColor = UIColor.black
        }
        }else{
            if (developer.textColor == UIColor.white){
                developer.textColor = UIColor.init(red: 0, green: 0.29, blue: 0.9, alpha: 1)
            }else{
                developer.textColor = UIColor.white
            }
        }
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
       return [UIInterfaceOrientationMask.landscapeRight ,UIInterfaceOrientationMask.landscapeLeft]
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
