//
//  UITableViewDataSource.h
//  SampleInput
//
//  Created by 개발자 on 2016. 10. 11..
//  Copyright © 2016년 개발자. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITableViewDataSource <NSObject>

@required

-(NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section;



@end
