//
//  EventDetailViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 6..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

class EventDetailViewController: UITableViewController {
    
    static let TABLE_COUNT = 2
    var evo : EventVO? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//                self.navigationController?.navigationBar.tintColor = UIColor.flatMintDark
//                self.navigationController?.navigationBar.shadowImage = UIImage()
//                self.navigationController?.navigationBar.isTranslucent = true
        
        callDetailCommonAPI(){
            self.addFooterView()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callDetailCommonAPI(completionHandler:@escaping () -> Void){
        
        //        http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=XA8IjK1LvJAa%2FZKTSiUwKYi%2F7mUrQhEPi6NRK2SIuYldbzDWu3sqEukGU1XhvuwdVoPBlmByG%2FOBEgLxLoph4g%3D%3D&contentTypeId=15&contentId=1765320&MobileOS=ETC&MobileApp=TourAPI3.0_Guide&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&transGuideYN=Y
        
        
        var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=XA8IjK1LvJAa%2FZKTSiUwKYi%2F7mUrQhEPi6NRK2SIuYldbzDWu3sqEukGU1XhvuwdVoPBlmByG%2FOBEgLxLoph4g%3D%3D"
        
        var parameters : Parameters = [
            "contentTypeId" : "\(evo!.contentType!)",
            "contentId" : "\(evo!.contentId!)",
            "MobileOS" : "ETC",
            "MobileApp" : "TourAPI3.0_Guide",
            "defaultYN" : "Y",
            "firstImageYN" : "Y",
            "areacodeYN" : "Y",
            "catcodeYN" : "Y",
            "addrinfoYN" : "Y",
            "mapinfoYN" : "Y",
            "overviewYN" : "Y",
            "transGuideYN" : "Y"
        ]
        
        Alamofire.request(url, parameters:parameters).response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("first data_utf8 : \(utf8Text)")
                
                let xml = SWXMLHash.parse(utf8Text)
                let item = xml["response"]["body"]["items"]["item"]
                
                self.evo?.longitude = item["mapx"].element?.text
                self.evo?.latitude = item["mapy"].element?.text
                self.evo?.overview = item["overview"].element?.text

                completionHandler();
                
                self.tableView.reloadData()
            }
        }
        
        url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?ServiceKey=XA8IjK1LvJAa%2FZKTSiUwKYi%2F7mUrQhEPi6NRK2SIuYldbzDWu3sqEukGU1XhvuwdVoPBlmByG%2FOBEgLxLoph4g%3D%3D"
        
         parameters = [
            "contentTypeId" : "\(evo!.contentType!)",
            "contentId" : "\(evo!.contentId!)",
            "MobileOS" : "ETC",
            "MobileApp" : "TourAPI3.0_Guide",
            "introYN" : "Y"
        ]
        
        Alamofire.request(url, parameters:parameters).response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("second data_utf8 : \(utf8Text)")
                
                let xml = SWXMLHash.parse(utf8Text)
                let item = xml["response"]["body"]["items"]["item"]
                
                self.evo?.ageLimit = item["agelimit"].element?.text
                self.evo?.discountInfoFestival = item["discountinfofestival"].element?.text
                self.evo?.eventPlace = item["eventplace"].element?.text
                self.evo?.playTime = item["playtime"].element?.text
                self.evo?.sponsor = item["sponsor1"].element?.text
                self.evo?.useTimeFestival = item["usetimefestival"].element?.text
                self.evo?.sponsorTel = item["sponsor1tel"].element?.text
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    func addFooterView(){
//        print("lat : \(evo!.latitude!)")
//        print("lng : \(evo!.longitude!)")
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let footerView = Bundle.main.loadNibNamed("EventMap", owner: self, options: nil)?.first as! EventMapView
        footerView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 340)
        
        let latitude:String = (evo!.latitude)!
        let longitude:String = (evo!.longitude)!
        
        do{
            
            let imageURL = URL(string: "http://maps.googleapis.com/maps/api/staticmap?center=\(latitude),\(longitude)&zoom=13&scale=false&size=600x300&maptype=roadmap&format=png&visual_refresh=true&markers=size:mid%7C\(latitude),\(longitude)")
            
            let imageData = try Data(contentsOf: imageURL!)
            footerView.mapImageView.image = UIImage(data: imageData)
            
            tableView.tableFooterView = footerView
            
        }catch{
            print(error)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventDetailViewController.TABLE_COUNT
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            
            cell.eventImageView.image = evo?.thumbnailImage
            cell.titleLabel.text = evo?.title
            cell.startDate.text = evo?.startDate
            cell.endDate.text = evo?.endDate
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IntroCell") as! IntroCell
            
            cell.overviewLabel.text = evo?.overview
            cell.discountInfoFestivalLabel.text = evo?.discountInfoFestival
            cell.eventPlaceLabel.text = evo?.eventPlace
            cell.playTimeLabel.text = evo?.playTime
            cell.sponsorLabel.text = evo?.sponsor
            cell.sponsorTelLabel.text = evo?.sponsorTel
            cell.useTimeFestivalLabel.text = evo?.useTimeFestival
            cell.ageLimitLabel.text = evo?.ageLimit
            
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 310
        } else if indexPath.row == 1{
            return 390
        } else{
            return 0
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
