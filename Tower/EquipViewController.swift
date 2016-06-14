//
//  FirstViewController.swift
//  Doragon
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class EquipViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let path = NSBundle.mainBundle().pathForResource("a", ofType: "html")
        let data = NSData(contentsOfFile: path!)
        let str = String(data: data!, encoding: NSUTF8StringEncoding)
        webView.loadHTMLString(str!, baseURL: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Constance.Equip_List.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EquipViewCell
        cell.button.setTitle(Constance.Equip_List[indexPath.item], forState: UIControlState.Normal)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("---->\(Constance.Equip_List[indexPath.item])")
    }
    
    
    
}

class EquipViewCell:UITableViewCell{
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var headView: UIImageView!
    
    @IBAction func buttonClick(sender: UIButton) {
        print(sender.currentTitle!)
    }
}

