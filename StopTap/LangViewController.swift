//
//  LangViewController.swift
//  StopTap
//
//  Created by wajdi muhtadi on 3/30/16.
//  Copyright © 2016 wajdi muhtadi. All rights reserved.
//

import UIKit

class LangViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var lan: UILabel!
    @IBOutlet weak var langs: UITableView!
    var langsava:Array = ["Arabic", "English"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.langs.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.langs.dataSource = self
        self.langs.delegate = self
        self.langs.separatorInset.left = 0
        self.langs.tableFooterView = UIView(frame: CGRect.zero)
        back.layer.cornerRadius = 10
        back.layer.borderWidth = 5
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        switch provider.getInt(forKey: "lang", defaultValue: 1) {
        case 0:
            self.langsava[0] = "Arabic\nSelected"
            break
        case 1:
            self.langsava[1] = "English\nSelected"
            break
        default:
            self.langsava[1] = "English\nSelected"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            self.view.backgroundColor = UIColor.white
            back.layer.borderColor = UIColor.black.cgColor
            back.setTitleColor(UIColor.black, for: UIControlState())
            lan.textColor = UIColor.black
            self.langs.backgroundColor = UIColor.white
        }else{
            self.view.backgroundColor = UIColor.black
            back.layer.borderColor = UIColor.white.cgColor
            back.setTitleColor(UIColor.white, for: UIControlState())
            lan.textColor = UIColor.white
            self.langs.backgroundColor = UIColor.black
        }
    }
    @IBAction func backb(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.langsava.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 	{
        
        let cell: UITableViewCell = self.langs.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.langsava[(indexPath as NSIndexPath).row]
        cell.layoutMargins = UIEdgeInsets.zero
         cell.preservesSuperviewLayoutMargins = false
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.numberOfLines = 2
        if(UIDevice.current.userInterfaceIdiom == .phone){
            cell.textLabel?.font = UIFont(name:"DotsAllForNowJL", size:18)
        }else{
            cell.textLabel?.font = UIFont(name:"DotsAllForNowJL", size:22)
        }
        cell.selectionStyle = .none
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        if(provider.getInt(forKey: "nm", defaultValue: 0) == 0){
            cell.textLabel?.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
        }else{
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.black
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let provider = KeyStoreDefaultsProvider(cryptoProvider: nil)
        provider.setInt(forKey: "lang", value: (indexPath as NSIndexPath).item)
        switch (indexPath as NSIndexPath).item {
        case 0:
            self.langsava = ["Arabic\nSelected", "English"]
            break
        case 1:
            self.langsava = ["Arabic", "English\nSelected"]
            break
        default:
            self.langsava = ["Arabic", "English\nSelected"]
        }
        self.langs.reloadData()
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
