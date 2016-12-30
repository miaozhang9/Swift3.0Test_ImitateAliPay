//
//  MoneyCollectionViewCell.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/30.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit
import SnapKit

class MoneyCollectionViewCell: UICollectionViewCell {
    var desLabel: UILabel?
    var titleIV: UIImageView?
    var titleLabel: UILabel?
    var rowDic:NSDictionary! {
    
        didSet{
            
            self.titleLabel!.text = rowDic["title"] as? String
            self.titleIV!.image =  UIImage(named: rowDic["imgName"]as! String)
            self.desLabel!.text = rowDic["des"] as? String
            self.layer.borderColor = UIColor.lightGray.cgColor;
            self.layer.borderWidth = 0.25;
            self.backgroundColor = UIColor.white
        }
    
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(frame:CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    func initSubViews() {
       
        titleIV = UIImageView.init()
        titleLabel = UILabel.init()
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        titleLabel?.textColor = UIColor.black
         desLabel = UILabel.init()
        desLabel?.font = UIFont.systemFont(ofSize: 15)
        desLabel?.textColor = UIColor.gray
        self.addSubview(desLabel!)
        self.addSubview(titleIV!)
        self.addSubview(titleLabel!)
        
        titleIV!.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(self.snp.left).offset(5)
            make.top.equalTo(self.snp.top).offset(10)
            make.size.equalTo(CGSize(width: 24, height: 24))
        })
        
        titleLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(titleIV!.snp.right).offset(10)
            make.top.equalTo(self.snp.top).offset(5)
            make.height.equalTo(20)
        }
        
        desLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel!.snp.left).offset(0)
            make.top.equalTo(titleLabel!.snp.bottom).offset(3)
            make.height.equalTo(20)
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
