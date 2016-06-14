//
//  Ability.swift
//  Tower
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import Foundation

class Ability{
    var target:Person!
    var name = ""
    var description = ""
    var type:AbilityType = AbilityType.skill
}

/**
能力类型

- status: 状态
- skill:  技能
*/
enum AbilityType{
    case status
    case skill
}

/**
元素伤害类型

- fire:     火焰
- ice:      冰
- electric: 雷电
- natrue:   自然
- light:    光
- dark:     暗
*/
enum AtkType{
    case fire
    case ice
    case electric
    case natrue
    case light
    case dark
}

enum HitPart{
    case body //身体
    case Armor //盔甲
    case Shield //盾牌
    case Weapon //武器
}

/// 伤害传递包
struct Damage{
    var atk = 0.0 //普通伤害
    var matk = 0.0 //元素伤害
    var atkType:AtkType? = nil//元素伤害类型
    var hitRate = 1.0 //命中
    var statusList = Array<Ability>()//状态列表
    var part = 0 //攻击部位，0代表全部
    var hitPart:HitPart? = nil //击中部位(主要用于反馈)
    var isRetroaction = false //是否为反馈
}


