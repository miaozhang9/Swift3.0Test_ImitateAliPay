//
//  FriendModel.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/28.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

class FriendModel: NSObject {
    var userName:String!
    var userId:String!
    var photo:String!
    
    init(userName:String,userId:String,photo:String) {
        super.init()
        self.userName = userName;
        self.userId = userId;
        self.photo = photo;
    }
    
    init(infoDic:NSDictionary) {
        super.init()
        self.userName = infoDic["userName"] as! String
        self.userId = infoDic["userId"] as! String
        self.photo = infoDic["photo"] as! String
    }
    
}
