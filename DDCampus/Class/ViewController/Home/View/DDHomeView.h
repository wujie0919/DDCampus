//
//  DDHomeView.h
//  DDCampus
//
//  Created by wu on 16/8/28.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDHomeView : UIView

@property (weak, nonatomic) IBOutlet DDImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *picView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
