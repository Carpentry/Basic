//
//  main.m
//  BasicW
//
//  Created by 小李 on 2019/11/7.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BWGCDViewController.h"
#import <objc/runtime.h>
#import <objc/objc.h>

void testSync(void);

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    testSync();
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

void testSync(){
    NSObject *obj = [NSObject new];
    @synchronized (obj) {
        
    }
}



 
