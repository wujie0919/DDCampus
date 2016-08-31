//
//  DDEditPassController.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDEditPassController.h"

@interface DDEditPassController ()
@property (weak, nonatomic) IBOutlet DDTextField *xinPassText;
@property (weak, nonatomic) IBOutlet DDTextField *sureXinPass;

@property (weak, nonatomic) IBOutlet DDTextField *oldPassText;
@end

@implementation DDEditPassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    
    self.title = @"修改密码";
}
- (IBAction)editPassClick:(id)sender {
    if (![_oldPassText.text isValidString]) {
        [self showErrorHUD:@"旧密码不能为空"];
        return;
    }
    if (![_xinPassText.text isValidString]) {
        [self showErrorHUD:@"新密码不能为空"];
        return;
    }
    if (![_sureXinPass.text isValidString]) {
        [self showErrorHUD:@"请再次确认密码"];
        return;
    }
    if (![_sureXinPass.text isEqualToString:_xinPassText.text]) {
        [self showErrorHUD:@"两次输入的密码不一致"];
        return;
    }
    [self Network_Post:@"do_saveupass"
                   tag:EditPass_Tag
                 param:@{@"oldpwd":_oldPassText.text,
                         @"newpwd":_xinPassText.text,
                         @"newpwd2":_sureXinPass.text
                         }
               success:^(id result) {
                   
               } failure:^(NSError *error) {
                   
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
