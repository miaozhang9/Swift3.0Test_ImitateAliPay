//
//  FriendCell.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/28.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit
import SnapKit


class FriendCell: UITableViewCell {
    var avatarIV: UIImageView!
    var userNameLabel: UILabel!
    var desLabel: UILabel!
//    var friendModel: FriendModel!
    var friendModel: FriendModel! {
        
        didSet{
            self.userNameLabel.text = friendModel.userName
            self.desLabel.text =  "我只是描述\(friendModel.userName!)"
            self.avatarIV.kf.setImage(with: URL(string: friendModel.photo!))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        ininSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ininSubViews() {
        avatarIV = UIImageView.init()
        
        userNameLabel = UILabel.init()
        userNameLabel.font = UIFont.systemFont(ofSize: 17)
        userNameLabel.textColor = UIColor.black
        userNameLabel.textAlignment = .left
        
        desLabel = UILabel.init()
        desLabel.font = UIFont.systemFont(ofSize: 17)
        desLabel.textColor = UIColor.darkGray
        desLabel.textAlignment = .left
        self.addSubview(avatarIV)
        self.addSubview(userNameLabel)
        self.addSubview(desLabel)
        
        avatarIV!.snp.makeConstraints({ (make) -> Void in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.left.equalTo(self.snp.left).offset(8)
            make.top.equalTo(self.snp.top).offset(9)
        })
        
        userNameLabel!.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(self.avatarIV!.snp.right).offset(10)
            make.top.equalTo(self.snp.top).offset(5)
            make.height.equalTo(25)
        })
        
        desLabel!.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.userNameLabel.snp.left)
            make.top.equalTo(self.userNameLabel.snp.bottom).offset(10)
            make.height.equalTo(25)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
