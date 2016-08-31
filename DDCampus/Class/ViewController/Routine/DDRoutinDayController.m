//
//  DDRoutinDayController.m
//  DDCampus
//
//  Created by wu on 16/8/18.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutinDayController.h"
#import "DDRoutineActionView.h"
#import "DDRoutineDetailsModel.h"
#import "DDSelectClassActionView.h"
#import "DDRoutineSelectStudentModel.h"

@interface DDRoutinDayController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UITextView *studentTextView;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UIImageView *addButton;
@property (nonatomic, strong) DDRoutineActionView *actionView;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (nonatomic, strong) DDRoutineDetailsModel *detailsModel;
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@end

@implementation DDRoutinDayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"值日详情";
    [self setBackBarButtonItem];
    _detailsModel = [DDRoutineDetailsModel new];
    _addButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addClick)];
    [_addButton addGestureRecognizer:tap];
    _studentTextView.editable = NO;
//    _studentTextView.text = @"11111、222222、3333333、333333、444444、555555、666666";
    [self showLoadHUD:@"加载中..."];
    @WeakObj(self);
    [self Network_Post:@"showdutyday"
                   tag:Showdutyday_Tag
                 param:@{@"dutydayid":_dutydayid} success:^(id result) {
                     [selfWeak hideHUD];
                     if ([result[@"code"]integerValue]==200) {
                         NSDictionary *dic = result[DataKey];
                         selfWeak.detailsModel.classid = dic[@"classid"];
                         selfWeak.detailsModel.studentallid = dic[@"studentallid"];
                         selfWeak.detailsModel.remark = dic[@"remark"];
                         selfWeak.detailsModel.sort = dic[@"sort"];
                         if ([dic[@"student_id"]isKindOfClass:[NSArray class]]) {
                             selfWeak.detailsModel.student_id = [NSMutableArray arrayWithArray:dic[@"student_id"]];
                         }
                         if ([dic[@"student_name"]isKindOfClass:[NSArray class]]) {
                             selfWeak.detailsModel.student_name = [NSMutableArray arrayWithArray:dic[@"student_name"]];
                         }
                         if ([dic[@"allstudentlist"]isKindOfClass:[NSArray class]]) {
                             NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                             for (NSDictionary *dics in dic[@"allstudentlist"]) {
                                 DDRoutineSelectStudentModel *model = [DDRoutineSelectStudentModel new];
                                 model.class_id = dics[@"id"];
                                 model.name = dics[@"name"];
                                 for (NSString *stuId in selfWeak.detailsModel.student_id) {
                                     if ([stuId isEqualToString:model.class_id]) {
                                         model.selected = YES;
                                         break;
                                     }
                                 }
                                 [array addObject:model];
                             }
                             selfWeak.detailsModel.allstudentlist = array;
                             [selfWeak setData];
                         }
                     }
                     else
                     {
                         [selfWeak showErrorHUD:result[@"message"]];
                     }
                 } failure:^(NSError *error) {
                     [selfWeak hideHUD];
                     [selfWeak showErrorHUD:@"网络异常"];
                 }];
}

- (void)setData{
    _weekLabel.text = [self getWeekDay:[_detailsModel.sort integerValue]];
    NSMutableString *names = [NSMutableString new];
    for (NSString *name in _detailsModel.student_name) {
        [names appendFormat:@"%@、",name];
    }
    if (names.length>0) {
        _studentTextView.text = [names substringToIndex:names.length-1];
    }
    if ([_detailsModel.remark isValidString]) {
        _remarkLabel.hidden = YES;
        _remarkTextView.text = _detailsModel.remark;
    }
}

- (NSString*)getWeekDay:(NSInteger)sort
{
    NSString *day = @"";
    switch (sort) {
        case 1:
            day = @"周一";
            break;
        case 2:
            day = @"周二";
            break;
        case 3:
            day = @"周三";
            break;
        case 4:
            day = @"周四";
            break;
        case 5:
            day = @"周五";
            break;
        default:
            break;
    }
    return day;
}

- (void)addClick
{
    if (_detailsModel) {
        if (!_menuWindow) {
            _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        }
        @WeakObj(self);
        [_menuWindow show:self.detailsModel.allstudentlist handler:^(NSMutableArray *nameList) {
            selfWeak.detailsModel.allstudentlist = nameList;
            NSMutableArray *nameArray = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *idArray = [NSMutableArray arrayWithCapacity:0];
            for (DDRoutineSelectStudentModel *model in nameList) {
                if (model.selected) {
                    [nameArray addObject:model.name];
                    [idArray addObject:model.class_id];
                }
            }
            selfWeak.detailsModel.student_id = idArray;
            selfWeak.detailsModel.student_name = nameArray;
            [selfWeak setData];
        } singleFlg:YES];
    }
}

- (IBAction)saveClick:(id)sender {
    if (!_detailsModel) {
        return;
    }
    [self showLoadHUD:@"提交中"];
    @WeakObj(self);
    NSMutableString *ids = [NSMutableString new];
    for (NSString *stuId in _detailsModel.student_id) {
        [ids appendFormat:@"%@,",stuId];
    }
    if (ids.length>0) {
        _detailsModel.studentallid = [ids substringToIndex:ids.length-1];
    }
    NSString *remark = [_remarkTextView.text isValidString]?_remarkTextView.text:@"";
    [self Network_Post:@"do_savedutyday"
                   tag:Do_savedutyday_Tag
                 param:@{@"dutydayid":_dutydayid,
                         @"studentallid":_detailsModel.studentallid,
                         @"remark":remark} success:^(id result) {
                             [selfWeak hideHUD];
                             if ([result[@"code"]integerValue]==200) {
                                 [selfWeak showSuccessHUD:@"提交成功"];
                                 if (selfWeak.handler) {
                                     _handler();
                                 }
                                 [selfWeak.navigationController popViewControllerAnimated:YES];
                                 
                             }else
                             {
                                 [selfWeak showErrorHUD:@"提交失败"];
                             }
                         } failure:^(NSError *error) {
                             [selfWeak hideHUD];
                             [selfWeak showErrorHUD:@"网络异常"];
                         }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isValidString]) {
        _remarkLabel.hidden = YES;
    }else
    {
        _remarkLabel.hidden = NO;
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
