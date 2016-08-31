//
//  DDHomeButtonCell.h
//  DDCampus
//
//  Created by wu on 16/8/22.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(NSInteger tag);
@interface DDHomeButtonCell : UITableViewCell
@property (nonatomic, copy) ButtonClickBlock bcBlock;
-(void)setTitleDataSource:(NSArray <NSString *> *)titleData withImageData:(NSArray <UIImage *> *)imageArray;
@end
