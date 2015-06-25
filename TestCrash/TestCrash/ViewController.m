//
//  ViewController.m
//  TestCrash
//
//  Created by xuqing on 15/6/23.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import "ViewController.h"




//int my_close(int fd) {
//    printf("Calling real close(%d)\n", fd);
//    return orig_close(fd);
//}
//
//int my_open(const char *path, int oflag, ...) {
//    va_list ap = {0};
//    mode_t mode = 0;
//    
//    if ((oflag & O_CREAT) != 0) {
//        // mode only applies to O_CREAT
//        va_start(ap, oflag);
//        mode = va_arg(ap, int);
//        va_end(ap);
//        printf("Calling real open('%s', %d, %d)\n", path, oflag, mode);
//        return orig_open(path, oflag, mode);
//    } else {
//        printf("Calling real open('%s', %d)\n", path, oflag);
//        return orig_open(path, oflag, mode);
//    }
//}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    

    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
