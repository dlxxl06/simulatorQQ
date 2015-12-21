//
//  CustomAnimation.m
//  simulatorQQ
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "CustomAnimation.h"

@implementation CustomAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //目地view
    UIViewController *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //添加到view上下文中
    UIView *scoundViewSnp =[toView.view snapshotViewAfterScreenUpdates:YES];
    
    [[transitionContext containerView]addSubview:scoundViewSnp];
    
    //自定义动画
    //退出的视图的动画
       // [UIView animateKeyframesWithDuration:[] delay:<#(NSTimeInterval)#> options:<#(UIViewKeyframeAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>]
    
    
      // [fromView.view.layer addAnimation:transition forKey:@"fromViewTransition"];
    //进入的视图的动画
    if (self.animationType == AnimationPresentType) {
       
        
        
        scoundViewSnp.transform= CGAffineTransformMakeScale(0, 0);
        
        //自定义动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            scoundViewSnp.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            [scoundViewSnp removeFromSuperview];
            [[transitionContext containerView]addSubview:toView.view];
            
           //过渡结束后调用
             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    else
    {
         scoundViewSnp.transform = CGAffineTransformMakeTranslation(-375, 0);
        //自定义动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            scoundViewSnp.transform =CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [scoundViewSnp removeFromSuperview];
            [[transitionContext containerView]addSubview:toView.view];
            //过渡结束后调用
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];

    
    }
}
@end
