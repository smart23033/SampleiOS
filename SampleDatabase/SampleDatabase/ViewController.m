//
//  ViewController.m
//  SampleDatabase
//
//  Created by 김성준 on 2016. 10. 27..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSString *databasePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSURL *dirPaths = [[fileMgr URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    databasePath = [[dirPaths URLByAppendingPathComponent:@"contacts.db"] path];
    
    if(![fileMgr fileExistsAtPath:databasePath]){
        
        FMDatabase *contactDB = [FMDatabase databaseWithPath:databasePath];
        
        if(contactDB == nil){
            NSLog(@"Error : %@",[contactDB lastErrorMessage]);
        }
        
        if([contactDB open]){
            NSString *sql = @"CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            
            if(![contactDB executeStatements:sql]){
                NSLog(@"Error : %@",[contactDB lastErrorMessage]);
            }
            [contactDB close];
        } else{
            NSLog(@"Error : %@",[contactDB lastErrorMessage]);
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveData:(id)sender {
    FMDatabase *contactDB = [FMDatabase databaseWithPath:databasePath];
    
    if([contactDB open]){
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO CONTACTS (name, address, phone) VALUES ('%@', '%@', '%@')",
                         _name.text,_address.text,_phone.text];
        
        BOOL result = [contactDB executeUpdate:sql withArgumentsInArray:nil];
        
        if(!result){
            _status.text = @"Failed to add contact";
            NSLog(@"Error : %@",[contactDB lastErrorMessage]);
        }else{
            _status.text = @"Contact Added";
            _name.text = @"";
            _address.text = @"";
            _phone.text = @"";
        }
    }else{
        NSLog(@"Error : %@",[contactDB lastErrorMessage]);
    }
    
}

- (IBAction)findContact:(id)sender {
    FMDatabase *contactDB = [FMDatabase databaseWithPath:databasePath];

     if([contactDB open]){
         NSString *sql = [NSString stringWithFormat:@"SELECT address, phone FROM CONTACTS WHERE NAME = '%@'",_name.text];
         
         FMResultSet *results = [contactDB executeQuery:sql withArgumentsInArray:nil];
         
         if([results next]){
             _address.text = [results stringForColumn:@"address"];
             _phone.text = [results stringForColumn:@"phone"];
             _status.text = @"Record Found";
         }else{
             _status.text = @"Record not found";
             _address.text = @"";
             _phone.text = @"";
         }
         [contactDB close];
     }else{
        NSLog(@"Error : %@",[contactDB lastErrorMessage]);
     }
}
@end
