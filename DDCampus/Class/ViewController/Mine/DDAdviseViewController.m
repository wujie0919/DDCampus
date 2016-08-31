//
//  DDAdviseViewController.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDAdviseViewController.h"

@interface DDAdviseViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet DDTextView *infoTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@end

@implementation DDAdviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"反馈建议";
    [self setBackBarButtonItem];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeholder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (![textView.text isValidString]) {
        _placeholder.hidden = NO;
    }
}
- (IBAction)sendAdvise:(id)sender {
    if (![_infoTextView.text isValidString]) {
        [self showErrorHUD:@"请输入意见反馈"];
        return;
    }
    @WeakObj(self);
    [self showLoadHUD:nil];
    [self Network_Post:@"do_savefeeds"
                   tag:Advise_Tag
                 param:@{@"content":_infoTextView.text}
               success:^(id result) {
                   [selfWeak hideHUD];
               } failure:^(NSError *error) {
                   [selfWeak hideHUD];
                   [selfWeak showErrorHUD:@"提交失败"];
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
