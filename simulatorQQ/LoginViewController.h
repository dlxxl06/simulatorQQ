//
//  LoginViewController.h
//  simulatorQQ
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIViewControllerTransitioningDelegate>

//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *UseIcon;
//帐号文本框
@property (weak, nonatomic) IBOutlet UITextField *accountTextFiled;
//密码框
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
//登录的view
@property (weak, nonatomic) IBOutlet UIView *loginView;
//线的view
@property (weak, nonatomic) IBOutlet UIImageView *lineImage;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//登录事件
- (IBAction)tapLogin;
//找回密码事件
- (IBAction)tapFindPwd;
//注册帐号事件
- (IBAction)tapRegister;

@end
