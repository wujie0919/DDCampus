//
//  DDPublishHomeworkController.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDPublishHomeworkController.h"
#import "DDSelectClassActionView.h"
#import "DDRoutineSelectStudentModel.h"

@interface DDPublishHomeworkController ()<UITextViewDelegate>
{
    BOOL select;
}
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@property (nonatomic, strong) DDRoutineSelectStudentModel *studentModel;
@property (nonatomic, strong) NSMutableArray *idArray;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@end

@implementation DDPublishHomeworkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    select = NO;
    self.title= @"发布作业";
    self.view.backgroundColor = RGB(255, 252, 249);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClass:)];
    [_selectClassView addGestureRecognizer:tap];
    _infoLabel.textColor = RGB(101, 200, 126);
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

- (void)textViewDidChange:(UITextView *)textView
{
    if (![textView.text isValidString]) {
        _placLabel.hidden = NO;
    }
    else
    {
        _placLabel.hidden = YES;
    }
}

- (IBAction)agreeButton:(id)sender {
    select = !select;
    if (select) {
        [_selectView setImage:[UIImage imageNamed:@"er"]];
    }
    else
    {
        [_selectView setImage:[UIImage imageNamed:@"err"]];
    }
}
- (IBAction)publishClick:(id)sender {
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
    if (![_titleLabel.text isValidString]) {
        [self showErrorHUD:@"请输入标题"];
        return;
    }
    [self showLoadHUD:@"发布中..."];
    @WeakObj(self);
    [self Network_Post:@"do_homework"
                   tag:Do_homework_Tag
                 param:@{@"title":_titleLabel.text,
                         @"content":_contentView.text,
                         @"classallid":classallid,
                         @"dohave":@(select)} success:^(id result) {
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
