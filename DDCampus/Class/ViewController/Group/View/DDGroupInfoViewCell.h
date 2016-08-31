//
//  DDGroupInfoViewCell.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGroupInfoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
- (void)setInfo:(NSString *)text;
@end
