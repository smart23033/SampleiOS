//
//  Contacts+CoreDataProperties.m
//  SampleCoreData
//
//  Created by 김성준 on 2016. 10. 27..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "Contacts+CoreDataProperties.h"

@implementation Contacts (CoreDataProperties)

+ (NSFetchRequest<Contacts *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contacts"];
}

@dynamic name;
@dynamic address;
@dynamic phone;

@end
