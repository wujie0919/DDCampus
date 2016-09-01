//
//  DDShowKouFenView.m
//  DDCampus
//
//  Created by Pan Lee on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDShowKouFenView.h"

@interface DDShowKouFenView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

- (IBAction)clickAction:(id)sender;

@end

@implementation DDShowKouFenView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    self.sureButton.backgroundColor = RGB(63, 199, 127);
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureButton.layer.cornerRadius = 3;
    self.sureButton.layer.masksToBounds = YES;
    
    
    self.contentView.layer.cornerRadius = 3;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.text = nil;

}

- (void)showWithTitle:(NSString *)title
{
    self.titleLabel.text = title;
}


- (IBAction)clickAction:(id)sender {
    if(_ClickAction){
        _ClickAction();
    }
}
@end
