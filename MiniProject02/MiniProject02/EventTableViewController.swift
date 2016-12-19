//
//  EventTableViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 5..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

class EventTableViewController: UITableViewController {

    @IBOutlet var moreBtn: UIButton!
    
    var list = Array<EventVO>()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callEventAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setThemeUsingPrimaryColor(UIColor.white, with: .light)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    
    func getThumbnailImage(index:Int) -> UIImage{
        let evo = self.list[index]
        
        if let savedImage = evo.thumbnailImage{
            return savedImage
        }else{
            let thumbnailURL = URL(string: evo.thumbnail!)
            let imageData = NSData(contentsOf: thumbnailURL!)
            
            evo.thumbnailImage = UIImage(data: imageData as! Data)
            
            return evo.thumbnailImage!
        }
    }
    
    @IBAction func clickMore(_ sender: Any) {
        self.page += 1
        
        callEventAPI()
    }

    func callEventAPI(){
//        url = http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=XA8IjK1LvJAa%2FZKTSiUwKYi%2F7mUrQhEPi6NRK2SIuYldbzDWu3sqEukGU1XhvuwdVoPBlmByG%2FOBEgLxLoph4g%3D%3D&eventStartDate=20161205&eventEndDate=&areaCode=1&sigunguCode=&cat1=A02&cat2=&cat3=&listYN=Y&MobileOS=ETC&MobileApp=TourAPI3.0_Guide&arrange=A&numOfRows=12&pageNo=1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let today = NSDate()
        let convertedDate = dateFormatter.string(from: today as Date)

        let url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=XA8IjK1LvJAa%2FZKTSiUwKYi%2F7mUrQhEPi6NRK2SIuYldbzDWu3sqEukGU1XhvuwdVoPBlmByG%2FOBEgLxLoph4g%3D%3D"
        
        let parameters : Parameters = [
            "eventStartDate" : convertedDate,
//            "areaCode" : "1",  //서울
            "cat1":"A02",
            "listYN":"Y",
            "MobileOS":"ETC",
            "MobileApp":"TourAPI3.0_Guide",
            "arrange":"A",
            "numOfRows":"10",
            "pageNo":page
        ]
        
        Alamofire.request(url, parameters:parameters).response { response in
//            print("Request: \(response.request)")
//            print("Response: \(response.response)")
//            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("data_utf8 : \(utf8Text)")
                
                let xml = SWXMLHash.parse(utf8Text)
                let item = xml["response"]["body"]["items"]["item"]
                
                for row in item {
                    
                    let evo = EventVO()
                    evo.title = row["title"].element?.text
                    evo.startDate = row["eventstartdate"].element?.text
                    evo.endDate = row["eventenddate"].element?.text
                    evo.thumbnail = row["firstimage"].element?.text
                    evo.contentId = row["contentid"].element?.text
                    evo.contentType = row["contenttypeid"].element?.text
                    
                    self.list.append(evo)
                    
                }
                
                self.tableView.reloadData()
            
                let totalCount = Int((xml["response"]["body"]["totalCount"].element?.text!)!)
                if self.list.count >= totalCount!{
                    self.moreBtn.isHidden = true
                }
            }
            
        }
       
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        print("title : \(row.title)")
        
        cell.titleLabel?.text = row.title
        cell.startDateLabel?.text = row.startDate
        cell.endDateLabel?.text = row.endDate
        
        if row.thumbnail != nil{
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = self.getThumbnailImage(index: indexPath.row)
            }
        } else{
            cell.thumbnailImageView.image = nil
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Touch Table Row at %d", indexPath.row)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "event_detail_segue" {
            let cell = sender as! EventCell;
            
            let path = self.tableView.indexPath(for: cell)
            
            let param = self.list[path!.row];
            
            (segue.destination as? EventDetailViewController)?.evo = param
        }
    }
 

}
