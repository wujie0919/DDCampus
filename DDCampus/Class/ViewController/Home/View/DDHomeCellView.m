//
//  DDHomeCellView.m
//  DDCampus
//
//  Created by wu on 16/8/26.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDHomeCellView.h"
#import "DDHomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DDCommentCell.h"
#import "DDHomeLikeCell.h"
#import "DDHomeInfoModel.h"
#import "SDPhotoBrowser.h"

static NSString * const collectionCell = @"collectionCell";
static NSString * const commentCell = @"commentCell";
static NSString * const likeCell = @"likeCell";

@interface DDHomeCellView()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, copy) NSArray *replyArray;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *allCommentData;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIImageView *zanIV;
@property (nonatomic, strong) UILabel *zanLabel;

@property (nonatomic, strong) UIImageView *pingIV;
@property (nonatomic, strong) UILabel *pingLabel;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) UIFont *font;
@property (weak, nonatomic) IBOutlet UILabel *showAllLabel;
@end

@implementation DDHomeCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_ImageCollection registerNib:[UINib nibWithNibName:@"DDHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCell];
    [_commentTabel registerNib:[UINib nibWithNibName:@"DDCommentCell" bundle:nil] forCellReuseIdentifier:commentCell];
    [_commentTabel registerNib:[UINib nibWithNibName:@"DDHomeLikeCell" bundle:nil] forCellReuseIdentifier:likeCell];
    _commentTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentTabel.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bian3"]];
    _commentTabel.backgroundColor = [UIColor clearColor];
    _font = [UIFont systemFontOfSize:12];
}

- (void)setData:(DDHomeInfoModel *)infoModel indexPath:(NSIndexPath *)indexPath
{
    _index = indexPath;
    CGFloat cellHeight = 0;
    _picArray = NSMutableArray.new;
    _tableData = NSMutableArray.new;
    _allCommentData = NSMutableArray.new;
    //设置昵称
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PicUrl,infoModel.homeDic[@"pic"]]]];
    _headerImage.frame = CGRectMake(10, 5, 35, 35);
    _nicknameLabel.text = infoModel.homeDic[@"nickname"];
    _nicknameLabel.frame = CGRectMake(55, 5, SCREEN_WIDTH-65, 20);
    
    NSString *message = infoModel.homeDic[@"message"];
    NSMutableAttributedString *textImage = [NSMutableAttributedString new];
    textImage.yy_lineSpacing = 5;
    NSAttributedString *issueContent = [[NSAttributedString alloc]initWithString:message attributes:@{NSFontAttributeName:_font}];
    [textImage appendAttributedString:issueContent];
    CGSize textSize = [textImage boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-85, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    _contentLabel.attributedText = textImage;
    CGFloat textHeight = textSize.height;
    _contentLabel.frame= CGRectMake(55, 30, SCREEN_WIDTH-65, textHeight);
    cellHeight = textHeight+30;
    //组装回复的数据源
    if ([infoModel.homeDic[@"cklikelist"] isKindOfClass:[NSArray class]]) {
        NSArray *cklikelist=infoModel.homeDic[@"cklikelist"];
        NSMutableString *like = [NSMutableString new];
        for (NSDictionary *dic in cklikelist) {
            [like appendString:[NSString stringWithFormat:@"%@、",dic[@"nickname"]]];
        }
        if (like.length>0) {
            [_tableData addObject:[NSString stringWithFormat:@"%@%@",LikeStartValue,[like substringToIndex:like.length-1]]];
        }
    }
    
    [_allCommentData addObjectsFromArray:infoModel.homeDic[@"replylist"]];
   
    //图片的数据源
    _picArray = infoModel.imageArray;
    if (_picArray.count>0) {
        _ImageCollection.frame = CGRectMake(55, cellHeight+10, SCREEN_WIDTH-65, 75);
        _ImageCollection.hidden = NO;
        [_ImageCollection reloadData];
        cellHeight = cellHeight+ 75;
    }else{
        _ImageCollection.hidden = YES;
    }
    
    _timeLabel.frame = CGRectMake(55, cellHeight+20, 100, 20);
    _timeLabel.text = [NSDate compareWithOther:infoModel.homeDic[@"dateline"] day:NO];
    _commentButton.frame = CGRectMake(SCREEN_WIDTH-80, _timeLabel.frame.origin.y, 80, 30);
    _commentImageView.frame = CGRectMake(SCREEN_WIDTH-35, _timeLabel.frame.origin.y+2, 22, 15);
    [self configUI];
    cellHeight = cellHeight + _commentButton.frame.size.height;
    if (infoModel.isExpand) {
        //展开
        [_tableData addObjectsFromArray:_allCommentData];
        if (_tableData.count>2) {
            _commentTabel.hidden = NO;
            _commentTabel.tableFooterView = _showAllLabel;
            _showAllLabel.text = @"收起";
            _commentTabel.sectionHeaderHeight = 10;
            [_commentTabel reloadData];
            CGSize size = _commentTabel.contentSize;
            _commentTabel.frame = CGRectMake(55, _commentButton.frame.origin.y+_commentButton.frame.size.height+5, SCREEN_WIDTH-78, size.height);
            
            cellHeight = cellHeight+size.height+10;
        }
    }
    else
    {
        if (_allCommentData.count > 2) {
            [_tableData addObject:_allCommentData[0]];
            [_tableData addObject:_allCommentData[1]];
            _commentTabel.tableFooterView = _showAllLabel;
            _commentTabel.sectionHeaderHeight = 10;
        }
        else
        {
            [_tableData addObjectsFromArray:_allCommentData];
        }
        if (_tableData.count>0) {
            _commentTabel.hidden = NO;
            [_commentTabel reloadData];
            CGSize size = _commentTabel.contentSize;
            _commentTabel.frame = CGRectMake(55, _commentButton.frame.origin.y+_commentButton.frame.size.height+5, SCREEN_WIDTH-78, size.height);
            
            cellHeight = cellHeight+size.height+10;
        }
        else
        {
            _commentTabel.hidden = YES;
        }
    }
    
    _height = cellHeight+20;
}

#pragma mark - UICollectionView delegate and datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PicUrl,_picArray[indexPath.row]]]];
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(75, 75);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 1, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UITableView delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id value = _tableData[indexPath.row];
    CGFloat height = 0;
    if ([value isKindOfClass:[NSString class]] && indexPath.row ==0) {
        DDHomeLikeCell *lCell =(DDHomeLikeCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        height = lCell.height;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id value = _tableData[indexPath.row];
    if ([value isKindOfClass:[NSString class]] && indexPath.row ==0) {
        DDHomeLikeCell *lCell = [tableView dequeueReusableCellWithIdentifier:likeCell];
        lCell.backgroundColor = [UIColor clearColor];
        lCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [lCell setLikeContent:value showLine:_tableData.count>1?YES:NO];
        return lCell;
    }
    else
    {
        DDCommentCell *cCell = [tableView dequeueReusableCellWithIdentifier:commentCell];
        return cCell;
    }
}
- (IBAction)showClick:(id)sender {
    if (_cbBlock) {
        _cbBlock(_index);
    }
}

- (void)changeUi:(BOOL)isShow animate:(BOOL)animate{
    @WeakObj(self);
    CGFloat duration = 0.25;
    if(!animate){
        duration = 0;
    }
    if (isShow) {
        [UIView animateWithDuration:duration animations:^{
            self.zanIV.hidden = YES;
            self.zanLabel.hidden = YES;
            self.pingIV.hidden = YES;
            self.pingLabel.hidden = YES;
            selfWeak.showView.frame = CGRectMake(SCREEN_WIDTH-37, _timeLabel.frame.origin.y-5, 0, 30);
        }];
    }else
    {
        [UIView animateWithDuration:duration animations:^{
            selfWeak.showView.frame = CGRectMake(SCREEN_WIDTH-160, _timeLabel.frame.origin.y-5, 120, 30);
            self.zanIV.hidden = NO;
            self.zanLabel.hidden = NO;
            self.pingIV.hidden = NO;
            self.pingLabel.hidden = NO;
            self.zanIV.frame = CGRectMake(10, 8, 15, 15);
            self.zanLabel.frame = CGRectMake(27, 10, 20, 10);
            
            self.pingIV.frame = CGRectMake(self.showView.frame.size.width-45, 8, 15, 15);
            self.pingLabel.frame = CGRectMake(self.showView.frame.size.width-30, 10, 20, 10);
        }];
    }
}

- (void)hiddenCommentViewWithAnimation:(BOOL)animation{
    @WeakObj(self);
    CGFloat duration = 0.25f;
    if(!animation){
        duration = 0;
    }
    [UIView animateWithDuration:duration animations:^{
        selfWeak.zanIV.hidden = YES;
        selfWeak.zanLabel.hidden = YES;
        selfWeak.pingIV.hidden = YES;
        selfWeak.pingLabel.hidden = YES;
        selfWeak.showView.frame = CGRectMake(SCREEN_WIDTH-37, _timeLabel.frame.origin.y-5, 0, 30);
    }];
}

- (void)configUI
{
    _showView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-37, _timeLabel.frame.origin.y+2, 0, 30)];
    _showView.backgroundColor = [UIColor colorWithRed:53/255.f green:53/255.f blue:53/255.f alpha:0.8];
    _zanIV = [[UIImageView alloc]init];
    _zanIV.image = [UIImage imageNamed:@"zan"];
    [_showView addSubview:_zanIV];
    _zanLabel = [[UILabel alloc]init];
    _zanLabel.text = @"点赞";
    _zanLabel.textColor = [UIColor whiteColor];
    _zanLabel.backgroundColor = [UIColor clearColor];
    _zanLabel.font = [UIFont systemFontOfSize:10];
    [_showView addSubview:_zanLabel];
    
    _pingIV = [[UIImageView alloc]init];
    _pingIV.image = [UIImage imageNamed:@"comment"];
    [_showView addSubview:_pingIV];
    _pingLabel = [[UILabel alloc]init];
    _pingLabel.text = @"评论";
    _pingLabel.textColor = [UIColor whiteColor];
    _pingLabel.backgroundColor = [UIColor clearColor];
    _pingLabel.font = [UIFont systemFontOfSize:10];
    [_showView addSubview:_pingLabel];
    [self addSubview:_showView];
}

#pragma mark - SDPhotoBrowserDelegate

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
