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
     
     - returns: 结果
     */
    func act()->String
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
    func getData()->Float
}

protocol Status{
    /// 持续时间
    var during:Int{get set}
    /**
     状态结束
     */
    func end()
}


class Skill:BaseAbility,Growable{
    init(source:Person,enemy:Person,lv:Int){
        self.source = source
        self.enemy = enemy
        self.lv = lv
    }
    
    var source:Person // 发动人物
    var enemy:Person // 敌人人物
    var lv:Int = 1 //技能等级
    var name:String = "" //技能名称
    var description:String = "" //技能描述
    
    func getData()->Float{
        return 0
    }
    func act()->String{
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
    static func getAtkDamage(attack:Float,define:Float)->Float{
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
    static func getMgcDamage(attack:Float,define:Float)->Float{
        return attack * (1 - define/100 + define)
    }
    
}

/// 力量增强
class Skill01:Skill,Status{
    override init(source:Person,enemy:Person,lv:Int = 1){
        super.init(source: source,enemy:enemy,lv:lv)
        super.name = "强化力量"
        super.description = "力量增强\(getData() * 100)%"
    }
    
    var during = 3
    
    override func act() -> String {
        var hpAdd = source.hpMax.real
        source.str.plus.percent += getData()
        hpAdd = source.hpMax.real - hpAdd
        source.hp += hpAdd
        return "力量增加\(getData())"
    }
    
    override func getData()->Float{
        return 0.3 + Float(lv) * 0.1
    }
    
    func end() {
        source.str.plus.percent -= getData()
        if source.hp > source.hpMax.real {
            source.hp  = source.hpMax.real
        }
    }
}

/// 普通攻击
class Skill02:Skill{
    override init(source:Person,enemy:Person,lv:Int = 1){
        super.init(source: source,enemy:enemy,lv:lv)
        super.name = "攻击"
        super.description = "进行普通攻击"
    }
    
    override func getData() -> Float {
        return source.atk.real
    }
    
    override func act() -> String {
        let damage = BaseSetting.getAtkDamage(getData(), define: enemy.def.real)
        enemy.hp -= damage
        return "造成\(damage)点伤害"
    }
}

/// 火焰冲击
class Skill03:Skill{
    override init(source:Person,enemy:Person,lv:Int = 1){
        super.init(source: source,enemy:enemy,lv:lv)
        super.name = "火焰冲击"
        super.description = "发射一团大火球进行攻击造成\(getData())伤害"
    }
    
    override func getData()->Float{
        return source.int.real * (1.5 + Float(lv) * 0.3)
    }
    
    
    override func act() -> String {
        source.mp -= 3.0
        let damage = BaseSetting.getMgcDamage(getData(), define: enemy.mdef.real)
        enemy.hp -= damage
        return "造成\(damage)点伤害"
    }
}


/// 治愈术
class Skill04:Skill{
    override init(source:Person,enemy:Person,lv:Int = 1){
        super.init(source: source,enemy:enemy,lv:lv)
        super.name = "治愈术"
        super.description = "回复\(getData())点生命"
    }
    
    override func getData()->Float{
        return 20 + source.int.real * (Float(lv) * 2)
    }
    
    
    override func act() -> String {
        source.mp -= 5.0
        let hp = getData()
        let lastHp = source.hp
        source.hp += hp
        if source.hp > source.hpMax.real{
            source.hp = source.hpMax.real
        }
        return "回复\(source.hp - lastHp)点生命"
    }
}


