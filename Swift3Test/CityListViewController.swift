//
//  CityListViewController.swift
//  Swift3Test
//
//  Created by Miaoz on 16/12/27.
//  Copyright © 2016年 Miaoz. All rights reserved.
//

import UIKit
import CoreLocation

//声明一个protocal，必须继承NSObjectProtocal
protocol ChangeCity:NSObjectProtocol{
    func ChangeCityWithCityName(cityName:String)
}


class CityListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate {
    var currentCityLabel:UILabel?
    var tableView:UITableView?
    var cities:NSDictionary?
    var keys:[String]?
    weak var delegate:ChangeCity?
    var locationManager: CLLocationManager = CLLocationManager()
    var currLocation: CLLocation!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择城市"
         locationManager = CLLocationManager()
        //        if self.locationManager.responds(to: #selector("requestAlwaysAuthorization")) {
        //            print("requestAlwaysAuthorization")
        //            if #available(iOS 8.0, *) {
        //                self.locationManager.requestAlwaysAuthorization()
        //            } else {
        //                // Fallback on earlier versions
        //            }
        //        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        loaddata()
        initUI()
        
    }

    
    
    func loaddata() {
        let path:String = Bundle.main.path(forResource: "citydict", ofType: "plist")!
        cities = NSDictionary(contentsOfFile: path)
        
        let allkays = cities!.allKeys as NSArray
        let sortedStates = allkays.sortedArray(using: #selector(NSNumber.compare(_:)))
        keys = sortedStates as? Array<String>
    }
    
    private func initUI() {
        let headerLabel = UILabel(frame:  CGRect(x: 0, y: kNavbarHeight, width: kScreenWidth, height: 20))
        headerLabel.text = "    当前城市"
        headerLabel.backgroundColor = kBackGroundColor
        view.addSubview(headerLabel)
    
        currentCityLabel = UILabel(frame:  CGRect(x: headerLabel.frame.origin.x, y: headerLabel.frame.origin.y+headerLabel.frame.size.height, width: headerLabel.frame.size.width, height: headerLabel.frame.size.height+10))
        currentCityLabel!.backgroundColor = UIColor.white
        currentCityLabel?.textColor = UIColor.orange
        currentCityLabel?.isUserInteractionEnabled = true
        view.addSubview(currentCityLabel!)
        
        let tap = UITapGestureRecognizer(target:self, action:#selector(tapToChangeCity(sender:)))
        currentCityLabel?.addGestureRecognizer(tap)
        
        tableView = UITableView(frame: CGRect(x: (currentCityLabel?.frame.origin.x)!, y: (currentCityLabel?.frame.origin.y)!+(currentCityLabel?.frame.size.height)!, width: (currentCityLabel?.frame.size.width)!, height: (kScreenHeight-(currentCityLabel?.frame.size.height)!)-headerLabel.frame.size.height), style: .plain)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
        
    }
   
    func tapToChangeCity(sender:UITapGestureRecognizer){
        if((currentCityLabel?.text?.isEmpty) == nil){
            return
        }
        let city:String = ((currentCityLabel?.text)! as NSString).substring(from: 4)
        delegate?.ChangeCityWithCityName(cityName: city)
        navigationController?.popViewController(animated: true)
    }
    
    //UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return (keys?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let keys_:NSArray = NSArray(array: keys!);
        let key = keys_.object(at: section)
        
        let temp:NSArray = (cities?.object(forKey: key))! as! NSArray
        return temp.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView .dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let keysTemp:NSArray = NSArray(array: keys!);
        
        let key = keysTemp.object(at: indexPath.section)
        
        let temp:NSArray = (cities?.object(forKey: key))! as! NSArray
        
        cell.textLabel?.text = temp.object(at: indexPath.row) as? String
        return cell
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
        
    }
    
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        
        
        headerLabel.backgroundColor = kBackGroundColor
        let keys_:NSArray = NSArray(array: keys!);
        
        let key = keys_.object(at: section)
        let textString = "    "+(key as? String)!;
        headerLabel.text = textString
        return headerLabel
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let keysTemp:NSArray = NSArray(array: keys!);
        
        let key = keysTemp.object(at: indexPath.section)
        
        let temp:NSArray = (cities?.object(forKey: key))! as! NSArray
        
        self.delegate?.ChangeCityWithCityName(cityName: temp.object(at: indexPath.row) as! String)
        navigationController?.popViewController(animated: true)
        
    }

    //CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        currLocation = locations.last! as CLLocation
        //        longitudeTxt.text = "\(currLocation.coordinate.longitude)"
        //        latitudeTxt.text = "\(currLocation.coordinate.latitude)"
        //        HeightTxt.text = "\(currLocation.altitude)"
        self.reverseGeocode(sender: currLocation)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        
        print(error)
    }
    
    func reverseGeocode(sender: AnyObject) {
        let geocoder = CLGeocoder()
        var p:CLPlacemark?
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
            let pm = placemarks! as [CLPlacemark]
            if (pm.count > 0){
                p = placemarks![0]
                //                let arrayforProvince:Array = (p?.name!.componentsSeparatedByString("省"))!
                
                
                guard p != nil
                    else {
                        return
                }
                
                
                let arrayforProvince:[String] = (p!.name?.components(separatedBy:"省"))!
                
                
                let city:String = arrayforProvince.last!
                
                let  arrayforcity:[String] = (city.components(separatedBy:("市")))
                
                self.currentCityLabel?.text = "    " + (arrayforcity.first)!
                
                
            }else{
                print("No Placemarks!")
            }
        })
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
