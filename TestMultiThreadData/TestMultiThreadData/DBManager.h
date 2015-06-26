//
//  DBManager.h
//  ETImClient
//
//  Created by xuqing on 15/4/17.
//  Copyright (c) 2015年 Pingan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Model;


@interface DBManager : NSObject

+(DBManager*)sharedInstance;


- (BOOL)insertOneModel:(Model *)model;






@end
