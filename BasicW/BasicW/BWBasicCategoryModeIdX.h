//
//  BWBasicCategoryModeIdX.h
//  BasicW
//
//  Created by 小李 on 2019/11/13.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWBasicCategoryModeIdX : NSObject
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, strong) NSString *className;
- (instancetype)initWithDictory:(NSDictionary *)dict;
+ (NSArray *)dictWithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
