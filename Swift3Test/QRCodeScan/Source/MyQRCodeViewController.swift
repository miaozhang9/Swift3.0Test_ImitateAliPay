//
//  MyQRCodeViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 17/1/5.
//  Copyright © 2016年 Miaoz. All rights reserved.
//
import UIKit
import SnapKit
class MyQRCodeViewController: UIViewController
{
    
    //MARK: -
    //MARK: Global Variables
    
//    @IBOutlet private weak var myQRCode: UIImageView!
    var myQRCode: UIImageView!
    //MARK: -
    //MARK: Lazy Components
    
    
    //MARK: -
    //MARK: Public Methods
    
    
    //MARK: -
    //MARK: Data Initialize
    
    
    //MARK: -
    //MARK: Life Cycle
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        initSubViews()
        myQRCode.image = "https://github.com/miaozhang9/Swift3.0Test_ImitateAliPay.git".generateQRCodeWithLogo(logo: UIImage(named: "8_150709170804_8"))
        
    }
    
    
    //MARK: -
    //MARK: Interface Components
    private func initSubViews() {
    
        myQRCode = UIImageView.init()
        self.view.addSubview(myQRCode)
        myQRCode!.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(80)
            make.left.equalTo(self.view.snp.left).offset(50)
            make.right.equalTo(self.view.snp.right).offset(-50)
            make.height.equalTo(280)
        }

    
    }
    
    //MARK: -
    //MARK: Target Action
    
    
    //MARK: -
    //MARK: Data Request
    
    
    //MARK: -
    //MARK: Private Methods
    
    
    //MARK: -
    //MARK: Dealloc
    
    
}


//MARK: -
//MARK: <#statement#> Delegate



