//
//  DDCreateGroupController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCreateGroupController.h"

@interface DDCreateGroupController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *groupName;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation DDCreateGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"学生社区";
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isValidString]) {
        _valueLabel.hidden = YES;
    }
    else
    {
        _valueLabel.hidden = NO;
    }
}
- (IBAction)createClick:(id)sender {
    if (![_groupName.text isValidString]) {
        [self showErrorHUD:@"请输入群组名称"];
        return;
    }
    
    if (![_descTextView.text isValidString]) {
        [self showErrorHUD:@"请输入群组介绍"];
        return;
    }
    if ([_groupName.text characterLength]>10) {
        [self showErrorHUD:@"群组名称不能多于5个汉字"];
        return;
    }
    @WeakObj(self);
    [self showLoadHUD:@"创建中..."];
    [self Network_Post:@"do_savegroup"
                   tag:Do_savegroup_Tag
                 param:@{@"title":_groupName.text,
                         @"message":_descTextView.text} success:^(id result) {
                             [selfWeak hideHUD];
                             if ([result[@"code"]integerValue]==200) {
                                 [selfWeak showSuccessHUD:@"创建成功"];
                                 [selfWeak.navigationController popViewControllerAnimated:YES];
                                 
                             }else
                             {
                                 [selfWeak showErrorHUD:result[@"message"]];
                             }
                         } failure:^(NSError *error) {
                             [selfWeak hideHUD];
                             [selfWeak showErrorHUD:@"网络异常"];
                         }];}

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
