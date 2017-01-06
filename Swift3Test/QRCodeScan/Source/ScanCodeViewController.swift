//
//  ScanCodeViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 17/1/5.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit
import AVFoundation

private let scanAnimationDuration = 3.0//扫描时长

class ScanCodeViewController: BaseViewController
{
    
    //MARK: -
    //MARK: Global Variables
    
    var scanPane: UIImageView!///扫描框
    var activityIndicatorView: UIActivityIndicatorView!
    var bottomView:UIView?
    
    var lightOn = false///开光灯
    
    
    //MARK: -
    //MARK: Lazy Components
    
    lazy var scanLine : UIImageView =
        {
            
            let scanLine = UIImageView()
            scanLine.frame = CGRect(x: 0, y: 0, width: self.scanPane.bounds.width, height: 3)
            scanLine.image = UIImage(named: "QRCode_ScanLine")
            
            return scanLine
            
    }()
    
    var scanSession :  AVCaptureSession?
    
    
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
        setupScanSession()
        
    }
    
    private func initSubViews() {
    
        let label: UILabel = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "将取景框对准二维/条形码，即可自动扫描"
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(100)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        scanPane = UIImageView.init(image: UIImage.init(named: "QRCode_ScanBox"))
        self.view.addSubview(scanPane)
        scanPane.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(200)
            make.left.equalTo(74.5)
            make.size.equalTo(CGSize(width: 226, height: 188))
        }
        
        activityIndicatorView = UIActivityIndicatorView.init()
        activityIndicatorView.color = UIColor.orange
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView!.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
        initBottomView()
        view.layoutIfNeeded()
        scanPane.addSubview(scanLine)
    
    
    }
    private func initBottomView() {
        bottomView = {
            let tempbottomView = UIView.init(frame: CGRect(x: 0, y: kScreenHeight-kNavbarHeight-20, width: kScreenWidth, height: 2 * kNavbarHeight))
            tempbottomView.backgroundColor = kThemeColor
            view.addSubview(tempbottomView)
            return tempbottomView
        }()
        
        let imageViewWidth:CGFloat = kScreenWidth/3
        for index in 0...3 {
            let imageView = UIImageView.init()
            imageView.tintColor = UIColor.white
            imageView.isUserInteractionEnabled = true
            imageView.frame = CGRect(x: imageViewWidth * CGFloat(index), y: 10, width: imageViewWidth, height: ((bottomView?.frame.size.height)!/2))

            if index == 0 {
                imageView.image = UIImage.init(named: "qrcode_scan_btn_photo_nor")
               
            } else if index == 1 {
                imageView.image = UIImage.init(named: "qrcode_scan_btn_flash_nor")
              
            }else if index == 2 {
                imageView.image = UIImage.init(named: "qrcode_scan_btn_myqrcode_nor")
                
            }
          
            imageView.contentMode = .center;
            
            let button: UIButton = UIButton.init()
            button.frame = CGRect(x: 0, y: 0, width: imageViewWidth, height: imageView.frame.size.height)
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action: #selector(bottomBtnClick(sender:)), for: .touchUpInside)
            button.tag = index
            imageView.addSubview(button)
            bottomView?.addSubview(imageView)
        
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        startScan()
        
    }
    
    
    //MARK: -
    //MARK: Interface Components
    
    func setupScanSession()
    {
        
        do
        {
            //设置捕捉设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            //设置设备输入输出
            let input = try AVCaptureDeviceInput(device: device)
            
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            //设置会话
            let  scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(AVCaptureSessionPresetHigh)
            
            if scanSession.canAddInput(input)
            {
                scanSession.addInput(input)
            }
            
            if scanSession.canAddOutput(output)
            {
                scanSession.addOutput(output)
            }
            
            //设置扫描类型(二维码和条形码)
            output.metadataObjectTypes = [
            AVMetadataObjectTypeQRCode,
            AVMetadataObjectTypeCode39Code,
            AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypeCode39Mod43Code,
            AVMetadataObjectTypeEAN13Code,
            AVMetadataObjectTypeEAN8Code,
            AVMetadataObjectTypeCode93Code]
            
            //预览图层
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
            scanPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            scanPreviewLayer!.frame = view.layer.bounds
            
            view.layer.insertSublayer(scanPreviewLayer!, at: 0)
            
            //设置扫描区域
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (noti) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for: self.scanPane.frame))!
            })
            
            
            
            //保存会话
            self.scanSession = scanSession
            
        }
        catch
        {
            //摄像头不可用
            
            Tool.confirm(title: "温馨提示", message: "摄像头不可用", controller: self)
            
            return
        }

    }
    
    //MARK: -
    //MARK: Target Action
    func bottomBtnClick(sender: UIButton) {
        
        switch sender.tag {
        case 0:
             photo()
        case 1:
             light(sender)
        case 2:
            
            let vc2:MyQRCodeViewController = MyQRCodeViewController()
            
            self.navigationController?.pushViewController(vc2, animated: false)
       
        default:
            print("\(sender.tag)")
            
        }
    
    
    
    }
    //闪光灯
    func light(_ sender: UIButton)
    {
        
        lightOn = !lightOn
        sender.isSelected = lightOn
        turnTorchOn()
        
    }
    
    //相册
    func photo()
    {
        
        Tool.shareTool.choosePicture(self, editor: true, options: .photoLibrary) {[weak self] (image) in

            self!.activityIndicatorView.startAnimating()
            
            DispatchQueue.global().async {
                let recognizeResult = image.recognizeQRCode()
                let result = recognizeResult?.characters.count > 0 ? recognizeResult : "无法识别"
                DispatchQueue.main.async {
                    self!.activityIndicatorView.stopAnimating()
                    Tool.confirm(title: "扫描结果", message: result, controller: self!)
                }
            }
        }
        
    }
    
    //MARK: -
    //MARK: Data Request
    
    
    //MARK: -
    //MARK: Private Methods
    
    //开始扫描
    fileprivate func startScan()
    {
    
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        
        guard let scanSession = scanSession else { return }
        
        if !scanSession.isRunning
        {
            scanSession.startRunning()
        }
        
        
    }
    
    //扫描动画
    private func scanAnimation() -> CABasicAnimation
    {
    
        let startPoint = CGPoint(x: scanLine .center.x  , y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: scanPane.bounds.size.height - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        
        return translation
    }
    
    
    ///闪光灯
    private func turnTorchOn()
    {
        
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else
        {
            
            if lightOn
            {
                
                Tool.confirm(title: "温馨提示", message: "闪光灯不可用", controller: self)

            }
            
            return
        }
        
        if device.hasTorch
        {
            do
            {
                try device.lockForConfiguration()
                
                if lightOn && device.torchMode == .off
                {
                    device.torchMode = .on
                }
                
                if !lightOn && device.torchMode == .on
                {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            }
            catch{ }
        
        }
        
    }
    
    //MARK: -
    //MARK: Dealloc
    
    deinit
    {
        ///移除通知
        NotificationCenter.default.removeObserver(self)
        
    }
    
}


//MARK: -
//MARK: AVCaptureMetadataOutputObjects Delegate

//扫描捕捉完成
extension ScanCodeViewController : AVCaptureMetadataOutputObjectsDelegate
{
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        
        //停止扫描
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        //播放声音
        Tool.playAlertSound(sound: "noticeMusic.caf")
        
        //扫完完成
        if metadataObjects.count > 0
        {
            
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject
            {
                
                Tool.confirm(title: "扫描结果", message: resultObj.stringValue, controller: self,handler: { (_) in
                    //继续扫描
                    self.startScan()
                })
                
            }
            
        }
        
    }
    
}

