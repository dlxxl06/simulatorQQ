//
//  coreDataManager.m
//  simulatorQQ
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "coreDataManager.h"


@implementation coreDataManager

#pragma mark 共享managedObjectContext;
-(NSManagedObjectContext *)SharedObjectContext
{

    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *dele = (AppDelegate *)[app delegate];
    return dele.managedObjectContext;
}

#pragma mark 插入数据
-(BOOL)insertUserAccount:(int64_t)idnum pwd:(NSString *)pwd
{
    _managedObjectContext = [self SharedObjectContext];
    @try {
        
            User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_managedObjectContext];
        if (user!=nil) {
            user.idnum = @(idnum);
            user.pwd = pwd;
            [_managedObjectContext save:nil];
        }
        else
         return NO;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    return YES;

}
#pragma mark 查询数据库
-(NSArray *)queryObject
{
    _managedObjectContext = [self SharedObjectContext];
    NSArray *resArr = nil;
    @try {
        NSFetchRequest *fr = [[NSFetchRequest alloc]init];
       
        NSEntityDescription *ent = [NSEntityDescription entityForName:@"User" inManagedObjectContext:_managedObjectContext];
        [fr setEntity:ent];
        
        resArr = [_managedObjectContext executeFetchRequest:fr error:nil];
        return resArr;
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    return resArr;
}
@end
