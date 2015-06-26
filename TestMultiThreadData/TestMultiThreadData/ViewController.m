//
//  ViewController.m
//  TestMultiThreadData
//
//  Created by xuqing on 15/6/25.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"
#import "Model.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_queue_t queue = kBgQueue;
    for (int i = 0; i < 100; i++) {
        
        Model *m = [[Model alloc] init];
        m.mId = [NSString stringWithFormat:@"%d", i+100];
        m.name = [NSString stringWithFormat:@"name %d", i];
        m.title = [NSString stringWithFormat:@"title %d", i];
        
//        dispatch_sync(queue, ^{
//            [[DBManager sharedInstance] insertOneModel:m];
//        });
        
        dispatch_async(queue, ^{
            [[DBManager sharedInstance] insertOneModel:m];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
