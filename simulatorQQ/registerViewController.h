//
//  registerViewController.h
//  simulatorQQ
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface registerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *line3;
//取消
- (IBAction)cancelRegister:(id)sender;
- (IBAction)registerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
//呢称
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
//确认密码
@property (weak, nonatomic) IBOutlet UITextField *pwd2TextField;
//注册


@end
