//
//  DDPublishNoticeController.m
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDPublishNoticeController.h"
#import "DDSelectClassActionView.h"
#import "DDRoutineSelectStudentModel.h"

@interface DDPublishNoticeController ()<UITextViewDelegate>
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@property (nonatomic, strong) DDRoutineSelectStudentModel *studentModel;
@property (nonatomic, strong) NSMutableArray *idArray;
@end

@implementation DDPublishNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.navigationItem.title = @"发布通知";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClass:)];
    [_selectClassView addGestureRecognizer:tap];
}
- (void)selectClass:(UITapGestureRecognizer *)recognizer
{
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:appDelegate.classArray handler:^(NSMutableArray *nameList) {
        NSMutableArray *nameArray = [NSMutableArray arrayWithCapacity:0];
        selfWeak.idArray = [NSMutableArray arrayWithCapacity:0];
        for (DDRoutineSelectStudentModel *model in nameList) {
            if (model.selected) {
                [nameArray addObject:model.name];
                [selfWeak.idArray addObject:model.class_id];
            }
        }
        NSMutableString *names = [NSMutableString new];
        for (NSString *name in nameArray) {
            [names appendFormat:@"%@,",name];
        }
        if (names.length>0) {
            selfWeak.classLabel.text = [names substringToIndex:names.length-1];
        }
    } singleFlg:YES];
}
- (IBAction)publishNotice:(id)sender {
    if (![_contentView.text isValidString]) {
        [self showErrorHUD:@"请输入内容"];
        return;
    }
    
    NSMutableString *ids = [NSMutableString new];
    NSString *classallid=@"";
    for (NSString *stuId in _idArray) {
        [ids appendFormat:@"%@,",stuId];
    }
    if (ids.length>0) {
        classallid = [ids substringToIndex:ids.length-1];
    }
    if (![classallid isValidString]) {
        [self showErrorHUD:@"请选择班级"];
        return;
    }
    if (![_noticeTitleLabel.text isValidString]) {
        [self showErrorHUD:@"请输入标题"];
        return;
    }
    [self showLoadHUD:@"发布中..."];
    @WeakObj(self);
    [self Network_Post:@"do_notice"
                   tag:Do_notice_Tag
                 param:@{@"title":_noticeTitleLabel.text,
                         @"content":_contentView.text,
                         @"classallid":classallid} success:^(id result) {
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

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isValidString]) {
        _infoLabel.hidden = YES;
    }
    else
    {
        _infoLabel.hidden = NO;
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
