//
//  QRCodeScanViewController.swift
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
        
        myQRCode = UIImageView.init()
        self.view.addSubview(myQRCode)
        myQRCode!.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(80)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.size.equalTo(CGSize(width: 280, height: 280))
        }
        
        
        
        myQRCode.image = "https://github.com/fuaiyi/QRCode.git".generateQRCodeWithLogo(logo: UIImage(named: "8_150709170804_8"))
        
    }
    
    
    //MARK: -
    //MARK: Interface Components
    
    
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



