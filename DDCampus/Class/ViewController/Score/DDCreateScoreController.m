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

@interface DDCreateScoreController ()
{
    BOOL select;
}
@property (nonatomic, strong) DDSelectClassActionView *menuWindow;
@property (nonatomic, strong) NSMutableArray *subjectArray;
@property (nonatomic, strong) NSMutableArray *classData;
@property (nonatomic, strong) DDSelectDateActionView *dateActionView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (nonatomic, strong) NSMutableArray *quanArray;
@property (weak, nonatomic) IBOutlet UILabel *qzLabel;
@property (weak, nonatomic) IBOutlet DDView *maxView;
@property (weak, nonatomic) IBOutlet UILabel *MaxLabel;
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
}

- (void)showClass
{
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:self.classData handler:^(NSMutableArray *nameList) {
        if (nameList.count>0) {
            DDRoutineSelectStudentModel *model = nameList[0];
            selfWeak.classNameLabel.text = model.name;
        }
    } singleFlg:NO];
    
}
- (IBAction)selectZong:(id)sender {
    select = !select;
    _selectImageView.image = [UIImage imageNamed:select?@"er":@"err"];
}
- (IBAction)quanSelect:(id)sender {
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

- (void)showSubject
{
    if (!_menuWindow) {
        _menuWindow = [[DDSelectClassActionView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    @WeakObj(self);
    [_menuWindow show:self.subjectArray handler:^(NSMutableArray *nameList) {
        NSMutableString *string = [[NSMutableString alloc]init];
        for (DDRoutineSelectStudentModel *model in nameList) {
            [string appendFormat:@"%@,",model.name];
        }
        if (string.length>0) {
            selfWeak.subjectLabel.text = [string substringToIndex:string.length-1];
        }
    } singleFlg:YES];
}
- (IBAction)createScore:(id)sender {
}

- (void)showDateView
{
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
