//
//  DDCustomRightCell.h
//  DDCampus
//
//  Created by Pan Lee on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCustomRightCell : UITableViewCell

@property (nonatomic, copy) void(^ClickButton)();
- (void)showItemWithData:(id)data andType:(NSInteger)type;

@end
