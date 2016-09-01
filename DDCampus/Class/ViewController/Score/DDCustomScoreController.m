//
//  DDCustomScoreController.m
//  DDCampus
//
//  Created by Pan Lee on 16/8/31.
//  Copyright © 2016年 campus. All rights reserved.
//

#import "DDCustomScoreController.h"
#import "DDCuscomeLeftCell.h"
#import "DDCustomRightCell.h"
#import "AppDelegate.h"
#import "DDShowKouFenView.h"
#import "CustomIOS7AlertView.h"

@interface DDCustomScoreController ()<UITableViewDelegate,UITableViewDataSource>
{
    DDTableView *_leftTableView;
    DDTableView *_rightTableView;
    NSIndexPath *_leftSelectIndex;
    NSIndexPath *_rightSelectIndex;
    NSArray *_selectArray;
}

@end

@implementation DDCustomScoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBackBarButtonItem];
    
    self.title = self.type == 0?@"值周安排":@"扣分详情";
//    NSLog(@"%@---",APPD.classArray);
   
    NSMutableArray *arr = [(AppDelegate *)[UIApplication sharedApplication].delegate classArray];
    NSLog(@"%@----",arr);
    
    /**
     *  测试数据
     */
    [self test];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _leftTableView = [[DDTableView alloc] initWithFrame:CGRectMake(0, 0, 120, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_leftTableView];
    _leftTableView.backgroundColor = [UIColor clearColor];
    
    _rightTableView = [[DDTableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_leftTableView.frame), 0, SCREEN_WIDTH - CGRectGetWidth(_leftTableView.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    [self.view addSubview:_rightTableView];
    _rightTableView.backgroundColor = [UIColor whiteColor];
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
    self.view.backgroundColor = RGB(238, 238, 238);
    
    _leftSelectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    _selectArray = self.rightDataSource[0];
    [_leftTableView reloadData];
    if(self.type == 0){
        [_rightTableView setTableFooterView:[self rightFooterView]];
    }
}

- (void)test
{
    if(!self.leftDataSource){
        self.leftDataSource = [NSMutableArray arrayWithArray:@[@"学生2",@"学生3",@"学生4",@"学生5",@"学生6",@"学生7"]];
    }
    
    if(!self.rightDataSource){
        if(self.type == 0){
            self.rightDataSource = [NSMutableArray arrayWithArray:@[@[@"111",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"222",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"333",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"444",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"555",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"666",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"777",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"]]];
        }else{
            self.rightDataSource = [NSMutableArray arrayWithArray:@[@[@"111",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"222",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"333",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"444",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"555",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"666",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"],@[@"777",@"一年一班",@"一年二班",@"一年一班",@"一年三班",@"一年四班",@"一年五班"]]];
        }
    }

}

#pragma mark footerview
- (UIView *)rightFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightTableView.frame), 200)];
    
    UIButton *upper = [self buttonWithSelector:@selector(zongheClick) frame:CGRectMake(10, 10, CGRectGetWidth(_rightTableView.frame) - 20, 32) isUpper:YES title:@"综合"];
    UIButton *downer = [self buttonWithSelector:@selector(sureClick) frame:CGRectMake(10, 10 + 32 + 10, CGRectGetWidth(_rightTableView.frame) - 20, 32) isUpper:NO title:@"确认"];
    [view addSubview:upper];
    [view addSubview:downer];
    return view;
}

// 右边footerview的按钮
- (UIButton *)buttonWithSelector:(SEL)selector frame:(CGRect)rect isUpper:(BOOL)isUpper title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    if(isUpper){
        [button setTitleColor:RGB(104, 104, 104) forState:UIControlStateNormal];
        button.layer.borderWidth = 0.5f;

    }else{
        button.backgroundColor = RGB(63, 199, 127);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.borderWidth = 0;
    }
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}
/**
 *  综合的点击
 */
- (void)zongheClick
{
    NSLog(@"综合的点击");
}

/**
 *  确认的点击
 */
- (void)sureClick
{
    NSLog(@"确认的点击");
}

- (void)loadData
{
    [self Network_Post:@"getdutyweekset" tag:6000 param:@{@"weekplanid":@"40"} success:^(id result) {
        NSLog(@"result:%@",result);
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark
#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _leftTableView){
        return self.leftDataSource.count;
    }else{
        if(self.type == 0){
            NSInteger off = _selectArray.count % 2;
            NSInteger count = _selectArray.count /2;
            if(off == 1){
                count++;
            }
            return count;
        }else{
            return _selectArray.count;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _leftTableView){
        return 48;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _leftTableView){
        
        static NSString *cellIden = @"leftCellIden";
        DDCuscomeLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DDCuscomeLeftCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(_leftSelectIndex.row == indexPath.row){
            [cell showLine:NO];
        }
        
        [cell setItemWithData:self.leftDataSource[indexPath.row]];
        
        return cell;
    }else{
        static NSString *cellIden = @"rightCustomIden";
        DDCustomRightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if(!cell){
            cell = [[DDCustomRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(self.type == 0){
            NSInteger loc = indexPath.row * 2;
            NSInteger len = _selectArray.count > (loc + 2)?2:(_selectArray.count - loc);
            [cell showItemWithData:[_selectArray subarrayWithRange:NSMakeRange(loc, len)] andType:self.type];
        }else{
            [cell showItemWithData:_selectArray[indexPath.row] andType:self.type];
            __weak typeof(self) wslef = self;
            [cell setClickButton:^{
                [wslef showKouFenWithIndexPath:indexPath];
            }];
        }
        return cell;
    }
}

#pragma mark type=1
- (void)showKouFenWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_selectArray[indexPath.row]);
    
    DDShowKouFenView *view = [[[NSBundle mainBundle] loadNibNamed:@"DDShowKouFenView" owner:self options:nil] lastObject];
    [view showWithTitle:_selectArray[indexPath.row]];
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    alertView.useMotionEffects = YES;
    [alertView setButtonTitles:nil];
    [alertView setUseMotionEffects:true];
    [view setClickAction:^{
        [alertView close];
    }];
    
    [alertView setContainerView:view];
    [alertView show];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _leftTableView){
        [self showLeftCell:indexPath andHiddenIndex:_leftSelectIndex];
        _selectArray = self.rightDataSource[indexPath.row];
        [_rightTableView reloadData];
    }else{
        
    }
}

- (void)showLeftCell:(NSIndexPath *)indexPath andHiddenIndex:(NSIndexPath *)hiddenIndexPath
{
    DDCuscomeLeftCell *cell = [_leftTableView cellForRowAtIndexPath:hiddenIndexPath];
    [cell showLine:YES];
    
    cell = [_leftTableView cellForRowAtIndexPath:indexPath];
    [cell showLine:NO];
    _leftSelectIndex = indexPath;
    
}

- (void)showRightCell:(NSIndexPath *)indexPth

{
    
}

// 不缩进
-(void)viewDidLayoutSubviews {
    if ([_rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_rightTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_rightTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_rightTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}



@end