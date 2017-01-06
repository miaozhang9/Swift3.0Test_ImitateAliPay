//
//  AliPayViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

class AliPayViewController: BaseViewController {
    var topView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AliPay"
        let leftItem = UIBarButtonItem(title: "账单", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showMyOrder))
        navigationItem.leftBarButtonItem = leftItem;
        // Do any additional setup after loading the view.
        self.initTopView()
    }

    func showMyOrder()  {
        print("showMyOrder")
    }
    
    private func initTopView() {
        topView = {
            let tempTopView = UIView.init(frame: CGRect(x: 0, y: kNavbarHeight, width: kScreenWidth, height: 2 * kNavbarHeight))
            tempTopView.backgroundColor = kThemeColor
            view.addSubview(tempTopView)
            return tempTopView
        }()
        
        let imageViewWidth:CGFloat = kScreenWidth/4
        for index in 0...3 {
            let imageView = UIImageView.init()
            imageView.tintColor = UIColor.white
            imageView.isUserInteractionEnabled = true
            imageView.frame = CGRect(x: imageViewWidth * CGFloat(index), y: 0, width: imageViewWidth, height: (topView?.frame.size.height)!)
            
            let titleLabel = UILabel.init(frame: CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y+(topView?.frame.size.height)!*2/3, width: imageViewWidth, height: 30))
            
            
            if index == 0 {
                imageView.image = UIImage.init(named: "scan")
                titleLabel.text = "扫一扫"
            } else if index == 1 {
                imageView.image = UIImage.init(named: "scanStatic")
                titleLabel.text = "付款"
            }else if index == 2 {
                imageView.image = UIImage.init(named: "scan")
                titleLabel.text = "卡券"
            }else if index == 3 {
                imageView.image = UIImage.init(named: "scan")
                titleLabel.text = "附近"
            }
            titleLabel.textAlignment = .center
            titleLabel.textColor = UIColor.white
            imageView.tag = index
            imageView.contentMode = .center;
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(topBtnClick(sender:)))
            imageView.addGestureRecognizer(tap)
            topView?.addSubview(imageView)
            topView?.addSubview(titleLabel)
        }
    }
    
    func topBtnClick(sender: UITapGestureRecognizer) {
        let imageView: UIImageView = sender.view as! UIImageView
        
        switch imageView.tag {
        case 0:
            let qrcodeRootVC:QRCodeRootViewController = QRCodeRootViewController()
            
            self.navigationController?.pushViewController(qrcodeRootVC, animated: true)
        case 0:
            print("\(sender.view?.tag)")
        case 0:
            print("\(sender.view?.tag)")
        case 0:
            print("\(sender.view?.tag)")
        default:
            print("\(sender.view?.tag)")
            
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
