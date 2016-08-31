//
//  DDHomeworkBtnView.h
//  DDCampus
//
//  Created by wu on 16/8/12.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickHandler)(NSInteger tag);

@interface DDHomeworkBtnView : UIView
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *weiButton;
@property (weak, nonatomic) IBOutlet UIButton *yiButton;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (nonatomic , copy) ButtonClickHandler clickHandler;
/**
 *  组装成button的tag
 *
 *  @param btnTag <#btnTag description#>
 */
- (void)setColorFrame:(NSInteger)btnTag;
@end
