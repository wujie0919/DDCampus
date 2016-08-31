//
//  URTableView.m
//  Reader
//
//  Created by wujie on 10/18/10.
//  Copyright 2010 Geetouch Inc. All rights reserved.
//

#import "URTableView.h"

@implementation URTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
	CGFloat margin = floorf((frame.size.height - frame.size.width) / 2);
	CGFloat originx = frame.origin.x - margin;
	CGFloat originy = frame.origin.y + margin;
	CGRect rect = CGRectMake(originx, originy, frame.size.height, frame.size.width);
    self = [super initWithFrame:rect style:style];
    if (self) {
        [self setTransform:CGAffineTransformMakeRotation(-M_PI/2)];
    }
    return self;
}

- (void)setItemsWhenXibWithFrame:(CGRect)frame
{
    CGFloat margin = floorf((frame.size.height - frame.size.width) / 2);
    CGFloat originx = frame.origin.x - margin;
    CGFloat originy = frame.origin.y + margin;
    CGRect rect = CGRectMake(originx, originy, frame.size.height, frame.size.width);
    super.frame = rect;
    [self setTransform:CGAffineTransformMakeRotation(-M_PI/2)];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [self initWithFrame:frame style:UITableViewStylePlain])) {
        
    }
    return self;
}

@end
