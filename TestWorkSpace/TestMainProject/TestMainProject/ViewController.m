//
//  ViewController.m
//  TestMainProject
//
//  Created by xuqing on 15/5/27.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import "ViewController.h"
#import "TestLibrary.h"
#import "OtherFolder.h"
#import "TestView.h"
#import "UIView+Toast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TestLibrary *test = [[TestLibrary alloc] init];
    [test test];
    
    OtherFolder *other = [[OtherFolder alloc] init];
    [other other];
    
    TestView *view = [[TestView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [view showToast];
    
    [self.view makeToast:@"hello" duration:20 position:@"center"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
