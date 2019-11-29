
//
//  BWBlockView.m
//  BasicW
//
//  Created by 小李 on 2019/11/12.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "BWBlockView.h"

@implementation BWBlockView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.clickBlock) {
        self.clickBlock();
    }
}


- (void)dealloc {
    NSLog(@"----view dealloc");
}

- (void)doSth {
    NSLog(@"------view doSth");
}
@end
