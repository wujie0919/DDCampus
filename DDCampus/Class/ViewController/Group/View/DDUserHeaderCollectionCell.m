//
//  DDUserHeaderCollectionCell.m
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDUserHeaderCollectionCell.h"

@implementation DDUserHeaderCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setValue:(NSString *)header
{
    [_headerView getImageWithURL:[NSString stringWithFormat:@"%@%@",PicUrl,header] placeholder:@"usericon"];
}
@end
