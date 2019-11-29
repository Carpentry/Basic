//
//  TRTagModel.h
//  BasicW
//
//  Created by 小李 on 2019/11/26.
//  Copyright © 2019 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TRTagModel : NSObject
@property (nonatomic, strong) NSNumber *identifier;//标签id
@property (nonatomic, copy) NSString *name;//标签名称
@property (nonatomic, assign) BOOL isChoose;//是否被选择

@end

NS_ASSUME_NONNULL_END
