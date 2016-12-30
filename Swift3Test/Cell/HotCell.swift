//
//  HotCell.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/30.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

class HotCell: UICollectionViewCell {

    var label = UILabel()
    var button = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel.init(frame: self.bounds)
        label.textAlignment = .center
        self.addSubview(label)
        button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.white
        button.frame = CGRect(x:frame.size.width - 20,y:5,width:15,height:15)
        self.addSubview(button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
