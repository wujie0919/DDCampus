//
//  DDCustomRightCell.m
//  DDCampus
//
//  Created by Pan Lee on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCustomRightCell.h"
#import "DDRoutineSetModel.h"

@interface DDCustomRightCell ()
{
    NSMutableArray *buttons;
    NSInteger _type;
}
@end

@implementation DDCustomRightCell

- (void)showItemWithData:(id)sourData andType:(NSInteger)type
{
    _type = type;
    if([sourData isKindOfClass:[NSArray class]]){
        NSArray * data = (NSArray *)sourData;
        for (NSInteger i = 0; i < data.count; i++) {
            DDRoutineSetModel *model = data[i];
            UIButton *button = buttons[i];
            button.hidden = NO;
            if (model.select) {
                button.backgroundColor = RGB(63, 199, 127);
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.layer.borderWidth = 0;
            }
            else
            {
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:RGB(104, 104, 104) forState:UIControlStateNormal];
                button.layer.borderWidth = 0.5f;
                
            }
            button.selected = model.select;
            [button setTitle:model.className forState:UIControlStateNormal];
        }
    }else if([sourData isKindOfClass:[DDRoutineSetModel class]]){
        DDRoutineSetModel *model = sourData;
        UIButton *button = buttons[0];
        button.hidden = NO;
        if (model.select) {
            button.backgroundColor = RGB(63, 199, 127);
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 0;
        }
        else
        {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:RGB(104, 104, 104) forState:UIControlStateNormal];
            button.layer.borderWidth = 0.5f;
            
        }
        button.selected = model.select;
        [button setTitle:model.className forState:UIControlStateNormal];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initItems];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = (self.contentView.frame.size.width - 30)/2;
    NSInteger count = 2;
    if(_type == 1){
        w = (self.contentView.frame.size.width - 20);
        count = 1;
    }
    
    for (int i = 0; i < count; i++) {
        CGRect rect = CGRectMake(10 + (w + 10) * i, 7, w, 32);
        UIButton *button = buttons[i];
        button.frame = rect;
    }
}

- (void)initItems
{
    buttons = [NSMutableArray arrayWithCapacity:2];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:button];
        button.hidden = YES;
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = 3;
        button.layer.borderColor = RGB(104, 104, 104).CGColor;
        [button setTitleColor:RGB(104, 104, 104) forState:UIControlStateNormal];
        button.layer.borderWidth = 0.5f;
        [buttons addObject:button];
    }
}

- (void)clickAction:(UIButton *)button
{
    if(_type == 0){
        if (button.selected) {
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:RGB(104, 104, 104) forState:UIControlStateNormal];
            button.layer.borderWidth = 0.5f;
        }
        else
        {
            button.selected = YES;
            button.backgroundColor = RGB(63, 199, 127);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 0;
        }
//        if(button.tag >= 100){
//            button.tag -= 100;
//            button.backgroundColor = [UIColor whiteColor];
//            [button setTitleColor:RGB(104, 104, 104) forState:UIControlStateNormal];
//            button.layer.borderWidth = 0.5f;
//            
//        }else{
//            button.tag += 100;
//            button.backgroundColor = RGB(63, 199, 127);
//            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            button.layer.borderWidth = 0;
//        }
        if (_RestButtonColor) {
            _RestButtonColor(button.tag,button.selected);
        }
    }else{
        if(_ClickButton){
            _ClickButton();
        }
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [buttons enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
        if(obj.tag >= 100){
            [self clickAction:obj];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
