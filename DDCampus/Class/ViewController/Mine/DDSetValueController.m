//
//  DDSetValueController.m
//  DDCampus
//
//  Created by wu on 16/8/10.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDSetValueController.h"

@interface DDSetValueController ()

@property (weak, nonatomic) IBOutlet DDTextField *valueText;
@end

@implementation DDSetValueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackBarButtonItem];
    self.title = @"修改昵称";

}
- (IBAction)editValueClick:(id)sender {
    if (![_valueText.text isValidString]) {
        [self showErrorHUD:@"请输入新昵称"];
        return;
    }
    [self Network_Post:@"do_savenickname"
                   tag:EditNickName_Tag
                 param:@{@"nickname":_valueText.text}
               success:^(id result) {
                   
               } failure:^(NSError *error) {
                   
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
