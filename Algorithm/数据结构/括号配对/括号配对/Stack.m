//
//  Stack.m
//  括号配对
//
//  Created by ethan on 15/7/4.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import "Stack.h"

@interface Stack ()

@property (strong, nonatomic) NSMutableArray *stackList;

@end

@implementation Stack

- (NSMutableArray *)stackList {
    if (!_stackList) {
        _stackList = [[NSMutableArray alloc] init];
    }
    
    return _stackList;
}

- (BOOL)isEmpty {
    return ![self.stackList count];
}

- (void)makeEmpty {
    if (![self isEmpty]) {
        [self.stackList removeAllObjects];
    }
}

- (id)top {
    if ([self isEmpty]) {
        return nil;
    } else {
        return [self.stackList lastObject];
    }
}

- (id)topAndPop {
    if ([self isEmpty]) {
        return nil;
    } else {
        id last = [[self.stackList lastObject] copy];
        [self.stackList removeLastObject];
        return last;
    }
}

- (void)pop {
    if (![self isEmpty]) {
        [self.stackList removeLastObject];
    }
}

- (void)push:(id)anObject {
    [self.stackList addObject:anObject];
}


- (BOOL)shouldPop:(id)input {
    if ([input isKindOfClass:[NSNumber class]]) {
        NSNumber *top = [self top];
        NSNumber *newInput = (NSNumber *)input;
        if (top.charValue == '(' && newInput.charValue == ')') {
            return YES;
        } else if (top.charValue == '[' && newInput.charValue == ']') {
            return YES;
        }
        
        return NO;
    }
   
    return NO;
}

@end
