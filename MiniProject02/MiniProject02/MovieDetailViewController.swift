//
//  MovieDetailViewController.swift
//  MiniProject02
//
//  Created by 김성준 on 2016. 12. 1..
//  Copyright © 2016년 sungjun. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var webview: UIWebView!
    @IBOutlet var navibar: UINavigationItem!
    
    var mvo : MovieVO? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navibar.title = self.mvo?.title
        
        let req = URLRequest(url: URL(string: (self.mvo?.link)!)!)
        self.webview.loadRequest(req)
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
