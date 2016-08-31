//
//  DDUserHeaderCollectionCell.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDUserHeaderCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet DDImageView *headerView;
- (void)setValue:(NSString *)header;
@end
