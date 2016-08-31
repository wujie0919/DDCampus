//
//  DDRoutineStudentCollectionCell.m
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDRoutineStudentCollectionCell.h"

@implementation DDRoutineStudentCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _selectButton.layer.cornerRadius = 5;
    
    _selectButton.layer.borderWidth = 1;
    
}
- (void)setValue:(DDRoutineSelectStudentModel *)model
{
    if (model.selected) {
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectButton.backgroundColor =RGB(101, 200, 126);
        _selectButton.layer.borderColor = RGB(101, 200, 126).CGColor;
        
       
    }else
    {
        _selectButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _selectButton.backgroundColor =[UIColor whiteColor];
        [_selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
     _selectButton.userInteractionEnabled = NO;
    [_selectButton setTitle:model.name forState:UIControlStateNormal];
}
@end
