//
//  DDScoreDetailsCollectionCell.h
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DDScoreDetailsCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)setNameValue:(NSDictionary *)dict;
@end
