//
//  ViewController.m
//  SampleImagePicker
//
//  Created by 김성준 on 2016. 10. 18..
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


- (IBAction)pickImage:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = true;
    picker.delegate = self;
    
    [self presentViewController:picker animated:false completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:false completion:nil];
    
    self.imgView.image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:false completion:nil];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"이미지 선택이 취소되었습니다." preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:nil]];

}

@end
