//
//  DDSelectClassInfoCell.h
//  DDCampus
//
//  Created by wu on 16/8/30.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectClassBlock)();

@interface DDSelectClassInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectView;
@property (nonatomic, copy) SelectClassBlock sBlock;

@end
