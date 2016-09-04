//
//  DDMaxScoreView.h
//  DDCampus
//
//  Created by wu on 16/9/4.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ValueChangeBlock)(NSString *value,NSInteger viewTag);

@interface DDMaxScoreView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *scoreText;
@property (weak, nonatomic) IBOutlet UILabel *manLabel;
@property (nonatomic, copy) ValueChangeBlock changeBlock;
@end
