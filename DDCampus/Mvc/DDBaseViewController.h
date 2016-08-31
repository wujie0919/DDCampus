//
//  DDBaseViewController.h
//  DDCampus
//
//  Created by wu on 16/8/8.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBaseViewController : UIViewController


- (void)setBackBarButtonItem;

/**
 *  显示错误提示
 *
 *  @param message <#message description#>
 */
- (void)showErrorHUD:(NSString *)message;

/**
 *  隐藏Hud
 */
- (void)hideHUD;

/**
 *  显示HUD等待
 *
 *  @param message <#message description#>
 */
- (void)showLoadHUD:(NSString *)message;

/**
 *  显示成功提示信息
 *
 *  @param message <#message description#>
 */
- (void)showSuccessHUD:(NSString *)message;

@end
