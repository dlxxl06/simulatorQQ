//
//  registerViewController.m
//  simulatorQQ
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "registerViewController.h"
#import "coreDataManager.h"
@interface registerViewController ()
{
    int64_t idnum;
    NSManagedObjectContext *_manageObjectContext;
    UIView *_messageView;
    UIView *_grayBack;
}
@end


@implementation registerViewController


#pragma mark 画界面的线
-(UIImage *)drawLine
{
    CGFloat lineWidth = 307;
    CGFloat lineHeight = 0.4;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(lineWidth, lineHeight), NO, 0);
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    [[UIColor grayColor]set];
    
    CGContextSetLineWidth(ctr, lineHeight);
    CGContextMoveToPoint(ctr, 0, 0);
    CGContextAddLineToPoint(ctr, lineWidth, 0);
    CGContextStrokePath(ctr);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [self drawLine];
    [_line1 setImage:image];
    [_line2 setImage:image];
    [_line3 setImage:image];
    [self.view addSubview:_line1];
    [self.view addSubview:_line2];
    [self.view addSubview:_line3];
    [_registerBtn.layer setCornerRadius:10];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:tgr];
   
    
}
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [_nameTextField resignFirstResponder];
    [_pwd2TextField resignFirstResponder];
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


- (IBAction)cancelRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerBtn:(id)sender {
    
    //取消键盘
    [_nameTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
    [_pwd2TextField resignFirstResponder];
    
    UILabel *errorLabel = [[UILabel alloc]init];
    
    //呢称为空
    if(_nameTextField.text.length == 0 )
    {
        [errorLabel setFrame:CGRectMake(_nameTextField.frame.origin.x+_nameTextField.bounds.size.width+10, _nameTextField.frame.origin.y, 150, 30)];
        [errorLabel setTextColor:[UIColor redColor]];
        [errorLabel setText:@"*呢称不能为空"];
         [errorLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.view addSubview:errorLabel];
        [UIView animateWithDuration:2.0f animations:^{
            errorLabel.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [errorLabel removeFromSuperview];
        }];
    }
    //密码为空
    else if(_pwdTextField.text.length == 0)
    {
        [errorLabel setFrame:CGRectMake(_pwdTextField.frame.origin.x+_pwdTextField.bounds.size.width+10, _pwdTextField.frame.origin.y, 150, 30)];
        [errorLabel setTextColor:[UIColor redColor]];
        [errorLabel setText:@"*密码不能为空"];
         [errorLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.view addSubview:errorLabel];
        [UIView animateWithDuration:3.0f animations:^{
            errorLabel.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [errorLabel removeFromSuperview];
        }];
        
    }
    else if (_pwd2TextField.text.length == 0)
    {
        [errorLabel setFrame:CGRectMake(_pwd2TextField.frame.origin.x+_pwd2TextField.bounds.size.width+10, _pwd2TextField.frame.origin.y, 150, 30)];
        [errorLabel setTextColor:[UIColor redColor]];
        [errorLabel setText:@"*请输入确认密码"];
        [errorLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.view addSubview:errorLabel];
        [UIView animateWithDuration:3.0f animations:^{
            errorLabel.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [errorLabel removeFromSuperview];
        }];
        
    }
    else if (![_pwd2TextField.text isEqualToString:_pwdTextField.text])
    {
        [errorLabel setFrame:CGRectMake(_pwd2TextField.frame.origin.x+_pwd2TextField.bounds.size.width+10, _pwd2TextField.frame.origin.y, 150, 30)];
        [errorLabel setTextColor:[UIColor redColor]];
        [errorLabel setText:@"*两次密码输入不相同"];
         [errorLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.view addSubview:errorLabel];
        [UIView animateWithDuration:3.0f animations:^{
            errorLabel.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [errorLabel removeFromSuperview];
        }];
        
    }
    else//成功则返回yes
    {
        idnum = 1100000001;
        coreDataManager *manager = [[coreDataManager alloc]init];
        _manageObjectContext = [manager SharedObjectContext];
        if([manager insertUserAccount:idnum pwd:_pwdTextField.text])
        {
            _grayBack = [[UIView alloc]initWithFrame:self.view.bounds];
            [_grayBack setBackgroundColor:[UIColor blackColor]];
            [_grayBack.layer setOpacity:0.3];
            [self.view addSubview:_grayBack];
            _messageView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-168, self.view.bounds.size.height/2-100, 335, 200)];
            [_messageView setBackgroundColor:[UIColor whiteColor]];
            [_messageView.layer setCornerRadius:15.0f];
            
            UILabel *successfulLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 300, 100)];
            [successfulLabel setText:[NSString stringWithFormat:@"注册成功!您的帐号是：%lld",idnum]];
            [successfulLabel setFont:[UIFont systemFontOfSize:35.0f]];
            successfulLabel.numberOfLines = 2;
            [successfulLabel setTextColor:[UIColor blackColor]];
            UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
            [confirm setFrame:CGRectMake(70, 160, 200, 30)];
            [confirm setBackgroundColor:[UIColor blueColor]];
            [confirm setTitle:@"确定" forState:UIControlStateNormal];
            [confirm.layer setCornerRadius:10.0f];
            [_messageView addSubview:successfulLabel];
            [_messageView addSubview:confirm];
            [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_messageView];
        }
    }
    

}

-(void)confirm
{
    [_grayBack removeFromSuperview];
    [_messageView removeFromSuperview];

}
@end
