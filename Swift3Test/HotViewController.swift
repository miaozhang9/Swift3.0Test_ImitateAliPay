//
//  HotViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/30.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

class HotViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //声明两个存放字符串的数组
    var nowClassName = [String]()
    var surplusClassName = [String]()
    
    //是否排序
    var isRank = Bool()
    
    var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:80,height:35)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self;
        //注册一个cell
        collectionView!.register(HotCell.self, forCellWithReuseIdentifier:"HotCell")
        //注册区头
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(collectionView!)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(viewCustom(_ :)))
        collectionView?.addGestureRecognizer(gesture)
        
        saveData()
        // Do any additional setup after loading the view.
    }

    func viewCustom(_ longPress:UILongPressGestureRecognizer){
        
        let point:CGPoint = longPress.location(in: longPress.view)
        
        let indexPath = self.collectionView?.indexPathForItem(at: point)
        
        switch longPress.state {
        case .began:
            
            self.collectionView?.beginInteractiveMovementForItem(at: indexPath!)
            break
        case .changed:
            self.collectionView?.updateInteractiveMovementTargetPosition(point)
            
            break
            
        case .ended:
            self.collectionView?.endInteractiveMovement()
            break
            
        default:
            self.collectionView?.cancelInteractiveMovement()
            break
        }
        
    }
    
    //添加数据
    private func saveData() {
        nowClassName += ["A-1","A-2","A-3","A-4","A-5","A-6","A-7","A-8","A-9","A-10","A-11"]
        surplusClassName += ["B-1","B-2","B-3","B-4","B-5","B-6","B-7","B-8","B-9","B-10","B-11"]
        
    }
    
    // MARK: 代理
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return nowClassName.count
        }else {
            
            if !isRank {
                return surplusClassName.count
            }else{
                return 0
            }
        }
        
    }
    
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if !isRank {
            return 2
        }
        
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotCell", for: indexPath) as! HotCell
        cell.backgroundColor = UIColor.orange
        if indexPath.section == 0 {
            cell.label.text = nowClassName[indexPath.item]
            cell.button.addTarget(self, action: #selector(removeItem(_ :)), for: .touchUpInside)
            cell.button.tag = indexPath.row
            
            cell.button.isHidden = !isRank
            
        }else{
            cell.label.text = surplusClassName[indexPath.item]
            cell.button.isHidden = true
            
        }
        return cell
        
    }
    
    func removeItem(_ button:UIButton){
        
        //执行在这里的时候,显示的是有个分区,否则崩溃,报不明错误!,研究过的可以告诉一下,不胜感激!!!
        self.collectionView?.performBatchUpdates({
            //数据变更
            let item = self.nowClassName[button.tag]
            self.nowClassName.remove(at: button.tag)
            self.surplusClassName.append(item)
            
            
            let indexPath = IndexPath.init(item: button.tag, section: 0)
            print(indexPath)
            
            let arr:[IndexPath] = [indexPath]
            self.collectionView?.deleteItems(at: arr)
            
            }, completion: { (completion) in
                
                self.collectionView?.reloadData()
        })
        
    }
    
    //是否可以移动
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        if isRank {
            return true
        }
        return false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //获取当前 item
        //collectionView.cellForItem(at: indexPath)
        //获取所有的item
        //collectionView.indexPathsForVisibleItems
        
        if !isRank && indexPath.section == 1{
            //先把数据更新好,因为移动后界面会自动刷新,否则会崩溃
            nowClassName.append(surplusClassName[indexPath.item])
            surplusClassName.remove(at: indexPath.item)
            
            let indexPath1 = NSIndexPath.init(item: nowClassName.count-1, section: 0)
            let indexPath2 = NSIndexPath.init(item: indexPath.item, section: 1)
            
            //从当前位置移动到新的位置
            collectionView.moveItem(at: indexPath2 as IndexPath, to: indexPath1 as IndexPath)
        }
        
    }
    
    
    //设置拖动(手势拖动触发)
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //        if sourceIndexPath.section == 0 && destinationIndexPath.section == 0 {
        //            collectionView.exchangeSubview(at: sourceIndexPath.item, withSubviewAt: destinationIndexPath.item)
        //        }
        
    }
    
    //区头设置
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //
        //区头
        var headerView : UICollectionReusableView?
        
        if kind == UICollectionElementKindSectionHeader{
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath)
            
            //防止重用,这样很暴力
            for view in (headerView?.subviews)!{
                view.removeFromSuperview()
                
            }
            
            let label = UILabel.init(frame: CGRect(x:20,y:0,width:160,height:30))
            if indexPath.section == 0 {
                label.text = "切换栏目"
                
                let button = UIButton.init(type: .custom)
                button.frame = CGRect(x:collectionView.frame.size.width - 100,y:0,width:80,height:30)
                button.titleLabel?.textColor = UIColor.cyan
                button.backgroundColor = UIColor.white
                
                let str = isRank ? "完成排序" : "排序删除"
                button.setTitle(str, for: .normal)
                button.setTitleColor(UIColor.red, for: .normal)
                headerView?.addSubview(button)
                
                button.addTarget(self, action: #selector(click(_ :)), for: .touchUpInside)
                
                
            }else if indexPath.section == 1{
                label.text = "点击添加更多栏目"
            }
            headerView?.addSubview(label)
            
        }
        
        return headerView!
        
        
    }
    
    func click(_ btn:UIButton){
        
        let str = isRank ? "完成排序" : "排序删除"
        btn.setTitle(str, for: .normal)
        
        isRank = !isRank
        print(isRank)
        self.collectionView?.reloadData()
    }
    
    //设置HeaderView的宽高
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width:collectionView.frame.size.width,height:35)
        
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
