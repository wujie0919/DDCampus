//
//  DDUnSubmitValueCell.h
//  DDCampus
//
//  Created by wu on 16/8/27.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDUnSubmitValueCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
- (void)setValueData:(NSDictionary *)dic;
@end
