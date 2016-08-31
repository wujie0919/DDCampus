//
//  DDFindGroupCollectionViewCell.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDFindGroupModel;


@interface DDFindGroupCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *titeButton;
- (void)setData:(DDFindGroupModel *)model;
@end
