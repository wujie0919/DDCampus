//
//  DDCuscomeLeftCell.m
//  DDCampus
//
//  Created by Pan Lee on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCuscomeLeftCell.h"

@interface DDCuscomeLeftCell ()
{
    UILabel *line;
}
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIView *selectIcon;

@end

@implementation DDCuscomeLeftCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    line = [[UILabel alloc] init];
    line.backgroundColor = RGB(220, 220, 220);
    [self.contentView addSubview:line];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    line.frame = CGRectMake(self.contentView.frame.size.width - 0.5f, 0, 0.5f, CGRectGetHeight(self.contentView.frame));
}

- (void)showLine:(BOOL)isShow
{
    self.selectIcon.hidden = isShow;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.selectIcon.hidden = YES;
}

- (void)setItemWithData:(id)data
{
    if([data isKindOfClass:[NSDictionary class]]){
        _mainLabel.text = data[@"name"];
    }
}



@end
