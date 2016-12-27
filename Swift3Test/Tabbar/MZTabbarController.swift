//
//  MZTabbarController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

class MZTabbarController: UITabBarController {
    
    var aliPay = AliPayViewController()
    var reputationVC = ReputationViewController()
    var friendVC = FriendViewController()
    var moneyVC = MoneyViewController()
    
    func initSubViewControllers() {
        let aliNav = BaseNavgationController(rootViewController: aliPay)
        let aliItem = UITabBarItem.init(title: "支付宝", image: UIImage.init(named: "TabBar_Homebar"), selectedImage: UIImage.init(named: "TabBar_HomeBar_Sel"))
        aliNav.tabBarItem = aliItem;
        
        let reputtationNav = BaseNavgationController(rootViewController: reputationVC)
        let reputtationItem = UITabBarItem.init(title: "口碑", image: UIImage.init(named: "TabBar_Businesses"), selectedImage: UIImage.init(named: "TabBar_Businesses_Sel"))
        reputtationNav.tabBarItem = reputtationItem;
        
        let friendNav = BaseNavgationController(rootViewController: friendVC)
        let friendItem = UITabBarItem.init(title: "朋友", image: UIImage.init(named: "TabBar_Friends"), selectedImage: UIImage.init(named: "TabBar_Friends_Sel"))
        friendNav.tabBarItem = friendItem;
        
        let moneyNav = BaseNavgationController(rootViewController: moneyVC)
        let moneyItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "TabBar_Assets"), selectedImage: UIImage.init(named: "TabBar_Assets_Sel"))
        moneyNav.tabBarItem = moneyItem;
        
        self.viewControllers = [aliNav,reputtationNav,friendNav,moneyNav];
        self.tabBar.tintColor = UIColor.red
        
    }
    
    override func viewDidLoad() {
         //创建tabbar的子控制器
        self.initSubViewControllers()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
