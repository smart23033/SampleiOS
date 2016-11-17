//
//  AddressBook+CoreDataProperties.h
//  SampleCoreData02
//
//  Created by 김성준 on 2016. 10. 28..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "AddressBook+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AddressBook (CoreDataProperties)

+ (NSFetchRequest<AddressBook *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *dtime;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phone;

@end

NS_ASSUME_NONNULL_END
