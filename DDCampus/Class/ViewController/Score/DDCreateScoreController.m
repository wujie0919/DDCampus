//
//  DDCreateScoreController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCreateScoreController.h"
#import "DDSelectClassActionView.h"
#import "DDRoutineSelectStudentModel.h"
#import "DDSelectDateActionView.h"
#import "DDEditMaxScoreController.h"

@interface DDCreateScoreController ()
{
    BOOL select;
}
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@property (nonatomic, strong) NSMutableArray *subjectArray;
@property (nonatomic, strong) NSMutableArray *selectSubArray;
@property (nonatomic, strong) NSMutableArray *classData;
@property (nonatomic, strong) DDSelectDateActionView *dateActionView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (nonatomic, strong) NSMutableArray *quanArray;
@property (weak, nonatomic) IBOutlet UILabel *qzLabel;
@property (weak, nonatomic) IBOutlet DDView *maxView;
@property (weak, nonatomic) IBOutlet UILabel *MaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *quinfoLable;
@property (weak, nonatomic) IBOutlet UIButton *quButton;
@property (weak, nonatomic) IBOutlet UITextField *zhutiText;
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *subjectListId;
@property (nonatomic, copy) NSString *scoreList;
@end

@implementation DDCreateScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"成绩单";
    _subjectArray = [NSMutableArray array];
    _classData = [NSMutableArray array];
    _quanArray = [NSMutableArray arrayWithCapacity:0];
    _subjectArray = [NSMutableArray array];
    NSArray *array = @[@"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"1.0"];
    for (NSString *quan in array) {
        DDRoutineSelectStudentModel *model = [[DDRoutineSelectStudentModel alloc]init];
        model.class_id = quan;
        model.name = quan;
        if ([quan isEqualToString:@"1.0"]) {
            model.selected = YES;
        }
        [_quanArray addObject:model];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showClass)];
    [_classView addGestureRecognizer:tap];
    [self getteachermulti];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSubject)];
    [_sujectView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDateView)];
    [_dateView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMax)];
    [_maxView addGestureRecognizer:tap3];
}

- (void)showClass
{
    [self.view endEditing:YES];
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:self.classData handler:^(NSMutableArray *nameList) {
        if (nameList.count>0) {
            DDRoutineSelectStudentModel *model = nameList[0];
            selfWeak.classNameLabel.text = model.name;
            selfWeak.classId = model.class_id;
        }
    } singleFlg:NO];
    
}
- (IBAction)selectZong:(id)sender {
    [self.view endEditing:YES];
    select = !select;
    _selectImageView.image = [UIImage imageNamed:select?@"er":@"err"];
}
- (IBAction)quanSelect:(id)sender {
    [self.view endEditing:YES];
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:self.quanArray handler:^(NSMutableArray *nameList) {
        if (nameList.count>0) {
            DDRoutineSelectStudentModel *model = nameList[0];
            selfWeak.qzLabel.text = model.name;
        }
    } singleFlg:NO];
}

- (void)showMax
{
    [self.view endEditing:YES];
    if (_selectSubArray.count<=0) {
        [self showErrorHUD:@"请选择学科"];
        return;
    }
    DDEditMaxScoreController *maxVC = [[DDEditMaxScoreController alloc]initWithNibName:@"DDEditMaxScoreController" bundle:nil];
    maxVC.array = _selectSubArray;
    @WeakObj(self);
    maxVC.editBlock = ^(NSDictionary *dic){
        NSMutableString *string = [[NSMutableString alloc]init];
        for (NSString *value in [dic allValues]) {
            [string appendFormat:@"%@,",value];
        }
        if (string.length>0) {
            selfWeak.MaxLabel.text = [string substringToIndex:string.length-1];
        }
        
    };
    [self.navigationController pushViewController:maxVC animated:YES];
}

- (void)showSubject
{
    [self.view endEditing:YES];
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:self.subjectArray handler:^(NSMutableArray *nameList) {
        NSMutableString *string = [[NSMutableString alloc]init];
        NSMutableString *subIds = [[NSMutableString alloc]init];
        selfWeak.selectSubArray = nameList;
        for (DDRoutineSelectStudentModel *model in nameList) {
            [string appendFormat:@"%@,",model.name];
            [subIds appendFormat:@"%@,",model.class_id];
        }
        if (string.length>0) {
            selfWeak.subjectLabel.text = [string substringToIndex:string.length-1];
            selfWeak.subjectListId = [subIds substringToIndex:subIds.length-1];
        }
    } singleFlg:YES];
}
- (IBAction)createScore:(id)sender {
    [self.view endEditing:YES];
    if (![_classNameLabel.text isValidString] || [_classNameLabel.text isEqualToString:@"点击选择班级"]) {
        [self showErrorHUD:@"请选择班级"];
        return;
    }
    if (![_subjectLabel.text isValidString] || [_subjectLabel.text isEqualToString:@"点击选择科目"]) {
        [self showErrorHUD:@"请选择科目"];
        return;
    }
    
    if (![_MaxLabel.text isValidString] || [_MaxLabel.text isEqualToString:@"科目最高分（多学科用英文逗号区分）"]) {
        [self showErrorHUD:@"请输入成绩"];
        return;
    }
    if (![_zhutiText.text isValidString]) {
        [self showErrorHUD:@"请输入主题"];
        return;
    }
    if (![_dateLabel.text isValidString] || [_dateLabel.text isEqualToString:@"选择考试时间"]) {
        [self showErrorHUD:@"请选择考试时间"];
        return;
    }
    [self showLoadHUD:@"加载中..."];
    @WeakObj(self);
    [self Network_Post:@"do_scoretheme" tag:Do_scoretheme_Tag
                 param:@{@"classid":_classId,
                         @"subjectallid":_subjectListId,
                         @"fullallscore":_MaxLabel.text,
                         @"name":_zhutiText.text,
                         @"examtime":_dateLabel.text,
                         @"isjointotal":@(select),
                         @"weight":_qzLabel.text}
               success:^(id result) {
                   [selfWeak hideHUD];
                   if ([result[@"code"]integerValue]==200) {
                       [selfWeak showSuccessHUD:@"创建成功"];
                       [selfWeak.navigationController popViewControllerAnimated:YES];
                   }
                   else
                   {
                       [selfWeak showSuccessHUD:@"创建失败"];
                   }
               } failure:^(NSError *error) {
                   [selfWeak hideHUD];
                   [selfWeak showErrorHUD:@"网络异常"];
               }];
}

- (void)showDateView
{
    [self.view endEditing:YES];
    if (!_dateActionView) {
        _dateActionView = [DDSelectDateActionView actionViewWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    _dateActionView.dateBlock = ^(NSString *date){
        selfWeak.dateLabel.text = date;
    };
    [_dateActionView show];
}


- (void)getteachermulti
{
    @WeakObj(self);
    [self showLoadHUD:@"加载中"];
    [self Network_Post:@"getteachermulti" tag:Getteachermulti_Tag param:nil success:^(id result) {
        if ([result[@"code"]integerValue]==200) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            if ([result[DataKey][@"subject"]isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in result[DataKey][@"subject"]) {
                    if ([dic isKindOfClass:[NSDictionary class]]) {
                       DDRoutineSelectStudentModel *model = [[DDRoutineSelectStudentModel alloc]init];
                        model.class_id = dic[@"subjectid"];
                        model.name = dic[@"subject_name"];
                        [array addObject:model];
                    }
                }
            }
            selfWeak.subjectArray = array;
            NSMutableArray *cArray = [NSMutableArray array];
            if ([result[DataKey][@"class"]isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in result[DataKey][@"class"]) {
                    if ([dic isKindOfClass:[NSDictionary class]]) {
                        DDRoutineSelectStudentModel *model = [[DDRoutineSelectStudentModel alloc]init];
                        model.class_id = dic[@"classid"];
                        model.name = dic[@"class_name"];
                        [cArray addObject:model];
                    }
                }
            }
            selfWeak.classData = cArray;
        }
        [selfWeak hideHUD];
    } failure:^(NSError *error) {
        [selfWeak hideHUD];
    }];
}

- (void)getStudent
{
//    [self Network_Post:@"getteacherclass"
//                   tag:Getteacherclass_Tag
//                 param:nil success:^(id result) {
//                     if ([result[@"code"]integerValue]==200) {
//                         NSMutableArray *array = [NSMutableArray new];
//                         if ([result[DataKey] isKindOfClass:[NSArray class]]) {
//                             for (NSDictionary *dic in result[DataKey]) {
//                                 DDRoutineSelectStudentModel *sModel = [[DDRoutineSelectStudentModel alloc]init];
//                                 sModel.class_id = dic[@"id"];
//                                 sModel.name = dic[@"name"];
//                                 [array addObject:sModel];
//                             }
//                         }
//                         appDelegate.classArray = array;
//                     }
//                     
//                 } failure:^(NSError *error) {
//                     
//                 }];
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
