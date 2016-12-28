//
//  FriendViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit

let cellIdentifier:String = "cell"

class FriendViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var tableView:UITableView?
    var dataArray:Array? = [FriendModel]()
    
    func loadData(){
        for index in 0..<1 {
            let friend0:FriendModel = FriendModel(userName: "就是个名字", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2012/10/31/104012571.jpg")
            dataArray?.append(friend0)
            
            let friend1:FriendModel = FriendModel(userName: "就是个名字1", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2015/06/17/092631098.jpg")
            dataArray?.append(friend1)
            
            let friend2:FriendModel = FriendModel(userName: "就是个名字2", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2013/08/13/093640311.jpg")
            dataArray?.append(friend2)
            
            let friend3:FriendModel = FriendModel(userName: "就是个名字3", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2014/03/25/105620175.jpg")
            dataArray?.append(friend3)
            
            let friend4:FriendModel = FriendModel(userName: "就是个名字4", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2014/08/14/114609349.jpg")
            dataArray?.append(friend4)
            
            let friend5:FriendModel = FriendModel(userName: "就是个名字5", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2014/08/29/103858872.jpg")
            dataArray?.append(friend5)
            
            let friend6:FriendModel = FriendModel(userName: "就是个名字6", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2015/06/17/092631098.jpg")
            dataArray?.append(friend6)
            
            let friend7:FriendModel = FriendModel(userName: "就是个名字7", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2013/08/13/093640311.jpg")
            dataArray?.append(friend7)
            
            let friend8:FriendModel = FriendModel(userName: "就是个名字8", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2012/10/31/104012571.jpg")
            dataArray?.append(friend8)
            
            let friend9:FriendModel = FriendModel(userName: "就是个名字9", userId: String(index), photo: "http://pic.ihk.cn/first/287_h/ihk/2012/10/31/104012571.jpg")
            dataArray?.append(friend9)

            
        }
    
    
    
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initTableView()
        // Do any additional setup after loading the view.
    }
    
    private func initTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.register(FriendCell.self, forCellReuseIdentifier: cellIdentifier)
//        tableView?.register(UINib(nibName: "FriendCell",bundle: nil), forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section==0{
            return 1;
        }else{
            return dataArray!.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 79;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:FriendCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! FriendCell
        
        let model = dataArray![indexPath.row] as FriendModel
        
        cell.friendModel = model
        
        return cell
        
        
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
