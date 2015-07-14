//
//  ViewController.m
//  TestMultithreadingSerial
//
//  Created by ethan on 15/7/11.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self gcdGroup];
    //[self gcdSemaphore];
    //[self operationPriority];
    //[self operationDependency];
    [self operationSemaphore];
}

/**
 后面发现与要求不符 不能保证A执行完后B马上执行
 只有A所在的GROUP当中所有的任务的执行完后B才会执行   失败
 **/
- (void)gcdGroup {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        sleep(1);
        NSLog(@"task 1 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    });
    
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"task A finished in runloop : %p", [NSRunLoop currentRunLoop]);
       
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"task 2 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    });
    
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"task 3 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"task B finished in runloop : %p", [NSRunLoop currentRunLoop]);
    });
}

///GCD优先队列 失败
- (void)gcdPriority {
    dispatch_queue_t highQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    (void)highQueue;
    (void)defaultQueue;
}

- (void)gcdSemaphore {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"task 1 finished in runloop : %p", [NSRunLoop currentRunLoop]);

    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"task B finished in runloop : %p", [NSRunLoop currentRunLoop]);
        
    });
    
    dispatch_async(queue, ^{
        NSLog(@"task 2 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    });
    
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"task 3 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    });
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"task A finished in runloop : %p", [NSRunLoop currentRunLoop]);
        dispatch_semaphore_signal(semaphore);
        
    });
}

// 可能较晚执行 并不能并不能保证100% 失败
- (void)operationPriority {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 1 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 2 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *opB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task B finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    opB.queuePriority = NSOperationQueuePriorityVeryLow;
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 3 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *opA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task A finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSArray *operationArr = @[ op1, op2, opB, op3, opA ];
    [queue addOperations:operationArr waitUntilFinished:NO];
    
}

- (void)operationDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 1 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 2 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *opB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task B finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    opB.queuePriority = NSOperationQueuePriorityHigh;
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 3 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *opA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task A finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    [opB addDependency:opA];
    
    NSArray *operationArr = @[ op1, op2, opB, op3, opA ];
    [queue addOperations:operationArr waitUntilFinished:NO];
}

- (void)operationSemaphore {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(1);
        NSLog(@"task 1 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 2 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *opB = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"task B finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task 3 finished in runloop : %p", [NSRunLoop currentRunLoop]);
    }];
    
    NSBlockOperation *opA = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"task A finished in runloop : %p", [NSRunLoop currentRunLoop]);
        dispatch_semaphore_signal(semaphore);
    }];
    
    
    NSArray *operationArr = @[ op1, op2, opB, op3, opA ];
    [queue addOperations:operationArr waitUntilFinished:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
