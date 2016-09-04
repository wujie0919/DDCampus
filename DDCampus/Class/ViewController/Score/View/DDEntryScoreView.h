//
//  DDEntryScoreView.h
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScoreChangeBlock)(NSString *value,NSInteger tag);

@interface DDEntryScoreView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITextField *valueText;
@property (nonatomic, copy) ScoreChangeBlock scoreBlock;
- (void)setCellData:(NSDictionary *)dic;
@end
