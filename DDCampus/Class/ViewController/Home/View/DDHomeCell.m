//
//  DDHomeCell.m
//  DDCampus
//
//  Created by wu on 16/8/22.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeCell.h"


@implementation DDHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   _homeView = [[[NSBundle mainBundle] loadNibNamed:@"DDHomeCellView" owner:nil options:nil] lastObject];
    _homeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_homeView];
}

- (void)setHomeViewFrame:(CGRect)rect
{
    [_homeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.homeView hiddenCommentViewWithAnimation:NO];
}

- (IBAction)showAll:(id)sender {
    
}



@end
