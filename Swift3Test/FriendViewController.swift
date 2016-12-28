//
//  FriendViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

let cellIdentifier:String = "cell"

class FriendViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate{
    var tableView:UITableView?
    var dataArray: Array? = [Array<FriendModel>]()
    var dataSection0Array:Array? = [FriendModel]()
    var dataSection1Array:Array? = [FriendModel]()
    //
    func loadData(){
        
        let friend0:FriendModel = FriendModel(userName: "就是个名字", userId: String(0), photo: "http://pic.ihk.cn/first/287_h/ihk/2012/10/31/104012571.jpg")
        let friend1:FriendModel = FriendModel(userName: "就是个名字1", userId: String(1), photo: "http://pic.ihk.cn/first/287_h/ihk/2015/06/17/092631098.jpg")
        let friend8:FriendModel = FriendModel(userName: "就是个名字8", userId: String(8), photo: "http://pic.ihk.cn/first/287_h/ihk/2012/10/31/104012571.jpg")
        let friend9:FriendModel = FriendModel(userName: "就是个名字9", userId: String(9), photo: "http://pic.ihk.cn/first/287_h/ihk/2012/10/31/104012571.jpg")
    
        dataSection0Array?.append(friend0)
        dataSection0Array?.append(friend1)
        dataSection1Array?.append(friend8)
        dataSection1Array?.append(friend9)
        
        dataArray?.append(dataSection0Array!)
        dataArray?.append(dataSection1Array!)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "朋友"
        loadData()
        initTableView()
        // Do any additional setup after loading the view.
    }
    
    //创建tableView
    private func initTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.register(FriendCell.self, forCellReuseIdentifier: cellIdentifier)
//        tableView?.register(UINib(nibName: "FriendCell",bundle: nil), forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView!)
        
        //添加手势
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        tableView!.addGestureRecognizer(longPress)
        
    }
    
    //长按编辑
    func longPressAction(recognizer:UILongPressGestureRecognizer)  {
        
        if recognizer.state == UIGestureRecognizerState.began {
            print("UIGestureRecognizerStateBegan");
        }
        if recognizer.state == UIGestureRecognizerState.changed {
            print("UIGestureRecognizerStateChanged");
        }
        if recognizer.state == UIGestureRecognizerState.ended {
            print("UIGestureRecognizerStateEnded");
            
            if tableView!.isEditing == true {
                tableView!.isEditing = false
            }
            else
            {
                tableView!.isEditing = true
            }
            
            tableView!.reloadData()
        }
    }

    //分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray!.count;
    }
    //分区行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return dataArray![section].count;
    }
    // 分区头部title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "添加功能"
        }
        return "删除功能";
    }
    // 分区尾部title
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let data = self.dataArray![section]
        return "有\(data.count)个控件"
    }
    //cell行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 79;
    }
    //显示cell内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:FriendCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! FriendCell
        let model: FriendModel = dataArray![indexPath.section][indexPath.row] as FriendModel
        cell.friendModel = model
        return cell
    }
    //头部高度
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.01
//    }
//    
//    //底部高度
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01
//    }
    //点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        // 确定该分组的内容
        let model:FriendModel = (self.dataArray?[indexPath.section][indexPath.row])!
        print("str\(model.userName)")
    }
    //允许编辑cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    //右滑触发删除按钮
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 0 {
            
            return UITableViewCellEditingStyle.insert
        }
        else
        {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    //点击删除cell时触发
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("indexPath.row = editingStyle第\(indexPath.row)行")
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.dataArray?[indexPath.section].remove(at: indexPath.row)
            tableView.setEditing(false, animated: true)
        }
            
        else if editingStyle == UITableViewCellEditingStyle.insert
        {
              let tempfriend:FriendModel = FriendModel(userName: "添加添加就是个名字", userId: String(describing: self.dataArray?[indexPath.section].count), photo: "http://pic.ihk.cn/first/287_h/ihk/2012/10/31/104012571.jpg")
            self.dataArray?[indexPath.section].insert(tempfriend, at: indexPath.row)
            tableView.setEditing(false, animated: true)
        }
        
        tableView.reloadData()
    }
    
    // 设置确认删除按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "确认删除"
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
