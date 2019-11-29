//
//  NSMutableArray+TRTag.h
//  BasicW
//
//  Created by 小李 on 2019/11/29.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (TRTag)
- (id)safeObjectAtIndex:(NSInteger)index;
- (void)moveObjectFromIndex:(NSInteger)from
                    toIndex:(NSInteger)to;

@end

NS_ASSUME_NONNULL_END
