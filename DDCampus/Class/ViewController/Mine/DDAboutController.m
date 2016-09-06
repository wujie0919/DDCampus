//
//  DDAboutController.m
//  DDCampus
//
//  Created by wu on 16/9/6.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDAboutController.h"

@interface DDAboutController ()<UIAlertViewDelegate>
@property (nonatomic, copy) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *gengView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jiantouVIew;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation DDAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"关于丁丁";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _valueLabel.text = [NSString stringWithFormat:@"丁丁校园%@",app_Version];
    _valueLabel.textColor = RGB(101, 200, 126);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    [_gengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueLabel.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_equalTo(60);
    }];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gengView).offset(10);
        make.right.equalTo(self.gengView).offset(0);
        make.left.equalTo(self.gengView).offset(0);
        make.bottom.equalTo(self.gengView).offset(-10);
    }];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(0);
        make.right.equalTo(self.bgView).offset(-50);
        make.left.equalTo(self.bgView).offset(10);
        make.bottom.equalTo(self.bgView).offset(0);
    }];
    [_jiantouVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(10, 20));
    }];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(0);
        make.right.equalTo(self.bgView).offset(0);
        make.left.equalTo(self.bgView).offset(0);
        make.bottom.equalTo(self.bgView).offset(0);
    }];
    _gengView.backgroundColor = [UIColor hexString:@"#eeeeee"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateClick:(id)sender {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    @WeakObj(self);
    [self showLoadHUD:@"加载中..."];
    [self Network_Post:@"" tag:Getversionupgrade_Tag
                 param:@{@"client_type":@"2",
                         @"version_id":app_build} success:^(id result) {
                             [selfWeak hideHUD];
                             if ([result[@"code"]integerValue]==200) {
                                 selfWeak.dic = result[DataKey];
                                 if (![result[DataKey][@"version_id"]isEqualToString:app_build]) {
                                     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"更新提示" message:result[DataKey][@"upgrade_point"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                     [alertView show];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if ([_dic isKindOfClass:[NSDictionary class]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dic[@"apk_url"]]]];
        }
    }
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
