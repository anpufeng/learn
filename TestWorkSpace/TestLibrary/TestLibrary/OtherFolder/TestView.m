//
//  TestView.m
//  TestLibrary
//
//  Created by xuqing on 15/5/27.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import "TestView.h"
#import "UIView+Toast.h"

@implementation TestView

- (void)showToast {
#warning 'dfdfdfd'
    NSLog(@"showToast");
    [self makeToast:@"maketoast" duration:10 position:@"center"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
