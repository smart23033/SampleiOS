//
//  ViewController.h
//  SampleCoreData02
//
//  Created by 김성준 on 2016. 10. 28..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBook+CoreDataClass.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface ListViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

