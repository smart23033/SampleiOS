//
//  ViewController.m
//  SampleFacebookLogin
//
//  Created by 김성준 on 2016. 10. 31..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    FBSDKLoginButton *loginButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(![FBSDKAccessToken currentAccessToken]){
        NSLog(@"유저가 로그인 안했다.");
    }else{
        NSLog(@"유저가 로그인 했다.");
    }
    
    loginButton = [FBSDKLoginButton new];
    loginButton.center = self.view.center;
    
    loginButton.delegate = self;
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    [self.view addSubview:loginButton];
    
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    if(!error){
        NSLog(@"로그인 성공 : %@",result);
        [self performSegueWithIdentifier:@"goHome" sender:self];
    }
    else{
        NSLog(@"Error : %@", [error localizedDescription]);
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"로그아웃 성공");
}


@end
