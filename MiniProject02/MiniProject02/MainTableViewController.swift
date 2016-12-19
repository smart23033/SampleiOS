//
//  ViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 11. 29..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import SWXMLHash

class MainTableViewController: UITableViewController{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var wvo = WeatherVO()
    var list = Array<NewsVO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Cochin-Italic", size: 24)!, NSForegroundColorAttributeName: UIColor.white]
        
        if let lat = appDelegate.locationManager.location?.coordinate.latitude,let lng = appDelegate.locationManager.location?.coordinate.longitude{
            callReverseGeoCodingAPI(lat:lat,lng:lng)
            callOpenWeatherMapAPI(lat: lat, lng: lng)
        }
        
        callNewsRSS()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setThemeUsingPrimaryColor(UIColor.white, with: .light)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setCurrentLocation(_ sender: Any) {
        print("button clicked")
    }
    
    func callNewsRSS(){
        
        let url = "http://fs.jtbc.joins.com//RSS/newsflash.xml"
        
        Alamofire.request(url).response { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("data_utf8 : \(utf8Text)")
                
                let xml = SWXMLHash.parse(utf8Text)
                
                let item = xml["rss"]["channel"]["item"]
                
                for row in item {
                    
                    let nvo = NewsVO()
                    
                    let title = row["title"].element?.text
//                    print(title!)
                    
                    nvo.title = title!
                    self.list.append(nvo)
                    
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func callOpenWeatherMapAPI(lat:CLLocationDegrees,lng:CLLocationDegrees){
//            http://api.openweathermap.org/data/2.5/weather?lat=37.5452562218505&lon=127.061169824355&appid=7123bf3dbc3ab29da45d78301b0f2e59
        
        let url = "http://api.openweathermap.org/data/2.5/weather"
        
        let parameters: Parameters = [
            "lat":"\(lat)",
            "lon":"\(lng)",
            "appid":"7123bf3dbc3ab29da45d78301b0f2e59",
            "units":"metric"
        ]
        
        Alamofire.request(url, parameters:parameters).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("lat : \(lat), lng : \(lng)")
                print("JSON : \(json)")
                
                let temperature = json["main"]["temp"].intValue
                let weatherDesc = json["weather"][0]["description"].stringValue
                
                self.wvo.temperature = temperature
                self.wvo.weatherDesc = weatherDesc
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }

    }
    
    func callReverseGeoCodingAPI(lat:CLLocationDegrees,lng:CLLocationDegrees){
              //        https://apis.skplanetx.com/tmap/geo/reversegeocoding?version={version}&lat={lat}&lon={lon}&coordType={coordType}&addressType={addressType}&callback={callback}
        
        let url = "https://apis.skplanetx.com/tmap/geo/reversegeocoding"
        
        let headers = [
            "Accept": "application/json",
            "appKey": "47be8fe9-5a9c-3193-836c-cbd939a3753e"
        ]
        
        let parameters: Parameters = [
            "version": "1",
            "lat": "\(lat)",
            "lon": "\(lng)",
            "coordType":"WGS84GEO"
        ]
        
        Alamofire.request(url, parameters:parameters, headers:headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print("lat : \(lat), lng : \(lng)")
                print("JSON : \(json)")
                
                let city = json["addressInfo"]["city_do"].stringValue
                let detailAddr = json["addressInfo"]["legalDong"].stringValue
                
                self.wvo.city = city
                self.wvo.detailAddr = detailAddr
                
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("list count : \(self.list.count)")
        return 1 + self.list.count
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
            
            if let city = wvo.city, let detailAddr = wvo.detailAddr, let temperature = wvo.temperature{
                print("\(city), \(detailAddr), \(temperature)")
                cell.addressLabel.text = "\(city) \(detailAddr)"
                cell.temperatureLabel.text = "\(temperature)"
            }
            
            if let weatherDesc = wvo.weatherDesc{
                
//                print("weather : \(weatherDesc)")
                
                switch weatherDesc {
                case "few clouds":
                    cell.weatherImageView.image = UIImage(named: "FewClouds")
                case "broken clouds":
                    cell.weatherImageView.image = UIImage(named: "BrokenClouds")
                case "clear sky":
                    cell.weatherImageView.image = UIImage(named: "Clear")
                case "Mist":
                    cell.weatherImageView.image = UIImage(named: "Mist")
                default :
                    if weatherDesc.contains("rain"){
                        cell.weatherImageView.image = UIImage(named: "Rain")
                    }
                    else if weatherDesc.contains("snow"){
                        cell.weatherImageView.image = UIImage(named: "Snow")
                    }else {
                        cell.weatherImageView.image = nil
                    }
                }
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
            let row = self.list[indexPath.row-1]
            
//            print("row : \(row), title : \(row.title)")
            cell.titleLabel.text = row.title!
            
            return cell
        }
     }
     
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }else{
            return 100
        }
     }
    
    
}

