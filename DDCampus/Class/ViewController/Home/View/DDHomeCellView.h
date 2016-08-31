//
//  DDHomeCellView.h
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDImageView.h"
@class DDHomeInfoModel;

typedef void(^CommentButtonClickBlock)(NSIndexPath *index);

@interface DDHomeCellView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet DDImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UICollectionView *ImageCollection;
@property (weak, nonatomic) IBOutlet UITableView *commentTabel;
@property (nonatomic,assign) CGFloat height;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, copy) CommentButtonClickBlock cbBlock;
- (void)setData:(DDHomeInfoModel *)infoModel indexPath:(NSIndexPath *)indexPath;
- (void)hiddenCommentViewWithAnimation:(BOOL)animation;
- (void)changeUi:(BOOL)isShow animate:(BOOL)animate;
@end
