//
//  ViewController.m
//  SampleCoreData
//
//  Created by 김성준 on 2016. 10. 27..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSManagedObjectContext *context;
    AppDelegate *ad;
}

@end

@implementation ViewController

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


- (IBAction)saveContact:(id)sender {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:context];
    Contacts *contact = [[Contacts alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    contact.name = _name.text;
    contact.address = _address.text;
    contact.phone = _phone.text;
    
    @try{
        NSError *error = nil;
        [context save:&error];
        
        _name.text = @"";
        _address.text =  @"";
        _phone.text =  @"";
        _status.text = @"Contact saved";
        
    }
    @catch(NSError *error){
        _status.text = [error localizedFailureReason];
    }
}

- (IBAction)findContact:(id)sender {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = entityDescription;
    
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name = %@",_name.text];
    
    request.predicate = pred;
    
    @try{
        NSArray *results = [context executeFetchRequest:request error:nil];
        
        if([results count] > 0){
            NSManagedObject *match = (NSManagedObject *)results[0];
            
            _name.text = (NSString *)[match valueForKey:@"name"];
            _address.text = (NSString *)[match valueForKey:@"address"];
            _phone.text = (NSString *)[match valueForKey:@"phone"];
            _status.text = [NSString stringWithFormat:@"Matches found : %d",(int)[results count]];
            
        }else{
            _status.text = @"No Match";
        }
    }
    @catch(NSError *error){
        _status.text = [error localizedFailureReason];
    }
    
}
@end
