//
//  UINavigationController+Autorotate.m
//  YCBiOSClient
//
//  Created by Aaron on 16/2/2.
//  Copyright © 2016年 ycb. All rights reserved.
//

#import "UINavigationController+Autorotate.h"

@implementation UINavigationController (Autorotate)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return [self.topViewController supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

@end
