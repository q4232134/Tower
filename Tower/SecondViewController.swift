//
//  SecondViewController.swift
//  Doragon
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource,HBTableViewDelegate,RatingBarDelegate
{
    
    @IBOutlet weak var ourEqTableView: UITableView!
    @IBOutlet weak var enemyEqTableeView: UITableView!
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBOutlet weak var hpProgress: UIProgressView!
    @IBOutlet weak var phyProgress: UIProgressView!
    
    @IBOutlet weak var our: UIImageView!
    @IBOutlet weak var enemy: UIImageView!
    
    @IBOutlet weak var ratingBar: RatingBar!
    @IBOutlet weak var hview: HBHorizontalTableView!
    
    var ourPerson:Person!
    var enemyPerson:Person!
    
    //可选技能列表
    var skillList:Array<Skill> = []
    var historyList:Array<(title:String,content:String)> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ourEqTableView.dataSource = self
        ourEqTableView.layer.cornerRadius = 5
        
        enemyEqTableeView.dataSource = self
        enemyEqTableeView.layer.cornerRadius = 5
        
        historyTableView.dataSource = self
        
        hview.delegate = self
        hview.clipsToBounds = false
        ratingBar.delegate = self
        ourPerson = Player.create("法师", str: 3, con: 5, int: 8, agi: 3)
        enemyPerson = Player.create("战士", str: 7, con: 6, int: 3, agi: 4)
        initDate()
        //        ablist.append([Skill01(),Skill02(our),Status01(our)])
        
    }
    
    func initDate(){
        skillList.append(Skill01(source : ourPerson))
        skillList.append(Skill02(source : ourPerson))
        skillList.append(Skill03(source : ourPerson))
    }
    
    func htableView(horizontalTableView: HBHorizontalTableView, numberOfRowsInSection section: Int) -> Int
    {
        return skillList.count
    }
    
    func ratingDidChange(ratingBar: RatingBar,rating: CGFloat)
    {
        print(rating)
    }
    
    
    func tableView(horizontalTableView: HBHorizontalTableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let skill = skillList[indexPath.item]
        historyList.append((skill.name,skill.act(enemyPerson)))
        historyTableView.reloadData()
        let ns = NSIndexPath(forRow: 0, inSection: 0)
        historyTableView.scrollToRowAtIndexPath(ns, atScrollPosition:.None, animated: true)
    }
    
    
    /**
     返回横向tableView的Cell
     
     - parameter horizontalTableView: 横向tableView
     - parameter indexPath:           index
     
     - returns: cell
     */
    func htableView(horizontalTableView: HBHorizontalTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: HBAppCell = horizontalTableView.tableView!.dequeueReusableCellWithIdentifier("app_cell", forIndexPath: indexPath) as! HBAppCell
        cell.label.text = skillList[indexPath.item].name
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: cell, cache: true)
        UIView.commitAnimations()
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch tableView
        {
        case historyTableView: return historyList.count
        default: return Constance.Destructible_Equip_List.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell? = nil
        switch tableView
        {
        case ourEqTableView: cell = getOurEqCell(tableView,indexPath: indexPath)
        case enemyEqTableeView: cell = getEnemyEqCell(tableView, indexPath: indexPath)
        case historyTableView: cell = getHistoryEqCell(tableView, indexPath: indexPath)
        default: cell = UITableViewCell()
        }
        return cell!
    }
    
    /**
     获取我方装备列表cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: <#return value description#>
     */
    private func getOurEqCell(tableView: UITableView,indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ourCell", forIndexPath: indexPath) as! SecondViewCell
        cell.label.text = Constance.Destructible_Equip_List[indexPath.item]
        cell.quality = indexPath.item * 10
        return cell
    }
    
    /**
     获取敌方装备列表cell
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: <#return value description#>
     */
    private func getEnemyEqCell(tableView: UITableView,indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("enemyCell", forIndexPath: indexPath) as! SecondViewCell
        cell.label.text = Constance.Destructible_Equip_List[indexPath.item]
        cell.quality = indexPath.item * 10
        return cell
    }
    
    /**
     获取历史列表cell
     
     - parameter tableView: tableView description
     - parameter indexPath: indexPath description
     
     - returns: return value description
     */
    private func getHistoryEqCell(tableView: UITableView,indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath)
        cell.textLabel?.text = historyList[historyList.count - indexPath.item - 1].title
        cell.detailTextLabel?.text = historyList[historyList.count - indexPath.item - 1].content
        return cell
    }
    
}

class SecondViewCell:UITableViewCell{
    @IBOutlet weak var label: UILabel!
        {
        didSet{
            
        }
    }
    
    var quality = 100 {
        didSet{
            switch(quality){
            case 50...100 : label.textColor = UIColor.whiteColor()
            case 25...49 : label.textColor = UIColor.greenColor()
            case 1...24 : label.textColor = UIColor.yellowColor()
            case 0...1 : label.textColor = UIColor.redColor()
            default:break
            }
        }
    }
    
}

