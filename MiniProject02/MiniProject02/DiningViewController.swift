//
//  DiningViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 1..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class DiningViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    var didUpdateLocation = false
    var list = Array<EateryVO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //user location stuff
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error" + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !didUpdateLocation else { return }
       
        didUpdateLocation = true
        userLocation = locations.last!
//        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                                          longitude: userLocation.coordinate.longitude, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
//        let marker = GMSMarker()
//        marker.position = center
//        marker.title = "Current Location"
//        marker.snippet = "XXX"
//        marker.map = mapView
        
        locationManager.stopUpdatingLocation()

        callTmapAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func markPOI(){
        
        for row in self.list{
            let position = CLLocationCoordinate2DMake(row.latitude!,row.longitude!)
            let marker = GMSMarker(position: position)
            marker.title = row.name!
            marker.map = self.view as! GMSMapView?
        }
    }
    
    func callTmapAPI(){
       
        //    apiKey = 47be8fe9-5a9c-3193-836c-cbd939a3753e
        //    Example of API call:
        /*
         https://apis.skplanetx.com/tmap/pois/search/around?centerLon=127.05551147&centerLat=37.54484953&count=&page=&reqCoordType=WGS84GEO&callback=&multiPoint=&radius=1&categories=식음료&resCoordType=WGS84GEO&version=1
         */
        
        let url = "https://apis.skplanetx.com/tmap/pois/search/around"
        
        let headers = [
            "Accept": "application/json",
            "appKey": "47be8fe9-5a9c-3193-836c-cbd939a3753e"
        ]
        
        let parameters: Parameters = [
            "version": "1",
            "centerLat": "\(userLocation.coordinate.latitude)",
            "centerLon": "\(userLocation.coordinate.longitude)",
            "categories": "TV맛집",
            "reqCoordType":"WGS84GEO",
            "resCoordType":"WGS84GEO"
        ]
        
        Alamofire.request(url, parameters:parameters, headers:headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
               
                let json = JSON(value)
//                print("JSON : \(json)")
               
//              response alert
//                let alert = UIAlertController(title: "API RESULT", message: "\(json)", preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//                alert.addAction(cancelAction)
//                self.present(alert, animated: false, completion: { _ in })

                let poiList = json["searchPoiInfo"]["pois"]["poi"]
                
//                print("poi : \(poiList)")
                
                for row in poiList {
                    let evo = EateryVO()
                    
                    evo.name = row.1["name"].stringValue
                    evo.latitude = row.1["noorLat"].doubleValue
                    evo.longitude = row.1["noorLon"].doubleValue
                    
                    self.list.append(evo)
                }
                
//                print poiList
//                var count = 0
//                for row in self.list{
//                    count += 1
//                    print("[\(count)] name : \(row.name!)\tlat : \(row.latitude!)\tlng : \(row.longitude!)")
//                }
                
                self.markPOI()
                
            case .failure(let error):
                print(error)
            }
            
        }
        
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
