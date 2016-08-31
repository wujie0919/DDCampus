//
//  DDLoginController.m
//  DDCampus
//
//  Created by Aaron on 16/8/4.
//  Copyright © 2016年 campus. All rights reserved.
//


//edgesForExtendedLayout
//extendedLayoutIncludesOpaqueBars
#import "DDLoginController.h"


@interface DDLoginController ()
@property (weak, nonatomic) IBOutlet DDTextField *userName_TextField;
@property (weak, nonatomic) IBOutlet DDButton *loginBtn;
@property (weak, nonatomic) IBOutlet DDTextField *pass_textfield;
@end

@implementation DDLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"登录";
    
    UIImageView *imageViewUserName=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 11, 20)];
    imageViewUserName.image=[UIImage imageNamed:@"icon_phone"];
    UIView *phoneLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, _userName_TextField.frame.size.height)];
    [phoneLeftView addSubview:imageViewUserName];
    _userName_TextField.leftView=phoneLeftView;
    _userName_TextField.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageViewPass=[[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 11, 18)];
    imageViewPass.image=[UIImage imageNamed:@"icon_lock"];
    UIView *passLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, _pass_textfield.frame.size.height)];
    [passLeftView addSubview:imageViewPass];
    _pass_textfield.leftView=passLeftView;
    _pass_textfield.leftViewMode=UITextFieldViewModeAlways;
}
- (IBAction)loginBtnClick:(id)sender {
    
    if (![_userName_TextField.text isValidString]) {
        [MBProgressHUD showError:@"手机号码不能为空"];
        return;
    }
    
    if (![_userName_TextField.text validatePhone]) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    if (![_pass_textfield.text isValidString]) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    _loginBtn.userInteractionEnabled = YES;

    [self showLoadHUD:nil];
    NSDictionary *params =  @{@"mobile":self.userName_TextField.text,@"pwd":self.pass_textfield.text};
    [self.view endEditing:YES];
    @WeakObj(self);
    [self Network_Post:@"login"
                   tag:Login_Tag param:params success:^(id result) {
                       
                       if ([result[@"code"]integerValue]==101) {
                           [selfWeak hideHUD];
                           [MBProgressHUD showError:result[@"message"]];
                       }
                       if ([result[@"code"]integerValue]==404) {
                           [selfWeak hideHUD];
                           [MBProgressHUD showError:result[@"message"]];
                       }
                       if ([result[@"code"]integerValue]==200) {
                           [NSTools setObject:result[@"data"][@"uid"] forKey:uid];
                           [NSTools setObject:result[@"data"][@"token"] forKey:token];
                           [selfWeak Network_Post:@"getinfo"
                                              tag:Getinfo_Tag
                                            param:nil
                                          success:^(id res) {
                                              [selfWeak hideHUD];
                                              if ([res[@"code"]integerValue]==200) {
                                                  //显示root
                                                  [NSTools setObject:@"isLogin" forKey:USER_LOGIN];
                                                  [NSTools setObject:res[@"data"] forKey:UserInfo];
                                                  appDelegate.userModel = [NSTools getUserInfo];
                                                  [appDelegate showControllerWithLoginSuccess];
                                                  NSString *class_id = [appDelegate.userModel.classallid componentsSeparatedByString:@","][0];
                                                  [NSTools setObject:class_id forKey:classid];
                                              }
                                          }
                                          failure:^(NSError *error) {
                                              [selfWeak hideHUD];
                                          }];
                       }
                   }
               failure:^(NSError *error) {
                   [selfWeak hideHUD];
                   [selfWeak showErrorHUD:@"登录失败"];
               }];
    
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

@end
