//
//  Contacts+CoreDataProperties.h
//  SampleCoreData
//
//  Created by 김성준 on 2016. 10. 27..
//  Copyright © 2016년 poppay. All rights reserved.
//

#import "Contacts+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contacts (CoreDataProperties)

+ (NSFetchRequest<Contacts *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *phone;

@end

NS_ASSUME_NONNULL_END
