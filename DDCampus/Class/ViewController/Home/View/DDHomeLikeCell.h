//
//  DDHomeLikeCell.h
//  DDCampus
//
//  Created by wu on 16/8/24.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"

@interface DDHomeLikeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zanImageView;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (nonatomic) CGFloat height;
- (void)setLikeContent:(NSString *)text showLine:(BOOL)flg;
@end
