//
//  NewsDetailViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 20..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit
//import Alamofire
import Kanna

class NewsDetailViewController: UITableViewController {
    
    @IBOutlet var navibar: UINavigationItem!
    
    var nvo : NewsVO? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Symbol", size: 17)!, NSForegroundColorAttributeName: UIColor.white]
        
        navibar.title = nvo?.title
        
        print("link : \(nvo?.link)")
        
        callNewsDetailSource()
        
    }
    
    func callNewsDetailSource(){
        
        let url = nvo?.link!
/*
        Alamofire.request(url!).response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("data_utf8 : \(utf8Text)")
                
            }
        }
*/
        
        if let doc = HTML(html: url!, encoding: .utf8) {
            print(doc.xpath(".//div"))
        }
        
 }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
