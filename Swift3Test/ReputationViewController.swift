//
//  ReputationViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

class ReputationViewController: BaseViewController, ChangeCity {
    var leftButton:UIButton?
    
    
    override func viewDidLoad() {
        title = "口碑"
        
        leftButton = UIButton(type: UIButtonType.custom)
        leftButton?.frame = CGRect(x:0, y:0, width:70, height:40)
        leftButton?.setTitle("广州", for: UIControlState.normal)
        leftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leftButton?.addTarget(self, action:#selector(changeCity(sender:)), for: UIControlEvents.touchUpInside)
        leftButton?.setImage(UIImage(named: "location"), for: UIControlState.normal)
        leftButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0)
        leftButton?.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0)
        
        let leftButtonItem:UIBarButtonItem = UIBarButtonItem(customView: leftButton!)
        navigationItem.leftBarButtonItem = leftButtonItem
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func ChangeCityWithCityName(cityName: String) {
        leftButton?.setTitle((cityName as NSString).substring(to: 2), for: UIControlState.normal)
    }
    
    func changeCity(sender:UIButton){
        let cityList =  CityListViewController();
        cityList.delegate = self
        self.navigationController?.pushViewController(cityList, animated: true)
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
