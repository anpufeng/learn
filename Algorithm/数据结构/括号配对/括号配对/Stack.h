//
//  Stack.h
//  括号配对
//
//  Created by ethan on 15/7/4.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

//数组实现

@interface Stack : NSObject

- (BOOL)isEmpty;
- (void)makeEmpty;
- (id)top;
- (id)topAndPop;
- (void)pop;
- (void)push:(id)anObject;

- (BOOL)shouldPop:(id)input;
@end
