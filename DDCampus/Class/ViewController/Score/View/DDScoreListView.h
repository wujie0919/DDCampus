//
//  DDScoreListView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellHeightBlock)(CGFloat height);

@interface DDScoreListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *scoreTable;
@property (nonatomic, assign) CGFloat height;
@property (weak, nonatomic) IBOutlet UIImageView *jianView;
- (void)setData:(NSDictionary *)dic;
@end
