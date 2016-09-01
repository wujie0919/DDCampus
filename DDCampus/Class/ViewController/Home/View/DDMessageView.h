//
//  DDMessageView.h
//  DDCampus
//
//  Created by wu on 16/9/1.
//  Copyright © 2016年 campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDMessageView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic ,assign) CGFloat height;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)setData:(NSDictionary *)dic;
@end
