//
//  AddressBook+CoreDataProperties.m
//  SampleCoreData02
//
//  Created by 김성준 on 2016. 10. 28..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "AddressBook+CoreDataProperties.h"

@implementation AddressBook (CoreDataProperties)

+ (NSFetchRequest<AddressBook *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AddressBook"];
}

@dynamic address;
@dynamic dtime;
@dynamic id;
@dynamic name;
@dynamic phone;

@end
