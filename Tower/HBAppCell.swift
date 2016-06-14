//
//  HBAppCell.swift
//  HBHorizontalTableView
//
//  Created by 黄招宇 on 15/3/28.
//  Copyright (c) 2015年 Huang Zhaoyu. All rights reserved.
//

import UIKit

class HBAppCell: UITableViewCell {
    @IBOutlet weak var headView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var imageName:String{
        set
        {
            headView.image = UIImage(named: newValue)
        }
        get
        {
            return self.imageName
        }
    }
    
}
