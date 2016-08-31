//
//  DDUnSubmitValueCell.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDUnSubmitValueCell.h"

@interface DDUnSubmitValueCell ()
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *color1;
@end

@implementation DDUnSubmitValueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @WeakObj(self);
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    _font = [UIFont systemFontOfSize:12];
    _color = RGB(246, 149, 62);
    _color1 = [UIColor lightGrayColor];
}

- (void)setValueData:(NSDictionary *)dic
{
    NSMutableAttributedString *content = [NSMutableAttributedString new];
    NSAttributedString *nichName = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:",dic[@"name"]] attributes:@{
                                                                                                                                                       NSFontAttributeName:_font,
                                                                                                                                                       NSForegroundColorAttributeName:_color1
                                                                                                                                                       }];
    [content appendAttributedString:nichName];
    
    NSAttributedString *phone = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",dic[@"mobile"]] attributes:@{
                                                                                                                                          NSFontAttributeName:_font,
                                                                                                                                          NSForegroundColorAttributeName:_color
                                                                                                                                          }];
    [content appendAttributedString:phone];
    
    _valueLabel.attributedText = content;
}

@end
