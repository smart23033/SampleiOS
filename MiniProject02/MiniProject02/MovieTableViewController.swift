//
//  MovieTableViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 11. 29..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ChameleonFramework


class MovieTableViewController: UITableViewController {

    var list = Array<MovieVO>()
    var movieName = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callKobisAPI(){ _ in
            print(self.movieName)
            
            for row in self.movieName{
                self.callNaverAPI(title: row)
            }
        }
        
        
    }
    func getThumbnailImage(index:Int) -> UIImage{
        let mvo = self.list[index]
        
        if let savedImage = mvo.thumbnailImage{
            return savedImage
        }else{
            let thumbnailURL = URL(string: mvo.thumbnail!)
            let imageData = NSData(contentsOf: thumbnailURL!)
            
            mvo.thumbnailImage = UIImage(data: imageData as! Data)
            
            return mvo.thumbnailImage!
        }
        
    }
    
    func callKobisAPI(completionHandler: @escaping (Array<String>?) -> ()){
       
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let yesterday = NSDate().addingTimeInterval(-24 * 60 * 60)
        let convertedDate = dateFormatter.string(from: yesterday as Date)
        
        let parameters: Parameters = [
            "key": "dd511a8aba40b8ffdfef0fd2ef9f4a1c",
            "targetDt": convertedDate
        ]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print("JSON: \(json)")
                let boxOfficeResult = json["boxOfficeResult"]
                let dailyBoxOfficeList = boxOfficeResult["dailyBoxOfficeList"]
                
                for row in dailyBoxOfficeList{
                    let mvo = MovieVO()
                    
                    mvo.title = row.1["movieNm"].stringValue
                    mvo.openDate = row.1["openDt"].stringValue
                    mvo.audiAcc = row.1["audiAcc"].stringValue
                    
                    self.movieName.append(mvo.title!)
                    self.list.append(mvo)
                   
                }
                
                completionHandler(self.movieName)
                
                case .failure(let error):
                print(error)
            }
        }
    }
    
    func callNaverAPI(title:String){
        
        var thumbnail : String?
        var rating : Float?
        var link : String?
        
        let headers = [
            "X-Naver-Client-Id": "sJHZz4NN5MaIyWQknPVz",
            "X-Naver-Client-Secret": "UAnFO2Wq1t"
        ]
        
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        print("\(title)'s encodedTitle : \(encodedTitle)")
        
        let url = "https://openapi.naver.com/v1/search/movie.json?query=\(encodedTitle)&display=10&start=1"
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            print("title : \(title)")
            
            if let value = response.result.value{
                let json = JSON(value)
                print("JSON: \(json)")
                let item = json["items"][0]
                
                thumbnail = item["image"].stringValue == "" ? json["items"][1]["image"].stringValue : item["image"].stringValue
                rating = item["userRating"].floatValue
                link = item["link"].stringValue
                
                print("thumbnail : \(thumbnail)")
                print("rating : \(rating)")
                print("link : \(link)")
                
                for mvo in self.list{
                    if mvo.title == title{
                        mvo.thumbnail = thumbnail!
                        mvo.rating = rating!
                        mvo.link = link!
                    }
                }
                
                 self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
//        print("title : \(row.title)")
        
        cell.titleLabel?.text = row.title
        cell.openDateLabel?.text = row.openDate
        if row.rating != nil{
            cell.ratingLabel?.text = "\(row.rating!)"
        }
        cell.audiAccLabel?.text = row.audiAcc
        if row.thumbnail != nil{
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = self.getThumbnailImage(index: indexPath.row)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Touch Table Row at %d", indexPath.row)
    }
    
    //     MARK: - Navigation
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segue_movie_detail" {
                let cell = sender as! MovieCell
    
                let path = self.tableView.indexPath(for: cell)
    
                let param = self.list[path!.row]
    
                (segue.destination as? MovieDetailViewController)?.mvo = param
    
                print("segue")
            }
        }
}


