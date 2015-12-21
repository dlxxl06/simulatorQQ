//
//  coreDataManager.h
//  simulatorQQ
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AppDelegate.h"

@interface coreDataManager : NSObject
@property (nonatomic,readonly,strong) NSManagedObjectContext *managedObjectContext;
-(NSManagedObjectContext *)SharedObjectContext;
-(BOOL)insertUserAccount:(int64_t )idnum pwd:(NSString *)pwd;
-(NSArray *)queryObject;
@end
