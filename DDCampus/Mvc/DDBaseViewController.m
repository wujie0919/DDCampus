//
//  DDBaseViewController.m
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDBaseViewController ()

@end

@implementation DDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
}

/**
 *  设置返回按钮
 */
- (void)setBackBarButtonItem{
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self setLeftBarButtonItemWithNormalImage:[UIImage imageNamed:@"return"] highlightedImage:[UIImage imageNamed:@"return"] action:@selector(back)];
}

/**
 *  返回
 */
- (void)back{
    [self popWithAnimated:YES];
}


/**
 *  导航栏添加左侧按钮
 *
 *  @param image     图片
 *  @param tintColor 颜色
 *  @param action    事件
 */
- (void)setLeftBarButtonItemWithImage:(UIImage *)image tintColor:(UIColor *)tintColor action:(SEL)action{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = tintColor;
}

/**
 *  导航栏添加左侧按钮
 *
 *  @param normalImage      默认图片
 *  @param highlightedImage 高亮图片
 *  @param action           事件
 */
- (void)setLeftBarButtonItemWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage action:(SEL)action{
    
    CGSize imageSize = normalImage.size;
    
    UIButton *leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBackButton.frame = CGRectMake(0, 0, imageSize.width + 5, imageSize.height);
    [leftBackButton setImage:normalImage forState:UIControlStateNormal];
    [leftBackButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [leftBackButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackButton];
}

/**
 *  返回到上一个界面
 *
 *  @param animated 是否显示动画
 */
- (void)popWithAnimated:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:animated];
}


- (void)showErrorHUD:(NSString *)message
{
    [MBProgressHUD showError:message];
}

- (void)showLoadHUD:(NSString *)message
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
     [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD showWithStatus:message];
   
}

- (void)showSuccessHUD:(NSString *)message
{
    [MBProgressHUD showSuccess:message];
}

- (void)hideHUD
{
    [SVProgressHUD dismiss];
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
