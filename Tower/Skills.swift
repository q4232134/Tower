//
//  Skills.swift
//  Tower
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

protocol BaseAbility{
    var name:String {get set}
    var description:String {get set}
    /**
     释放技能
     
     - parameter target: 目标人物
     
     - returns: 结果
     */
    func act(target:Person)->String
}

/**
 *  可升级的技能
 */
protocol Growable{
    /// 技能等级
    var lv:Int {get set}
    /**
     获得计算数据
     
     - parameter source: 发动人
     
     - returns: 计算完成后数据
     */
    func getData()->Double
}

protocol Status{
    /// 持续时间
    var during:Int{get set}
    /**
     状态结束
     */
    func end(target:Person)
}


class Skill:BaseAbility,Growable{
    init(source:Person,lv:Int){
        self.source = source
        self.lv = lv
    }

    var source:Person // 发动人物
    var lv:Int = 1 //技能等级
    var name:String = "" //技能名称
    var description:String = "" //技能描述
    
    func getData()->Double{
        return 0
    }
    func act(target:Person)->String{
        return ""
    }
    
    
}

/// 基础世界观设定
class BaseSetting{
    /**
     计算物理伤害值
     
     - parameter attack: 攻击
     - parameter define: 防御
     
     - returns: 伤害
     */
    static func getAtkDamage(attack:Double,define:Double)->Double{
        let temp = attack - define
        if (temp > 0){
            return temp
        }
        else{
            return 1.0
        }
    }
    
    /**
     计算魔法伤害
     
     - parameter attack: 攻击
     - parameter define: 抗性
     
     - returns: 伤害
     */
    static func getMgcDamage(attack:Double,define:Double)->Double{
        return attack * (1 - define/100 + define)
    }

}

/// 力量增强
class Skill01:Skill,Status{
    override init(source:Person,lv:Int = 1){
        super.init(source: source,lv:lv)
        super.name = "强化力量"
        super.description = "力量增强\(getData() * 100)%"
    }

    var during = 3
    
    override func act(target: Person) -> String {
        target.str.plus.percent += getData()
        return "力量增加\(getData())"
    }
    
    override func getData()->Double{
        return 0.3 + Double(lv) * 0.1
    }
    
    func end(target:Person) {
        target.str.plus.percent -= getData()
    }
}

/// 普通攻击
class Skill02:Skill{
    override init(source:Person,lv:Int = 1){
        super.init(source: source,lv:lv)
        super.name = "攻击"
        super.description = "进行普通攻击"
    }
    
    override func getData() -> Double {
        return source.atk.real
    }
    
    override func act(target: Person) -> String {
        let damage = BaseSetting.getAtkDamage(getData(), define: target.def.real)
        target.hp -= damage
        return "造成\(damage)点伤害"
    }
}

/// 火焰冲击
class Skill03:Skill{
    override init(source:Person,lv:Int = 1){
        super.init(source: source,lv:lv)
        super.name = "火焰冲击"
        super.description = "发射一团大火球进行攻击造成\(getData())伤害"
    }

    override func getData()->Double{
        return source.int.real * (1.5 + Double(lv) * 0.3)
    }

    
    override func act(target: Person) -> String {
        source.mp -= 3.0
        let damage = BaseSetting.getMgcDamage(getData(), define: target.mdef.real)
        target.hp -= damage
        return "造成\(damage)点伤害"
    }
}


