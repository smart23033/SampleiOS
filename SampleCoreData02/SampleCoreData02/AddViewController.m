//
//  AddViewController.m
//  SampleCoreData02
//
//  Created by 김성준 on 2016. 10. 28..
//  Copyright © 2016년 poppay. All rights reserved.
//
#import "AddViewController.h"

@interface AddViewController (){
    NSManagedObjectContext *context;
    AppDelegate *ad;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = [[ad persistentContainer] viewContext];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)touchUpSave:(id)sender {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"AddressBook" inManagedObjectContext:context];
    AddressBook *addressBook = [[AddressBook alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    NSDateFormatter *today = [NSDateFormatter new];
    [today setDateFormat:@"yyyy-MM-dd"];

    addressBook.name = _nameField.text;
    addressBook.address = _addressField.text;
    addressBook.phone = _phoneField.text;
    addressBook.dtime = [today stringFromDate:[NSDate date]];
    
    @try{
        NSError *error = nil;
        [context save:&error];
        
        _nameField.text = @"";
        _addressField.text =  @"";
        _phoneField.text =  @"";
        
        NSLog(@"Address added");
        
         [self dismissViewControllerAnimated:true completion:nil];
        
    }
    @catch(NSError *error){
         NSLog(@"Error : %@",[error localizedFailureReason]);
    }
}

@end
