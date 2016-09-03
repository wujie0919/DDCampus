//
//  DDAgreementViewController.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDAgreementViewController.h"

@interface DDAgreementViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DDAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"服务协议";
    [self setBackBarButtonItem];
    @WeakObj(self);
    [self showLoadHUD:@"加载中..."];
    [self Network_Post:@"getagreement" tag:Getagreement_Tag
                 param:nil success:^(id result) {
                     if ([result[@"code"]integerValue]==200) {
                         selfWeak.textView.text = result[DataKey];
                     }
                     [selfWeak hideHUD];
                 } failure:^(NSError *error) {
                     [selfWeak hideHUD];
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
