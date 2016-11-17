//
//  ViewController.m
//  SampleGSignIn
//
//  Created by 김성준 on 2016. 11. 2..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(receiveToggleAuthUINotification:)
     name:@"ToggleAuthUINotification"
     object:nil];
    
    [self toggleAuthUI];
    [self statusText].text = @"Google Sign in\niOS Demo";
    
}

// Signs the user out of the application for scenarios such as switching
// profiles.
// [START signout_tapped]
- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    // [START_EXCLUDE silent]
    [self toggleAuthUI];
    // [END_EXCLUDE]
}
// [END signout_tapped]

// Note: Disconnect revokes access to user data and should only be called in
//     scenarios such as when the user deletes their account. More information
//     on revocation can be found here: https://goo.gl/Gx7oEG.
// [START disconnect_tapped]
- (IBAction)didTapDisconnect:(id)sender {
    [[GIDSignIn sharedInstance] disconnect];
}
// [END disconnect_tapped]

- (void)toggleAuthUI {
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
        // Not signed in
        [self statusText].text = @"Google Sign in\niOS Demo";
        self.signInButton.hidden = NO;
        self.signOutButton.hidden = YES;
        self.disconnectButton.hidden = YES;
    } else {
        // Signed in
        self.signInButton.hidden = YES;
        self.signOutButton.hidden = NO;
        self.disconnectButton.hidden = NO;
    }
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
    NSLog(@"Customer details: %@ %@ %@ %@", userId, idToken, name, email);
    // ...
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"ToggleAuthUINotification"
     object:nil];
    
}

- (void) receiveToggleAuthUINotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ToggleAuthUINotification"]) {
        [self toggleAuthUI];
        self.statusText.text = [notification userInfo][@"statusText"];
    }
}


@end
