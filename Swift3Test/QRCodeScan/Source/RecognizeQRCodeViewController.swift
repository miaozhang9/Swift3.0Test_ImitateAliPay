//
//  QRCodeScanViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 17/1/5.
//  Copyright © 2016年 Miaoz. All rights reserved.
//
import UIKit

import SnapKit

class RecognizeQRCodeViewController: BaseViewController
{
    
    //MARK: -
    //MARK: Global Variables
    
    var sourceImage : UIImage?
    
//    @IBOutlet private weak var sourceImageView: UIImageView!
//    
//    @IBOutlet private weak var activityIndicatoryView: UIActivityIndicatorView!
    var sourceImageView: UIImageView!
    var activityIndicatoryView: UIActivityIndicatorView!
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
        
        sourceImageView = UIImageView()
        self.view.addSubview(sourceImageView)
        sourceImageView!.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        activityIndicatoryView = UIActivityIndicatorView.init()
        activityIndicatoryView.color = UIColor.orange
        self.view.addSubview(activityIndicatoryView)
        activityIndicatoryView!.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
        
        setupImage()
        
        setupGes()
        
    }
    
    
    //MARK: -
    //MARK: Interface Components
    
    private func setupGes()
    {
        
        sourceImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        
    }
    
    private func setupImage()
    {
        
        sourceImageView?.image = sourceImage
        recognizeQRCode()
        
    }
    
    //MARK: -
    //MARK: Target Action
    
    @objc private func chooseImage()
    {
        
        Tool.shareTool.choosePicture(self, editor: false) { [weak self] (image) in
            self?.sourceImage = image
            self?.setupImage()
        }
        
    }
    
    //MARK: -
    //MARK: Data Request
    
    
    //MARK: -
    //MARK: Private Methods
    
    private func recognizeQRCode()
    {
        
        activityIndicatoryView?.startAnimating()
        
        DispatchQueue.global().async {
            let recognizeResult = self.sourceImage?.recognizeQRCode()
            let result = recognizeResult?.characters.count > 0 ? recognizeResult : "无法识别"
            DispatchQueue.main.async {
                Tool.confirm(title: "扫描结果", message: result, controller: self)
                self.activityIndicatoryView?.stopAnimating()
            }
        }
        
        
        
    }
    
    //MARK: -
    //MARK: Dealloc
    
    
}


//MARK: -
//MARK: <#statement#> Delegate



