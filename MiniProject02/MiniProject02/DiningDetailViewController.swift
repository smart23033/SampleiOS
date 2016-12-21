//
//  DiningDetailViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 21..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
import Kanna
import Alamofire

class DiningDetailViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrapeBlogURL()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrapeBlogURL(){
        
        let url = URL(string: "https://search.naver.com/search.naver?where=post&sm=tab_jum&ie=utf8&query=%EC%84%B1%EC%88%98%EC%A1%B1%EB%B0%9C")
      
        if let doc = HTML(url: url!, encoding: .utf8) {
           
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    
}
