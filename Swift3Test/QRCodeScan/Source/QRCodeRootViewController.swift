//
//  QRCodeRootViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 17/1/5.
//  Copyright © 2017年 Miaoz. All rights reserved.
//

import UIKit

class QRCodeRootViewController: BaseViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        initSubViews()
    }
    
    private func initSubViews() {
        let titleArray:[String] = ["扫描二维码","生成二维码","识别二维码","扫描2"]
        
        for index in 0...3 {
            let button:UIButton = UIButton.init()
            button.frame = CGRect(x: Int(CGFloat(kScreenWidth/2 - 50
            )), y: index * 100 + 100, width: 100, height: 30)
            button.backgroundColor = UIColor.red
            button.setTitle(titleArray[index], for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
    func buttonClick(sender:UIButton) {
        
        switch sender.tag {
        case 0:
            let VC0:ScanCodeViewController = ScanCodeViewController()
            
            self.navigationController?.pushViewController(VC0, animated: true)
        case 1:
            let vc1:GenerateQRCodeViewController = GenerateQRCodeViewController()
            
            self.navigationController?.pushViewController(vc1, animated: true)
            
        case 2:
           
            
            Tool.shareTool.choosePicture(self, editor: true) { [weak self] (image) in
                let vc2:RecognizeQRCodeViewController = RecognizeQRCodeViewController()
                vc2.sourceImage = image;
                self?.navigationController?.pushViewController(vc2, animated: true)
            }
            
        case 3:
            let qrcodeVC:QRCodeScanViewController = QRCodeScanViewController()
            
            self.navigationController?.pushViewController(qrcodeVC, animated: true)
            

        default: break
            
        }
        
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
