//
//  ViewController.h
//  SampleImagePicker
//
//  Created by 김성준 on 2016. 10. 18..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)pickImage:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

