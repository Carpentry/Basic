//
//  BWBasicCategoryModel.m
//  BasicW
//
//  Created by 小李 on 2019/11/13.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "BWBasicCategoryModel.h"


@implementation BWBasicCategoryModel

+ (NSArray *)arrayWithCategoryModels {
    NSDictionary *dict = @{@"className":@"BWLifeCycleViewController",@"itemName":@"Cycle"};
    NSDictionary *dict1 = @{@"className":@"BWWaveViewController",@"itemName":@"Wave"};
    NSDictionary *dict2 = @{@"className":@"BWGCDViewController",@"itemName":@"GCD"};
    NSDictionary *dict3 = @{@"className":@"TRCommonTagsViewController",@"itemName":@"Tags"};
    return [BWBasicCategoryModeIdX dictWithArray:@[dict,dict1,dict2,dict3]];
}

@end
