//
//  DDGrounpNoticeController.m
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDGrounpNoticeController.h"

@interface DDGrounpNoticeController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *noticeTextView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation DDGrounpNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"群组通知";
}
- (IBAction)publishClick:(id)sender {
    if ([_noticeTextView.text isValidString]) {
        @WeakObj(self);
        [self Network_Post:@"do_groupnotice"
                       tag:Do_groupnotice_Tag
                     param:@{@"groupid":_groupId,
                             @"message":_noticeTextView.text} success:^(id result) {
                                 [selfWeak hideHUD];
                                 if ([result[@"code"]integerValue]==200) {
                                     [selfWeak showSuccessHUD:@"发布成功"];
                                     [selfWeak.navigationController popViewControllerAnimated:YES];
                                     
                                 }else
                                 {
                                     [selfWeak showErrorHUD:result[@"message"]];
                                 }
                             } failure:^(NSError *error) {
                                 [selfWeak hideHUD];
                                 [selfWeak showErrorHUD:@"网络异常"];
                             }];
    }
    else
    {
        [self showErrorHUD:@"请输入通知内容"];
    }
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
