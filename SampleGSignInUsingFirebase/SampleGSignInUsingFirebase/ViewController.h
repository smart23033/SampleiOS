//
//  ViewController.h
//  SampleGSignInUsingFirebase
//
//  Created by 김성준 on 2016. 11. 2..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface ViewController : UIViewController<GIDSignInDelegate>

@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
- (IBAction)signOutClicked:(id)sender;

@end
