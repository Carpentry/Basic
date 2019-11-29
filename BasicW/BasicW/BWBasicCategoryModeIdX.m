//
//  BWBasicCategoryModeIdX.m
//  BasicW
//
//  Created by 小李 on 2019/11/13.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "BWBasicCategoryModeIdX.h"

@implementation BWBasicCategoryModeIdX
- (instancetype)initWithDictory:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSArray *)dictWithArray:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[[BWBasicCategoryModeIdX alloc] initWithDictory:dict]];
    }
    return arrayM;
}
@end
