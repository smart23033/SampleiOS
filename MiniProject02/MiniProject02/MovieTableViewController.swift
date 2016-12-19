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

class MovieTableViewController: UITableViewController {
    
    var list = Array<MovieVO>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callKobisAPI(){ movieName in
            print("movieName : \(movieName)")
            
            for row in movieName!{
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
        kobisProvider.request(Kobis.showBoxOffice){ result in
            switch result {
            case let .success(response) :
                do{
                    var movieName = Array<String>()
                    let json = try JSON(response.mapJSON())
                    print("Kobis JSON: \(json)")
                    let boxOfficeResult = json["boxOfficeResult"]
                    let dailyBoxOfficeList = boxOfficeResult["dailyBoxOfficeList"]
                    
                    for row in dailyBoxOfficeList{
                        let mvo = MovieVO()
                        
                        mvo.title = row.1["movieNm"].stringValue
                        mvo.openDate = row.1["openDt"].stringValue
                        mvo.audiAcc = row.1["audiAcc"].stringValue
                        
                        movieName.append(mvo.title!)
                        self.list.append(mvo)
                        
                    }
                    
                    completionHandler(movieName)
                }catch{
                    print("error")
                }
            case let .failure(error) :
                print("error : \(error)")
                
            }
        }
    }
    
    func callNaverAPI(title:String){
        var thumbnail : String?
        var rating : Float?
        var link : String?
        
        naverProvider.request(Naver.showMovieInfo(title)){result in
            switch result {
            case let .success(response) :
                do{
                    let json = try JSON(response.mapJSON())
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
                    
                }catch{
                    print("error")
                }
            case let .failure(error) :
                print("error : \(error)")
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


