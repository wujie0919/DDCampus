//
//  DDHelpView.m
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHelpView.h"

@implementation DDHelpView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
  
    //折行
    _daanLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    //必须写，否则只显示一行
    [_daanLabel setNumberOfLines:0];
}
- (void)setData:(NSDictionary *)dic
{
    _valueLabel.text = dic[@"title"];
    _valueLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH, 20);
    NSMutableAttributedString *content = [NSMutableAttributedString new];
    NSAttributedString *body = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:",dic[@"body"]] attributes:@{
                                                                                                                                          NSFontAttributeName:_daanLabel.font
                                                                                                                                          }];
    [content appendAttributedString:body];
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    _daanLabel.attributedText = content;
    _daanLabel.frame = CGRectMake(10, 40, textSize.width, textSize.height);
    _height = textSize.height+50;
   
}
@end
