//
//  DDHomeButtonCell.m
//  DDCampus
//
//  Created by wu on 16/8/22.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeButtonCell.h"
#import "DDButtonView.h"


@implementation DDHomeButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitleDataSource:(NSArray <NSString *> *)titleData withImageData:(NSArray <UIImage *> *)imageArray
{
    CGFloat width = SCREEN_WIDTH/titleData.count;
    for(int i=0;i<titleData.count;i++)
    {
        DDButtonView *buttonView = [[[NSBundle mainBundle] loadNibNamed:@"DDButtonView" owner:nil options:nil] lastObject];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addClick:)];
        buttonView.frame = CGRectMake(i*width, 0, width, CGRectGetHeight(self.frame)-10);
        buttonView.tag = i+1001;
        buttonView.iconImageView.image = imageArray[i];
        buttonView.titleLabel.text = titleData[i];
        [self addSubview:buttonView];
        [buttonView addGestureRecognizer:tap];
        NSInteger num = i+1;
        if (num<=titleData.count) {
            [self makeLineLayer:buttonView.layer lineFromPointA:CGPointMake(0, 100) toPointB:CGPointMake(0, 0)];
        }
        
    }
}

- (void)addClick:(UITapGestureRecognizer *)recognizer
{
    DDButtonView *buttonView =(DDButtonView *) recognizer.self.view;
    if (_bcBlock) {
        _bcBlock(buttonView.tag);
    }
}

-(void)makeLineLayer:(CALayer *)layer lineFromPointA:(CGPoint)pointA toPointB:(CGPoint)pointB
{
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    [linePath moveToPoint: pointA];
    [linePath addLineToPoint:pointB];
    line.path=linePath.CGPath;
    line.fillColor = nil;
    line.opacity = 1.0;
    line.strokeColor = [UIColor lightGrayColor].CGColor;
    [layer addSublayer:line];
}
@end
