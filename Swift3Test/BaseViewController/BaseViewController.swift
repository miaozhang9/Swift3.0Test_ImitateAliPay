//
//  BaseViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        if (self.isKind(of: AliPayViewController.self) || self.isKind(of: ReputationViewController.self) || self.isKind(of: FriendViewController.self) || self.isKind(of: MoneyViewController.self) == true) {
            
            let friendItem = UIBarButtonItem(image: UIImage.init(named: "user"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(showAddress))
            
            let searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(addAction))
            
            let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addAction))
            
            self.navigationItem.rightBarButtonItems = [friendItem,searchItem,addItem]
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
    func showAddress() {
        print("showAddress")
    }
    
    func addAction() {
        print("addAction")
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
