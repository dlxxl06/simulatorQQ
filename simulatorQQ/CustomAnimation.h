//
//  CustomAnimation.h
//  simulatorQQ
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    AnimationPresentType,
    AnimationDissmissType

}AnimationType;


@interface CustomAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (assign,nonatomic) AnimationType animationType;
@end
