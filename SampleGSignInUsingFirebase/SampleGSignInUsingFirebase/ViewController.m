//
//  ViewController.m
//  SampleGSignInUsingFirebase
//
//  Created by 김성준 on 2016. 11. 2..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"

@import Firebase;
@import FirebaseAuth;
@import GoogleSignIn;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    _signOutButton.enabled = false;
    
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      if(user){
                                          NSString *welcomMessage = [NSString stringWithFormat:@"Welcome to Firebase, %@",
                                                                     user.displayName];
                                          
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Firebase" message:welcomMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                          
                                          [alert show];
                                          _signInButton.enabled = false;
                                          _signOutButton.enabled = true;
                                      }
                                  }];
        
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}


- (IBAction)signOutClicked:(id)sender {
    FIRAuth *firebaseAuth = [FIRAuth auth];
    NSError *signOutError;
    BOOL staus = [firebaseAuth signOut:&signOutError];
    
    if(!staus){
        NSLog(@"Error signing out : %@",signOutError);
        return;
    }
    
    _signInButton.enabled = true;
    _signOutButton.enabled = false;
}
@end
