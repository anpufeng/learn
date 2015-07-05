//
//  main.m
//  括号配对
//
//  Created by ethan on 15/7/4.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"

/**
 输入
 第一行输入一个数N（0<N<=100）,表示有N组测试数据。后面的N行输入多组输入数据，
 每组输入数据都是一个字符串S(S的长度小于10000，且S不是空串），
 测试数据组数少于5组。数据保证S中只含有"[","]","(",")"四种字符
 输出
 每组输入数据的输出占一行，如果该字符串中所含的括号是配对的，则输出Yes,如果不配对则输出No
 样例输入
 3
 [(])
 (])
 ([[]()])
 样例输出
 No
 No
 Yes
 **/
#define MAX_LENGHT          10000
#define MAX_GROUP           5


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int group;
        scanf("%d", &group);
        char c;
        while ((c = getchar()) != EOF && c != '\n');
        char buff[MAX_GROUP][MAX_LENGHT] = {0};
        int i = 0;
        while (i < group) {
            fgets(buff[i],  MAX_LENGHT, stdin);
            NSLog(@"i = %d %s", i, buff[i]);
            i++;
        }
        
        ///对已输入数据处理
        Stack *stack = [[Stack alloc] init];

        int j = 0;
        for (j = 0; j < group; j++) {
            [stack makeEmpty];
            char ch;
            int offset = 0;
            while ((ch = buff[j][offset++]) && ch != '\n') {
                if (ch == '('
                    || ch == ')'
                    || ch == '['
                    || ch == ']') {
                    NSNumber *input = [NSNumber numberWithChar:ch];
                    if ([stack isEmpty]) {
                        [stack push:input];
                    } else {
                        if ([stack shouldPop:input]) {
                            [stack pop];
                        } else {
                            [stack push:input];
                        }
                    }
                } else {
                    NSLog(@"wrong input");
                }
                
            }
            if ([stack isEmpty]) {
                NSLog(@"YES");
            } else {
                NSLog(@"NO");
            }
        }
    }
    
    NSLog(@"end of program =====");
    
    return 0;
}

