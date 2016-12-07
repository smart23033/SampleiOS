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
    
    var evo : EventVO? = nil
    var list = Array<EventVO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.tintColor = UIColor.flatMintDark
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
        list.append(evo!)
        
        callDetailCommonAPI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callDetailCommonAPI(){
        
//        http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=XA8IjK1LvJAa%2FZKTSiUwKYi%2F7mUrQhEPi6NRK2SIuYldbzDWu3sqEukGU1XhvuwdVoPBlmByG%2FOBEgLxLoph4g%3D%3D&contentTypeId=15&contentId=1765320&MobileOS=ETC&MobileApp=TourAPI3.0_Guide&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&transGuideYN=Y
        
        
        let url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=XA8IjK1LvJAa%2FZKTSiUwKYi%2F7mUrQhEPi6NRK2SIuYldbzDWu3sqEukGU1XhvuwdVoPBlmByG%2FOBEgLxLoph4g%3D%3D"
        
        
        let parameters : Parameters = [
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
                print("data_utf8 : \(utf8Text)")
                
//                let xml = SWXMLHash.parse(utf8Text)
//                let item = xml["response"]["body"]["items"]["item"]
                

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("list count : \(self.list.count)")
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IntroCell") as! IntroCell
            
            cell.eventImageView.image = list[indexPath.row].thumbnailImage!
            cell.titleLabel.text = list[indexPath.row].title!
            
            return cell
        }else{
            let cell = UITableViewCell()
            
            return cell
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
