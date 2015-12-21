//
//  User.h
//  simulatorQQ
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * idnum;
@property (nonatomic, retain) NSString * pwd;
@end
