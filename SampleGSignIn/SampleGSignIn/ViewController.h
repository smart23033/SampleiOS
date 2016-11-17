//
//  ViewController.h
//  SampleGSignIn
//
//  Created by 김성준 on 2016. 11. 2..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface ViewController : UIViewController<GIDSignInDelegate>

@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property (weak, nonatomic) IBOutlet UILabel *statusText;

- (IBAction)didTapDisconnect:(id)sender;
- (IBAction)didTapSignOut:(id)sender;

@end

