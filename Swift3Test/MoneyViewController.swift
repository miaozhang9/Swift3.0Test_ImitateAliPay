//
//  MoneyViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

let cellMIdentifier:String = "cell"

class MoneyViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var collectionView:UICollectionView?
    let dataSource:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        title="我的"
        loadData()
        initCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
         let sectionArray0 = [["imgName":"balance","title":"余额","des":"666.66"],["imgName":"bankcard","title":"银行卡","des":"4"],["imgName":"mfund","title":"余额宝","des":"0.66"],["imgName":"fixed","title":"招财宝","des":"灵活的定期理财"],["imgName":"stock","title":"股票","des":"查看详情"],["imgName":"jiebei","title":"基金","des":"买入费率1折起"],["imgName":"yulebao","title":"娱乐宝","des":"谁是你的菜8.88%"],["imgName":"","title":"","des":""]];
        dataSource.add(sectionArray0)
        
        let sectionArray1 = [["imgName":"credit","title":"芝麻信用分","des":"666"],["imgName":"huabei","title":"芝麻花呗","des":"600.00"]];
        dataSource.add(sectionArray1)
        
        let sectionArray2 = [["imgName":"tipIcon1","title":"我的保障","des":"有保障更安心"],["imgName":"balance","title":"淘宝众筹","des":"认真对待每一个梦想"],["imgName":"charity","title":"爱心捐赠","des":"我要捐赠"],["imgName":"charity","title":"蚂蚁公益","des":"进入公益"],["imgName":"tipIcon1","title":"我的保障","des":"有保障更安心"],["imgName":"balance","title":"淘宝众筹","des":"认真对待每一个梦想"],["imgName":"charity","title":"爱心捐赠","des":"我要捐赠"],["imgName":"charity","title":"蚂蚁公益","des":"进入公益"],["imgName":"tipIcon1","title":"我的保障","des":"有保障更安心"],["imgName":"balance","title":"淘宝众筹","des":"认真对待每一个梦想"],["imgName":"charity","title":"爱心捐赠","des":"我要捐赠"],["imgName":"charity","title":"蚂蚁公益","des":"进入公益"]];
        dataSource.add(sectionArray2)
    
    }
    
    func initCollectionView() {
    let defaultLayout = UICollectionViewFlowLayout()
        defaultLayout.scrollDirection = UICollectionViewScrollDirection.vertical//设置垂直显示
        defaultLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)//设置边距
        defaultLayout.itemSize = CGSize(width: kScreenWidth/2, height: 50)
        defaultLayout.minimumLineSpacing = 0.0 //每个相邻的layout的上下间隔
        defaultLayout.minimumInteritemSpacing = 0.0 //每个相邻layout的左右间隔
        defaultLayout.headerReferenceSize = CGSize(width: 0, height: 0)
        defaultLayout.footerReferenceSize = CGSize(width: 0, height: 15)
        
        collectionView = UICollectionView(frame: CGRect(x:0, y:0, width:kScreenWidth, height:kScreenHeight), collectionViewLayout: defaultLayout)
        collectionView?.backgroundColor = UIColor.lightGray
        collectionView?.register(MoneyCollectionViewCell.self, forCellWithReuseIdentifier: cellMIdentifier)

        collectionView?.dataSource = self
        collectionView?.delegate = self
        self.view.addSubview(collectionView!)
    }
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count;
    }
    
    // 每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        let sectionArray:NSArray =  dataSource.object(at: section) as! NSArray
        return sectionArray.count;
    }
    //显示cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:MoneyCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellMIdentifier, for: indexPath as IndexPath) as! MoneyCollectionViewCell
        let sectionArray:NSArray = dataSource.object(at: indexPath.section) as! NSArray
        let rowDic:NSDictionary = sectionArray.object(at: indexPath.row) as! NSDictionary
        cell.rowDic = rowDic
        return cell;
    }
    //点击item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("点击了第\(indexPath.section) 分区 ,第\(indexPath.row) 个元素")
    }
    //item的size
    private func collectionView(collectionView: UICollectionView!,
                                layout collectionViewLayout: UICollectionViewLayout!,
                                sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSize(width: kScreenWidth/2.0, height: 81)
    }
    
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //设置HeaderView的宽高
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width:collectionView.frame.size.width,height:20)
        
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
