//
//  GenerateQRCodeViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 17/1/5.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit
import SnapKit

class GenerateQRCodeViewController: UIViewController
{
    
    //MARK: -
    //MARK: Global Variables
    
    var contentLab: UITextField!
    var logoImageView: UIImageView!
    var QRCodeImageView: UIImageView!
    
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
        setupComponents()
        
    }
    
    
    //MARK: -
    //MARK: Interface Components
    private func initSubViews() {
        contentLab = UITextField.init()
        contentLab.placeholder = "请输入要生成二维码的文字"
        contentLab.borderStyle = .roundedRect
        self.view.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let lable: UILabel = UILabel.init()
        lable.text = "请选择logo:"
        lable.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(lable)
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(contentLab.snp.left)
            make.top.equalTo(contentLab.snp.bottom).offset(20)
        }
        
        logoImageView = UIImageView.init(image: UIImage.init(named: "8_150709170804_8"))
        self.view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(lable.snp.right).offset(20)
            make.top.equalTo(lable.snp.top)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        let lable2: UILabel = UILabel.init()
        lable2.text = "二维码"
        lable2.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(lable2)
        lable2.snp.makeConstraints { (make) in
            make.left.equalTo(lable.snp.left)
            make.top.equalTo(lable.snp.bottom).offset(50)
        }
        
        QRCodeImageView = UIImageView.init(image: UIImage.init(named: "8_150709170804_8"))
        self.view.addSubview(QRCodeImageView)
        QRCodeImageView.snp.makeConstraints { (make) in
            make.left.equalTo(lable.snp.left)
            make.top.equalTo(lable2.snp.bottom)
            make.size.equalTo(CGSize(width: 232, height: 232))
        }
    
    }
    
    
    
    
    private func setupComponents()
    {
        
        let generateItem = UIBarButtonItem(title: "生成", style: .plain, target: self, action: #selector(generateItemClick))
        navigationItem.rightBarButtonItem = generateItem
        
        let chooseLogoGes = UITapGestureRecognizer(target: self, action: #selector(chooseLogo))
        logoImageView.addGestureRecognizer(chooseLogoGes)
        
    }
    
    //MARK: -
    //MARK: Target Action
    
    @objc private func generateItemClick()
    {
        
        view.endEditing(true)
        
        guard let  content = contentLab.text else
        {
            
            Tool.confirm(title: "温馨提示", message: "请输入内容", controller: self)
            
            return
        }
        
        if content.characters.count > 0
        {
            DispatchQueue.global().async {
                
                let image = content.generateQRCodeWithLogo(logo: self.logoImageView.image)
                DispatchQueue.main.async(execute: {
                    self.QRCodeImageView.image = image
                })
                
            }
            
        }
        else
        {
            
            Tool.confirm(title: "温馨提示", message: "请输入内容", controller: self)
            
        }
        
    
    }
    
    @objc private func chooseLogo()
    {
        
        Tool.shareTool.choosePicture(self, editor: true) { [weak self] (image) in
            self?.logoImageView.image = image
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        view.endEditing(true)
        
    }
    
    //MARK: -
    //MARK: Data Request
    
    
    //MARK: -
    //MARK: Private Methods
    
    
    //MARK: -
    //MARK: Dealloc
    
    
}


//MARK: -
//MARK: <#statement#> Delegate



