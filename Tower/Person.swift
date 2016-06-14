//
//  Person.swift
//  Tower
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import Foundation

/**
*  属性结构体
*/
public struct Attribute{
    var base:() ->Double = {return 0}//基础属性
    var plus:(percent:Double,add:Double) = (0.0 , 0.0) //属性加成
    var real:Double{ //最终属性
        get{
            return (base() + plus.add) * (1 + plus.percent)
        }
    }
    
}

/// 基础人物类
class BasePerson{
    var id = 0
    var name = ""
    var headImage = ""
    
    var str = Attribute() //力量
    var con = Attribute() //体质
    var int = Attribute() //智力
    //var vit = Attribute() //体力
    var agi = Attribute() //敏捷
    var createTime:NSDate = NSDate()
    var birthday:NSDate = NSDate()
    

}
/// 人物类
class Person:BasePerson{
    var hpMax = Attribute()  //生命上限
    var hp:Double = 0.0  //生命
    var mpMax = Attribute()  //魔力上限
    var mp:Double = 0.0  //魔力
    var engMax = Attribute() //体能上限
    var eng:Double = 0.0 //体能
    var atk = Attribute() //攻击
    var def = Attribute() //防御
    var mdef = Attribute()//魔法抗性
    var hit = Attribute() //命中
    var avd = Attribute() //回避
    var wgt = Attribute() //负重
    
}

class Player{
    
    static func create(name:String , str:Double , con:Double , int:Double , agi:Double) -> Person{
        let temp = Person()
        temp.id = 1
        temp.name = name
        temp.str.base = {return str}
        temp.con.base = {return con}
        temp.int.base = {return int}
        //temp.vit.base = {return 4}
        temp.agi.base = {return agi}
        //最大生命 = 体质 * 5 + 力量 * 3 + 敏捷 * 2 + 智力 * 1
        temp.hpMax.base = {return 30 + temp.con.real * 5 + temp.str.real * 3 + temp.agi.real * 2 + temp.int.real }
        temp.hp = temp.hpMax.real
        
        temp.mpMax.base = {return 10 + temp.int.real * 3}
        temp.mp = temp.mpMax.real
        
        temp.engMax.base = {return 100}
        temp.eng = temp.engMax.real
        
        temp.atk.base = {return 2}
        temp.def.base = {0}
        temp.mdef.base = {0}
        temp.hit.base = {50}
        temp.avd.base = {0}
        temp.wgt.base = {20}
        
        return temp
        
    }
    
}
