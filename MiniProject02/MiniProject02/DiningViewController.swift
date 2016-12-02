//
//  DiningViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 1..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
import GoogleMaps

class DiningViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.locationManager.requestWhenInUseAuthorization()
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
