//
//  main.m
//  TestCrash
//
//  Created by xuqing on 15/6/23.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include "fishhook.h"
#include <malloc/malloc.h>
#import <dlfcn.h>

static int (*orig_free)(void *);

void safe_free(void* p){
    
    size_t memSiziee=malloc_size(p);
    
    memset(p, 0x55, memSiziee);
    
    orig_free(p);
    
    return;
    
}




void save_original_symbols() {
    orig_free = dlsym(RTLD_DEFAULT, "free");
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        save_original_symbols();
        rebind_symbols((struct rebinding[1]){{"free", safe_free}}, 1);
        
        UIView *testView = [[UIView alloc] init];
        [testView release];
        [testView setNeedsLayout];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
