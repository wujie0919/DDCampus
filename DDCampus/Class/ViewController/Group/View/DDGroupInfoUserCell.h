//
//  DDGroupInfoUserCell.h
//  DDCampus
//
//  Created by wu on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGroupInfoUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
- (void)setInfo:(NSDictionary *)data;
@end
