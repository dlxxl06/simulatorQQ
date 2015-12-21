//
//  LoginViewController.m
//  simulatorQQ
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "coreDataManager.h"
#import "registerViewController.h"
#import "CustomAnimation.h"


@interface LoginViewController ()
{
    UIDynamicAnimator *_animation;
    CustomAnimation *_customAnim;
    registerViewController *_RVC;
}
@end

@implementation LoginViewController

#pragma mark 画横线
-(UIImage *)DrawGrayLine
{
    CGSize size =CGSizeMake(_loginView.bounds.size.width, 0.4);
    //配置上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    //配置颜色
    [[UIColor grayColor]set];
    //画线
    CGContextSetLineWidth(ctr, 0.4);
    CGContextMoveToPoint(ctr,0 , 0);
    CGContextAddLineToPoint(ctr, size.width, 0);
    CGContextStrokePath(ctr);
//    //获取图片
    UIImage *backgroundImage =UIGraphicsGetImageFromCurrentImageContext();
    //CGContextEndPage(ctr);
    return backgroundImage;
}

#pragma mark 从沙盒中加载用户信息
-(void)loadUserInfoFromCoreData
{
    coreDataManager *manager = [[coreDataManager alloc]init];
    NSArray *queryArr =  nil;

    queryArr = [manager queryObject];
    if (queryArr!=nil) {
        User *firstUser = [queryArr firstObject];
        [_accountTextFiled setText:[NSString stringWithFormat:@"%@",firstUser.idnum]];
        [_pwdTextField setText:firstUser.pwd];
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUserInfoFromCoreData];
    UIImage *lineImage = [self DrawGrayLine];
    [_lineImage setImage:lineImage];
    //_loginView个性化
    [_loginView.layer setBorderWidth:0.4];
    [_loginView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [_loginView.layer setCornerRadius:10];
    
    //登录个性化
    [_loginBtn.layer setCornerRadius:10];
    
    //添加手势
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesutre:)];
    [self.view addGestureRecognizer:tgr];
    
    //初始化自定义动画
    _customAnim = [[CustomAnimation alloc]init];
    _RVC = [[registerViewController alloc]init];
    _RVC.transitioningDelegate = self;
}
#pragma mark 点击手势方法
-(void)tapGesutre:(UITapGestureRecognizer *)sender
{
    [_accountTextFiled resignFirstResponder];
    [_pwdTextField resignFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapLogin {
    //在selfview创建dynamicAnimator
     _animation=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    if (_accountTextFiled.text.length == 0||_pwdTextField.text.length == 0)
    {
      //给loginView添加抖动动画
        
        //实现失败
//        CGPoint snapPoint = [_loginView center];
//        snapPoint.x-=10;
//        snapPoint.y-=10;
//        UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:_loginView snapToPoint:snapPoint];
//        [snap setDamping:0.0];
//        [_animation removeAllBehaviors];
//        [_animation addBehavior:snap];
        
        UIBezierPath *path=nil;
        //样式1
//        path = [UIBezierPath bezierPathWithRect:CGRectMake([_loginView center].x-20, [_loginView center].y-20, 40, 40)];
//        [path closePath];
        
        //样式二
        path = [UIBezierPath bezierPath];
        CGFloat centerX = _loginView.center.x;
        CGFloat centerY = _loginView.center.y;
        [path moveToPoint:CGPointMake(centerX-10, centerY)];
        [path addLineToPoint:CGPointMake(centerX+10, centerY)];
        [path closePath];
        
        CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnim.path = path.CGPath;
        moveAnim.speed = 2;
        moveAnim.repeatCount = 2;
        moveAnim.autoreverses = YES;
        
        [_loginView.layer addAnimation:moveAnim forKey:nil];
    }
    else
    {
        coreDataManager *manager = [[coreDataManager alloc]init];
        if ([manager insertUserAccount:[_accountTextFiled.text intValue] pwd:_pwdTextField.text])
            NSLog(@"插入成功");
        else NSLog(@"插入失败");
    }
}

#pragma mark UIViewcontrollerAnimiatedTransitioningDelegate


- (IBAction)tapFindPwd {
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _customAnim.animationType = AnimationPresentType;
    return _customAnim;

}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _customAnim.animationType = AnimationDissmissType;
    return _customAnim;

}
#pragma mark 自定义动画
- (IBAction)tapRegister {
    
   
    
//    //[self.view addSubview:RVC.view];
//    //[self presentViewController:RVC animated:YES completion:nil];
//   // [self addChildViewController:RVC];
//    //[RVC.view.layer addAnimation:transition forKey:nil];
//    [self showViewController:RVC sender:self];
   
    [self presentViewController:_RVC animated:YES completion:nil];
}
@end
