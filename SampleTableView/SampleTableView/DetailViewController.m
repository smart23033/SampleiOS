//
//  DetailViewController.m
//  SampleTableView
//
//  Created by 김성준 on 2016. 10. 21..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize mvo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"linkURL = %@, title = %@",self.mvo.detail,self.mvo.title);
    self.wv.delegate = self;
    self.navibar.title = self.mvo.title;
    
    NSString *url = self.mvo.detail;
    
    if(url){
        NSURL *urlObj = [NSURL URLWithString:url];
        if(urlObj){
            
//            NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.mvo.detail]];
            NSURLRequest *req = [NSURLRequest requestWithURL:urlObj];
            [self.wv loadRequest:req];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"오류" message:@"잘못된 URL" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
            
            [self.navigationController popViewControllerAnimated:true];
            
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:false completion:nil];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"오류" message:@"필수 파라미터 누락" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
        
        [self.navigationController popViewControllerAnimated:true];
        
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:false completion:nil];
    }
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.spinner stopAnimating];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"오류" message:@"상세페이지를 불러올 수 없습니다" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
    
    [self.navigationController popViewControllerAnimated:true];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:false completion:nil];
    
}

@end
