//
//  ViewController.m
//  SampleUIAlertController
//
//  Created by 김성준 on 2016. 10. 17..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didAlert:(id)sender {
// 기본 알림창
/*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"기본 스타일" message:@"표준 사용 알림창" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:false completion:nil];
*/
    
//    기본 액션시트창
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"표준 액션 시트창" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"저장" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addAction:cancelAction];
    [alert addAction:saveAction];
     
     [self presentViewController:alert animated:false completion:nil];
    */
    
    
//    두개이상의 버튼이 포함된 알림창
/*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"로그인 선택" message:@"원하는 로그인 방식을 선택하시오" preferredStyle:UIAlertControllerStyleAlert];
    
      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"facebook 로그인" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *kakaoAction = [UIAlertAction actionWithTitle:@"kakao 로그인" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *twitterAction = [UIAlertAction actionWithTitle:@"twitter 로그인" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cancelAction];
    [alert addAction:facebookAction];
    [alert addAction:kakaoAction];
    [alert addAction:twitterAction];
    
    [self presentViewController:alert animated:false completion:nil];
 
 */
    
//    입력필드가 있는 창림창
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"입력" message:@"로그인 정보 입력하세요" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"ID";
    }];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:false completion:nil];

    
}


@end
