//
//  NSMutableArray+TRTag.m
//  BasicW
//
//  Created by 小李 on 2019/11/29.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "NSMutableArray+TRTag.h"


@implementation NSMutableArray (TRTag)
- (id)safeObjectAtIndex:(NSInteger)index {
    if (self.count > 0) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}

- (void)moveObjectFromIndex:(NSInteger)from toIndex:(NSInteger)to {
    if(to != from)
    {
        id obj = [self safeObjectAtIndex:from];
        [self removeObjectAtIndex:from];
        
        if(to >= [self count])
            [self addObject:obj];
        else
            [self insertObject:obj atIndex:to];
    }
}

@end
